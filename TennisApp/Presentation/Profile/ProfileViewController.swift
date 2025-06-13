//
//  ProfileViewController.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 13/02/16.
//  Copyright © 2016 Andrea Stevanato. All rights reserved.
//

import Combine
import UIKit

final class ProfileViewController: UIViewController, StoryboardInstantiable, BackgroundBlurrable {

    // MARK: IBOutlets

    // swiftlint:disable:next private_outlet
    @IBOutlet var backgroundView: UIImageView!

    // MARK: Properties

    private(set) var subscriptions = Set<AnyCancellable>()

    private let designLibrary: DesignLibraryProvider = DesignLibrary()

    private var collectionView: UICollectionView!
    private var dataSource: UICollectionViewDiffableDataSource<CollectionSection, ProfileHeaderViewModel>!

    // MARK: ViewModel

    var viewModel: ProfileViewModel!

    // MARK: View Management

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = Localization.TabBar.profile
        self.backgroundView.image = UIImage(named: designLibrary.miscellaneous.asset.profileBackground)
        self.setBackgroundBlurEffect()

        self.setupObservers()
        self.setupCollectionsView()
        self.configureDataSource()

        self.viewModel.fetchPrimaryUser()
    }

    private func setupObservers() {
        viewModel.reloadViewData
            .sink(receiveCompletion: { _ in
                // Handle the error
            }, receiveValue: { [weak self] _ in
                self?.applySnapshot()
            })
            .store(in: &subscriptions)
    }

    // MARK: Setup collections view

    private func setupCollectionsView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createLayout())
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
        return UICollectionViewCompositionalLayout.list(using: config)
    }

    private func configureDataSource() {
        let cellRegistration = UICollectionView.CellRegistration<ProfileHeaderListCell, ProfileHeaderViewModel> { (cell, _, item) in

            let content = cell.defaultContentConfiguration()
            cell.profileHeader = item
            cell.contentConfiguration = content
        }

        dataSource = UICollectionViewDiffableDataSource<CollectionSection, ProfileHeaderViewModel>(collectionView: collectionView,
                                                                                                   cellProvider: { collectionView, indexPath, identifier in
            collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: identifier)
        })
    }

    private func applySnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<CollectionSection, ProfileHeaderViewModel>()
        snapshot.appendSections([.main])
        if let item = self.viewModel.getUserViewModel() {
            snapshot.appendItems([item])
        }
        self.dataSource.apply(snapshot, animatingDifferences: false)
    }
}
