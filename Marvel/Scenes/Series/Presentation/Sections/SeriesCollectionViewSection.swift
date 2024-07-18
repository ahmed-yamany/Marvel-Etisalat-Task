//
//  SeriesCollectionViewSection.swift
//  Marvel
//
//  Created by Ahmed Yamany on 16/07/2024.
//

import CompositionalLayoutableSection
import UIKit

protocol SeriesCollectionViewSectionDelegate: AnyObject {
    func seriesCollectionViewSection(_ section: SeriesCollectionViewSection, didDisplaySectionAt index: Int)
}

// MARK: - A custom section for displaying Series in a collection view.
// Every Section represents a one series
// Section Consists of Two Cells
// cell for series card that contains "thumbnail, name, rate, year"
// expandable cell for show series more details
class SeriesCollectionViewSection: CompositionalLayoutableSection, Identifiable {
    typealias SeriesCellType = SeriesCollectionViewCell
    typealias ExpandedCellType = SeriesExpandedCollectionViewCell

    var expandableCellIndexInSection: Int = 1
    var isExpanded = false
    
    let entity: SeriesEntity
    var id: UUID { entity.id }
    weak var seriesDelegate: SeriesCollectionViewSectionDelegate?
    
    init(entity: SeriesEntity, seriesDelegate: SeriesCollectionViewSectionDelegate) {
        self.entity = entity
        self.seriesDelegate = seriesDelegate
        super.init()
        delegate = self
        dataSource = self
        sectionLayout = self
    }
}

// MARK: - Series CollectionView Section Data Source

extension SeriesCollectionViewSection: UICompositionalLayoutableSectionDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.item {
        case expandableCellIndexInSection:
            expandableCell(collectionView, at: indexPath)
        default:
            seriesCell(collectionView, at: indexPath)
        }
    }

    private func seriesCell(_ collectionView: UICollectionView, at indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(SeriesCellType.self, for: indexPath)
        cell.update(with: entity)
        return cell
    }

    private func expandableCell(_ collectionView: UICollectionView, at indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(ExpandedCellType.self, for: indexPath)
        return cell
    }
}

// MARK: - Series CollectionView Section Layout

extension SeriesCollectionViewSection: UICompositionalLayoutableSectionLayout {
    func sectionLayout(at index: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection {
        var config = UICollectionLayoutListConfiguration(appearance: .plain)
        config.showsSeparators = false
        config.backgroundColor = .mlBackground
        config.trailingSwipeActionsConfigurationProvider  = trailingSwipeActionsConfigurationProvider
        return NSCollectionLayoutSection.list(using: config, layoutEnvironment: layoutEnvironment)
    }
    
    private func trailingSwipeActionsConfigurationProvider(_ indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        guard  indexPath.item != expandableCellIndexInSection else { return nil}
        let favouriteAction = favouriteContextualAction(at: indexPath)
        return UISwipeActionsConfiguration(actions: [favouriteAction])
    }
    
    private func favouriteContextualAction(at indexPath: IndexPath) -> UIContextualAction {
        let action = UIContextualAction(style: .normal, title: nil, handler: {contextAction, view, completion in
            view.backgroundColor = .red
            print("done")
            completion(true)
        })
        action.backgroundColor = .mlGold
        action.image = UIImage(systemName: "star.fill")
        return action
    }
}

// MARK: - Series CollectionView Section Delegate

extension SeriesCollectionViewSection: UICompositionalLayoutableSectionDelegate {
    func registerCell(in collectionView: UICollectionView) {
        collectionView.registerFromNib(SeriesCellType.self)
        collectionView.registerFromNib(ExpandedCellType.self)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let expandedCellIndexPath = IndexPath(row: expandableCellIndexInSection, section: indexPath.section)

        guard let cellToExpand = collectionView.cellForItem(at: expandedCellIndexPath) as? ExpandedCellType else {
            Logger.log(
                "Failed to Down Cast UICollectionViewCell to \(ExpandedCellType.identifier)",
                category: \.default,
                level: .fault
            )
            return
        }

        isExpanded.toggle()
        cellToExpand.isExpanded = isExpanded
        collectionView.reloadItems(at: [expandedCellIndexPath])
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        seriesDelegate?.seriesCollectionViewSection(self, didDisplaySectionAt: indexPath.section)
    }
}
