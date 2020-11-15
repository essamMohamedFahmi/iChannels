//
//  MultiSectionCollectionViewDataSource.swift
//  iChannels
//
//  Created by Essam Mohamed Fahmi on 11/15/20.
//

import UIKit

class MultiSectionCollectionViewDataSource<CellModel, HeaderModel, Cell: Configurable & UICollectionViewCell, Header: Configurable & UICollectionReusableView>: NSObject, UICollectionViewDataSource where Cell.Model == CellModel, Header.Model == HeaderModel
{
    // MARK: Properties
    
    private var models: [[CellModel]]
    private var sections: [HeaderModel]
    
    // MARK: Init
    
    init(models: [[CellModel]], sections: [HeaderModel])
    {
        self.models = models
        self.sections = sections
    }
    
    // MARK: Methods
    
    func numberOfSections(in collectionView: UICollectionView) -> Int
    {
        return sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return models[section].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let model = models[indexPath.section][indexPath.row]
        let cell: Cell = collectionView.dequeue(indexPath: indexPath)
        cell.configure(with: model)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView
    {
        if let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "\(Header.self)", for: indexPath) as? Header
        {
            let section = sections[indexPath.section]
            sectionHeader.configure(with: section)
            return sectionHeader
        }
        
        return UICollectionReusableView()
    }
}
