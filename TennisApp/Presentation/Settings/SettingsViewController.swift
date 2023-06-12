//
//  SettingsViewController.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 13/02/16.
//  Copyright © 2016 Andrea Stevanato. All rights reserved.
//

import UIKit

final class SettingsViewController: UIViewController, StoryboardInstantiable, BackgroundBlurrable, Alertable {

    // MARK: IBActions

    // swiftlint:disable:next private_outlet
    @IBOutlet var backgroundView: UIImageView!

    // MARK: Properties

    private var collectionView: UICollectionView!
    private var dataSource: UICollectionViewDiffableDataSource<CollectionSection, SettingsItem>!

    private let designLibrary: DesignLibraryProvider = DesignLibrary()

    // MARK: ViewModel

    var viewModel: SettingsViewModelType!

    // MARK: View Management

    override func viewDidLoad() {
        super.viewDidLoad()

        self.backgroundView.image = UIImage(named: designLibrary.miscellaneous.asset.settingsBackground)
        self.title = Localization.TabBar.settings

        self.setBackgroundBlurEffect()

        self.setupCollectionsView()
        self.configureDataSource()
        self.applySnapshot()
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
        config.footerMode = .supplementary
        config.backgroundColor = .clear
        return UICollectionViewCompositionalLayout.list(using: config)
    }

    private func configureDataSource() {
        let cellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, SettingsItem> { (cell, _, item) in

            var content = cell.defaultContentConfiguration()
            content.image = UIImage(systemName: item.iconName)
            content.imageProperties.tintColor = self.designLibrary.color.text.brandPrimary
            content.text = item.title
            content.textProperties.font = self.designLibrary.font.textNormalSize.regular

            cell.contentConfiguration = content
        }

        let footerRegistration = UICollectionView.SupplementaryRegistration
        <UICollectionViewListCell>(elementKind: UICollectionView.elementKindSectionFooter) { [weak self] (footerView, _, _) in
            guard let self else { return }

            var configuration = footerView.defaultContentConfiguration()
            configuration.text = self.viewModel.getFooterText()
            configuration.textProperties.color = designLibrary.color.text.light
            configuration.textProperties.font = designLibrary.font.textNormalSize.light

            footerView.contentConfiguration = configuration
        }

        dataSource = UICollectionViewDiffableDataSource<CollectionSection, SettingsItem>(collectionView: collectionView,
                                                                                         cellProvider: { collectionView, indexPath, identifier in
            collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: identifier)
        })

        dataSource.supplementaryViewProvider = { (collectionView, _, indexPath) -> UICollectionReusableView? in
            collectionView.dequeueConfiguredReusableSupplementary(using: footerRegistration, for: indexPath)
        }
    }

    private func applySnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<CollectionSection, SettingsItem>()
        snapshot.appendSections([.main])
        snapshot.appendItems(self.viewModel.getSettings())
        self.dataSource.apply(snapshot, animatingDifferences: false)
    }

    // MARK: Logout

    private func performLogout() {
        self.showAlert(title: Localization.Generic.genericAlertTitle,
                       message: "Are you sure to want to logout?",
                       confirmAction: { _ in
            self.viewModel.performLogout(completion: nil)
        })
    }
}

extension SettingsViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        guard let settingsItem = dataSource.itemIdentifier(for: indexPath) else {
            return
        }

        switch settingsItem {
        case .general:
            break
        case .support:
            break
        case .review:
            break
        case .logout:
            performLogout()
        }
    }
}
