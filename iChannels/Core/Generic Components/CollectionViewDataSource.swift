import UIKit

protocol Configurable
{
    associatedtype Model
    func configure(with model: Model)
}

class CollectionViewDataSource<CellModel, Cell: Configurable & UICollectionViewCell>: NSObject, UICollectionViewDataSource where Cell.Model == CellModel
{
    // MARK: Properties
    
    private var models: [CellModel]
    
    // MARK: Init
    
    init(models: [CellModel])
    {
        self.models = models
    }
    
    // MARK: Methods
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        models.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let model = models[indexPath.row]
        let cell: Cell = collectionView.dequeue(indexPath: indexPath)
        cell.configure(with: model)
        return cell
    }
}
