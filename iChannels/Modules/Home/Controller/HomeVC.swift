//
//  Created by Essam Mohamed Fahmi.
//

import JEKScrollableSectionCollectionViewLayout

class HomeVC: BaseVC
{
    // MARK:- Outlets
    
    @IBOutlet var newEpisodesCollectionView: UICollectionView!
    @IBOutlet weak var newEpisodesCollectionViewHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet var episodesCollectionView: UICollectionView!
    @IBOutlet weak var episodesCollectionViewHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet var categoriesCollectionView: UICollectionView!
    @IBOutlet weak var categoriesCollectionViewHeightConstraint: NSLayoutConstraint!
        
    // MARK:- Properties
    
    enum collectionViewLayoutProperties
    {
        static let hSpaceBetweenTwoCells: CGFloat = 20.0
        static let vSpaceBetweenTwoCells: CGFloat = 20.0
        static let sectionLeftSpace: CGFloat = 10.0
        static let sectionRightSpace: CGFloat = 10.0
        static let sectionTopSpace: CGFloat = 10.0
        static let sectionBottomSpace: CGFloat = 10.0
    }
    
    var interactor: HomeInteractorDelegate?
    
    // MARK:- View Controller Life Cycle
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        setup()
    }
    
    // MARK:- Private Methods
    
    private func setup()
    {
        registerCells()
        registerHeaders()
        
        setupNewEpisodesCollectionView()
        setupCategoriesCollectionView()
        setupEpisodesCollectionView()
        
        interactor?.getNewEpisodes()
        interactor?.getEpisodes()
        interactor?.getCategories()
    }
    
    private func registerCells()
    {
        newEpisodesCollectionView.register(cell: NewEpisodeCollectionViewCell.self)
        categoriesCollectionView.register(cell: CategoryCollectionViewCell.self)
        episodesCollectionView.register(cell: EpisodeCollectionViewCell.self)
    }
    
    private func registerHeaders()
    {
        episodesCollectionView.registerHeader(header: ChannelSectionHeader.self)
    }
    
    private func setupNewEpisodesCollectionView()
    {
        setupNewEpisodesCollectionLayout()
        newEpisodesCollectionView.delegate = self
        newEpisodesCollectionViewHeightConstraint.constant = 0.0
    }
    
    private func setupCategoriesCollectionView()
    {
        categoriesCollectionView.delegate = self
        categoriesCollectionViewHeightConstraint.constant = 0.0
    }
    
    private func setupEpisodesCollectionView()
    {
        setupEpisodesCollectionLayout()
        episodesCollectionView.delegate = self
        episodesCollectionViewHeightConstraint.constant = 0.0
    }
    
    private func setupNewEpisodesCollectionLayout()
    {
        let layout = JEKScrollableSectionCollectionViewLayout()
        newEpisodesCollectionView.collectionViewLayout = layout
    }
    
    private func setupEpisodesCollectionLayout()
    {
        let layout = JEKScrollableSectionCollectionViewLayout()
        layout.headerReferenceSize = CGSize(width: 0, height: 80)
        episodesCollectionView.collectionViewLayout = layout
    }
    
    private func setNewEpisodesCollectionViewHeight()
    {
        let contentHeight = newEpisodesCollectionView.contentSize.height
        newEpisodesCollectionViewHeightConstraint.constant = contentHeight
    }
    
    private func setCategoriesCollectionViewHeight()
    {
        let contentHeight = categoriesCollectionView.contentSize.height
        categoriesCollectionViewHeightConstraint.constant = contentHeight
    }
    
    private func setEpisodesCollectionViewHeight()
    {
        let contentHeight = episodesCollectionView.collectionViewLayout.collectionViewContentSize.height
        episodesCollectionViewHeightConstraint.constant = contentHeight
    }
    
    // MARK:- Public Methods
    
    func refreshNewEpisodesCollectionView()
    {
        newEpisodesCollectionView.reloadData()
        view.layoutIfNeeded()
        setNewEpisodesCollectionViewHeight()
    }
    
    func refreshCategoriesCollectionView()
    {
        categoriesCollectionView.reloadData()
        view.layoutIfNeeded()
        setCategoriesCollectionViewHeight()
    }
    
    func refreshEpisodesCollectionView()
    {
        episodesCollectionView.reloadData()
        view.layoutIfNeeded()
        setEpisodesCollectionViewHeight()
    }
}

