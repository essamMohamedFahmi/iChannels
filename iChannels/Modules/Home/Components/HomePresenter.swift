//
//  Created by Essam Mohamed Fahmi.
//

import Foundation

class HomePresenter: HomePresenterDelegate
{
    // MARK:- Properties
    
    weak var view: HomeViewDelegate?
    
    private var newEpisodesDataSource: CollectionViewDataSource<NewEpisodeViewModel, NewEpisodeCollectionViewCell>!
    
    private var episodesDataSource: MultiSectionCollectionViewDataSource<ChannelViewModel, ChannelSectionHeaderViewModel, EpisodeCollectionViewCell, ChannelSectionHeader>!
    
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
        let channelsViewModels = channels.compactMap { (channel: Channel) -> [ChannelViewModel]? in
          
            if channel.isSeriesType
            {
                let series = channel.seriesSample.compactMap
                { (media: ChannelItem) -> ChannelViewModel? in
                    return media.toChannelViewModel(isSeries: true)
                }
                return series
            }
            else
            {
                let episodes = channel.episodesSample.compactMap
                { (media: ChannelItem) -> ChannelViewModel? in
                    return media.toChannelViewModel(isSeries: false)
                }
                
                return episodes
            }
        }
        
        let sections = channels.compactMap { (channel: Channel) -> ChannelSectionHeaderViewModel? in
            let channelViewModel = channel.toChannelSectionHeaderViewModel()
            return channelViewModel
        }
        
        episodesDataSource = MultiSectionCollectionViewDataSource(models: channelsViewModels,
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
