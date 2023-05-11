//
//  StringsViewController.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 12/02/16.
//  Copyright © 2017 Andrea Stevanato. All rights reserved.
//

import Combine
import UIKit

final class StringsViewController: UIViewController, StoryboardInstantiable, Alertable, BackgroundBlurrable {

    // MARK: IBOutlets

    // swiftlint:disable:next private_outlet
    @IBOutlet var backgroundView: UIImageView!

    // MARK: Properties

    private var collectionView: UICollectionView!
    private var dataSource: UICollectionViewDiffableDataSource<CollectionSection, StringViewModel>!

    private(set) var subscriptions = Set<AnyCancellable>()

    private  let designLibrary: DesignLibraryProvider = DesignLibrary()

    // MARK: ViewModel

    var viewModel: StringsViewModel!

    // MARK: View Management

    override func viewDidLoad() {
        super.viewDidLoad()

        self.backgroundView.image = UIImage(named: designLibrary.miscellaneous.asset.stringsBackground)
        self.title = Localization.Menu.strings
        self.navigationItem.rightBarButtonItems = setupRightBarButtonItem()

        self.setupCollectionsView()
        self.configureDataSource()

        self.setBackgroundBlurEffect()
        self.setupObservers()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        self.viewModel.fetchStrings()
    }

    private func setupRightBarButtonItem() -> [UIBarButtonItem] {
        let buttons = [
            UIBarButtonItem(title: Localization.stringsAddString, style: .plain, target: self, action: #selector(didTapOnAddStringButton))
        ]
        return buttons
    }

    private func setupObservers() {
        viewModel.reloadViewData
            .sink(receiveCompletion: { _ in
                // Handle the error
            }, receiveValue: { [weak self] _ in
                guard let self else { return }

                self.collectionView.refreshControl?.endRefreshing()
                self.applySnapshot()
            })
            .store(in: &subscriptions)
    }

    // MARK: Setup collections view

    private func setupCollectionsView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createLayout())
        collectionView.delegate = self
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false

        view.addSubview(collectionView)

        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 0.0),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0.0),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0.0),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0.0)
        ])
    }

    private func createLayout() -> UICollectionViewLayout {
        var config = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        config.backgroundColor = .clear

        config.trailingSwipeActionsConfigurationProvider = { [weak self] (indexPath) in
            guard let self else { return UISwipeActionsConfiguration(actions: []) }
            return self.configureTrailingSwipeActions(indexPath: indexPath)
        }
        return UICollectionViewCompositionalLayout.list(using: config)
    }

    private func configureDataSource() {

        let cellRegistration = UICollectionView.CellRegistration<StringListCell, StringViewModel> { (cell, _, string) in
            let content = cell.defaultContentConfiguration()
            cell.string = string
            cell.contentConfiguration = content
        }

        dataSource = UICollectionViewDiffableDataSource<CollectionSection, StringViewModel>(collectionView: collectionView,
                                                                                            cellProvider: { collectionView, indexPath, itemIdentifier in
            collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
        })
    }

    private func configureTrailingSwipeActions(indexPath: IndexPath) -> UISwipeActionsConfiguration {
        let editAction = UIContextualAction(style: .normal, title: nil) {  (_, _, completion) in
            self.viewModel.toStringForm(index: indexPath.item)
            completion(true)
        }
        editAction.setTitle(title: "Edit", font: designLibrary.font.textNormalSize.regular)
        editAction.backgroundColor = designLibrary.color.background.editAction

        let deleteAction = UIContextualAction(style: .destructive, title: nil) {  (_, _, completion) in
            self.showAlert(title: Localization.genericAlertTitle,
                           message: "Are you sure to delete the string?",
                           confirmAction: { _ in
                self.viewModel.deleteString(forIndex: indexPath.item)
                completion(true)
            })
        }
        deleteAction.setTitle(title: "Delete", font: designLibrary.font.textNormalSize.regular)

        return UISwipeActionsConfiguration(actions: [editAction, deleteAction])
    }

    private func applySnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<CollectionSection, StringViewModel>()
        snapshot.appendSections([.main])
        snapshot.appendItems(self.viewModel.getStringViewModels())
        if snapshot.itemIdentifiers.isEmpty {
            self.collectionView.setEmptyMessage("No Strings saved", font: designLibrary.font.textNormalSize.bold)
        } else {
            self.collectionView.restore()
        }
        self.dataSource.apply(snapshot, animatingDifferences: false)
    }

    // MARK: IBAction

    @IBAction private func didTapOnAddStringButton(_ sender: AnyObject) {
        self.viewModel.toEmptyStringForm()
    }
}

extension StringsViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}
