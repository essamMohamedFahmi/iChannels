//
//  iChannels
//
//  Created by Essam Mohamed Fahmi.
//

import UIKit

class HomeInteractor: HomeInteractorDelegate, ChannelsNetworkManagerInjected
{
    // MARK:- Properties
    
    var presenter: HomePresenterDelegate?
    
    var newEpisodes: [Media] = []
    var channels: [Channel] = []
    var categories: [Category] = []

    enum NewEpisodeCell
    {
        static let height = 325
        static let width = 200
    }
    
    enum EpisodeCell
    {
        static let height = 310
        static let width = 200
    }
    
    // MARK:- Methods
    
    func getNewEpisodes()
    {
        channelsNetworkManager.getNewEpisodes { [weak self] (result) in
            switch result
            {
            case let .success(response):
                let data = response.data?.media ?? []
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
                                                             font: UIFont.systemFont(ofSize: 14))
            let channelTitleHeight = newEpisode.channel.height(constrainedWidth: CGFloat(NewEpisodeCell.width),
                                                               font: UIFont.systemFont(ofSize: 25))

            let height = CGFloat(NewEpisodeCell.height) + episodeTitleHeight + channelTitleHeight
            return CGSize(width: CGFloat(NewEpisodeCell.width), height: height)
        }
        
        return CGSize(width: NewEpisodeCell.width, height: NewEpisodeCell.height)
    }
    
    func getSizeOfEpisode(at index: IndexPath) -> CGSize
    {
        if let episode = channels[index.section].latestMedia?[index.row].toEpisodeViewModel()
        {
            let episodeTitleHeight = episode.title.height(constrainedWidth: CGFloat(EpisodeCell.width), font: UIFont.systemFont(ofSize: 14))
            
            let height = CGFloat(EpisodeCell.height) + episodeTitleHeight
            return CGSize(width: CGFloat(EpisodeCell.width), height: height)
        }
        
        return CGSize(width: EpisodeCell.width, height: EpisodeCell.height)
    }
}
