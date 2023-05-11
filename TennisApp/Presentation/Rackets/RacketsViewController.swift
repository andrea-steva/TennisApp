//
//  RacketsViewController.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 12/02/16.
//  Copyright © 2016 Andrea Stevanato. All rights reserved.
//

import Combine
import UIKit

final class RacketsViewController: UIViewController, StoryboardInstantiable, BackgroundBlurrable, Alertable {

    // MARK: IBOutlets

    // swiftlint:disable:next private_outlet
    @IBOutlet var backgroundView: UIImageView!

    // MARK: Properties

    private var collectionView: UICollectionView!
    private var dataSource: UICollectionViewDiffableDataSource<CollectionSection, RacketViewModel>!

    private(set) var subscriptions = Set<AnyCancellable>()

    private let designLibrary: DesignLibraryProvider = DesignLibrary()

    // MARK: ViewModel

    var viewModel: RacketsViewModel!

    // MARK: View Management

    override func viewDidLoad() {
        super.viewDidLoad()

        self.backgroundView.image = UIImage(named: designLibrary.miscellaneous.asset.racketsBackground)
        self.title = Localization.Menu.rackets
        self.navigationItem.rightBarButtonItems = setupRightBarButtonItem()

        self.setBackgroundBlurEffect()

        self.setupCollectionsView()
        self.configureDataSource()

        self.setupObservers()
        self.addPullToRefresh()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        self.viewModel.fetchRackets()
    }

    private func setupRightBarButtonItem() -> [UIBarButtonItem] {
        let buttons = [
            UIBarButtonItem(title: "Add Racket", style: .plain, target: self, action: #selector(didTapOnAddRacketButton))
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

        let cellRegistration = UICollectionView.CellRegistration<RacketListCell, RacketViewModel> { (cell, _, racket) in
            let content = cell.defaultContentConfiguration()
            cell.racket = racket
            cell.contentConfiguration = content
        }

        dataSource = UICollectionViewDiffableDataSource<CollectionSection, RacketViewModel>(collectionView: collectionView,
                                                                                            cellProvider: { collectionView, indexPath, itemIdentifier in
            collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
        })
    }

    private func configureTrailingSwipeActions(indexPath: IndexPath) -> UISwipeActionsConfiguration {
        let stringsAction = UIContextualAction(style: .normal, title: nil) { (_, _, completion) in
            self.viewModel.toRacketStrings(index: indexPath.item)
            completion(true)
        }
        stringsAction.setTitle(title: "Strings", font: designLibrary.font.textNormalSize.regular)
        stringsAction.backgroundColor = .systemGray

        let editAction = UIContextualAction(style: .normal, title: nil) { (_, _, completion) in
            self.viewModel.toRacketForm(index: indexPath.item)
            completion(true)
        }
        editAction.setTitle(title: "Edit", font: designLibrary.font.textNormalSize.regular)
        editAction.backgroundColor = designLibrary.color.background.editAction

        let deleteAction = UIContextualAction(style: .destructive, title: nil) {  (_, _, completion) in
            self.showAlert(title: Localization.genericAlertTitle,
                           message: "Are you sure to delete the racket?",
                           confirmAction: { _ in
                self.viewModel.deleteRacket(forIndex: indexPath.item)
                completion(true)
            })
        }
        deleteAction.setTitle(title: "Delete", font: designLibrary.font.textNormalSize.regular)

        return UISwipeActionsConfiguration(actions: [stringsAction, editAction, deleteAction])
    }

    private func applySnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<CollectionSection, RacketViewModel>()
        snapshot.appendSections([.main])
        snapshot.appendItems(self.viewModel.getRacketViewModels())
        if snapshot.itemIdentifiers.isEmpty {
            self.collectionView.setEmptyMessage("No rackets saved", font: designLibrary.font.textNormalSize.bold)
        } else {
            self.collectionView.restore()
        }
        self.dataSource.apply(snapshot, animatingDifferences: false)
    }

    // MARK: Refresh Control

    private func addPullToRefresh() {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(pullToRefreshAction), for: .valueChanged)
        self.collectionView.refreshControl = refreshControl
    }

    @objc private func pullToRefreshAction(_ sender: AnyObject) {
        self.viewModel.fetchRackets()
    }

    // MARK: Actions

    @objc private func didTapOnAddRacketButton(_ sender: AnyObject) {
        self.viewModel.toEmptyRacketForm()
    }
}

extension RacketsViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}
