//
//  iChannels
//
//  Created by Essam Mohamed Fahmi.
//

import UIKit

enum NewEpisodeCell
{
    static let height = 325
    static let width = 200
}

enum EpisodeCell
{
    static let height = 315
    static let width = 200
    static let imageHeight = 300
}

enum SeriesCell
{
    static let height = 215
    static let width = 340
    static let imageHeight = 200
}

class HomeInteractor: HomeInteractorDelegate, ChannelsNetworkManagerInjected
{
    // MARK:- Properties
    
    var presenter: HomePresenterDelegate?
    
    var newEpisodes: [Media] = []
    var channels: [Channel] = []
    var categories: [Category] = []
    
    // MARK:- Methods
    
    func getNewEpisodes()
    {
        channelsNetworkManager.getNewEpisodes { [weak self] (result) in
            switch result
            {
            case let .success(response):
                let data = Array(response.data?.media?.prefix(6) ?? [])
                self?.newEpisodes = data
                self?.presenter?.didReceiveNewEpisodes(data)
            case let .failure(error):
                self?.presenter?.error(error)
            }
        }
    }
    
    func getChannels()
    {
        channelsNetworkManager.getChannels { [weak self] (result) in
            switch result
            {
            case let .success(response):
                let data = response.data?.channels ?? []
                self?.channels = data
                self?.presenter?.didReceiveChannels(data)
            case let .failure(error):
                self?.presenter?.error(error)
            }
        }
    }
    
    func getCategories()
    {
        channelsNetworkManager.getCategories { [weak self] (result) in
            switch result
            {
            case let .success(response):
                let data = response.data?.categories ?? []
                self?.categories = data
                self?.presenter?.didReceiveCategories(data)
            case let .failure(error):
                self?.presenter?.error(error)
            }
        }
    }
    
    func getSizeOfNewEpisode(at index: IndexPath) -> CGSize
    {
        guard index.row >= 0 && index.row < newEpisodes.count else
        {
            return CGSize(width: NewEpisodeCell.width, height: NewEpisodeCell.height)
        }
        
        if let newEpisode = newEpisodes[index.row].toNewEpisodeViewModel()
        {
            let episodeTitleHeight = newEpisode.title.height(constrainedWidth: CGFloat(NewEpisodeCell.width),
                                                             font: UIFont.systemFont(ofSize: 15))
            let channelTitleHeight = newEpisode.channel.height(constrainedWidth: CGFloat(NewEpisodeCell.width),
                                                               font: UIFont.systemFont(ofSize: 25))

            let height = CGFloat(NewEpisodeCell.height) + episodeTitleHeight + channelTitleHeight
            return CGSize(width: CGFloat(NewEpisodeCell.width), height: height)
        }
        
        return CGSize(width: NewEpisodeCell.width, height: NewEpisodeCell.height)
    }
    
    func getSizeOfChannelItem(at index: IndexPath) -> CGSize
    {
        let channel = channels[index.section]
        if channel.isSeriesType
        {
            if let series = channel.series?[index.row].toChannelViewModel()
            {
                let seriesTitleHeight = series.title.height(constrainedWidth: CGFloat(SeriesCell.width), font: UIFont.systemFont(ofSize: 20))
                
                let height = CGFloat(SeriesCell.height) + seriesTitleHeight
                return CGSize(width: CGFloat(SeriesCell.width), height: height)
            }
        }
        else
        {
            if let episode = channel.latestMedia?[index.row].toChannelViewModel()
            {
                let episodeTitleHeight = episode.title.height(constrainedWidth: CGFloat(EpisodeCell.width), font: UIFont.systemFont(ofSize: 20))
                
                let height = CGFloat(EpisodeCell.height) + episodeTitleHeight
                return CGSize(width: CGFloat(EpisodeCell.width), height: height)
            }
        }
        
        return CGSize(width: EpisodeCell.width, height: EpisodeCell.height)
    }
}
