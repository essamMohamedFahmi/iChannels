//
//  Created by Essam Mohamed Fahmi.
//

import Foundation

class HomePresenter: HomePresenterDelegate
{
    // MARK:- Properties
    
    weak var view: HomeViewDelegate?
    
    private var newEpisodesDataSource: CollectionViewDataSource<NewEpisodeViewModel, NewEpisodeCollectionViewCell>!
    
    private var episodesDataSource: MultiSectionCollectionViewDataSource<EpisodeViewModel, ChannelViewModel, EpisodeCollectionViewCell, ChannelSectionHeader>!
    
    private var categoriesDataSource: CollectionViewDataSource<CategoryViewModel, CategoryCollectionViewCell>!
    
    // MARK:- Methods
    
    func error(_ error: Error)
    {
        view?.display(message: error.localizedDescription)
    }
    
    func didReceiveNewEpisodes(_ newEpisodes: [Media])
    {
        let newEpisodesViewModels = newEpisodes.compactMap
        { (newEpisode: Media) -> NewEpisodeViewModel? in
            return newEpisode.toNewEpisodeViewModel()
        }
        
        newEpisodesDataSource = CollectionViewDataSource(models: newEpisodesViewModels)
        view?.displayNewEpisodes(from: newEpisodesDataSource)
    }
    
    func didReceiveChannels(_ channels: [Channel])
    {
        let episodesViewModels = channels.compactMap { (channel: Channel) -> [EpisodeViewModel]? in
            let episodes = channel.latestMedia?.compactMap
            { (media: LatestMedia) -> EpisodeViewModel? in
                return media.toEpisodeViewModel()
            }
            return episodes
        }
        
        let sections = channels.compactMap { (channel: Channel) -> ChannelViewModel? in
            let channelViewModel = channel.toChannelViewModel()
            return channelViewModel
        }
        
        episodesDataSource = MultiSectionCollectionViewDataSource(models: episodesViewModels,
                                                                  sections: sections)
        view?.displayEpisodes(from: episodesDataSource)
    }
    
    func didReceiveCategories(_ categories: [Category])
    {
        let categoriesViewModels = categories.compactMap
        { (category: Category) -> CategoryViewModel? in
            return category.toCategoryViewModel()
        }
        
        categoriesDataSource = CollectionViewDataSource(models: categoriesViewModels)
        view?.displayCategories(from: categoriesDataSource)
    }
}
