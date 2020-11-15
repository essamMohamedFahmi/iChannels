//
//  iChannels
//
//  Created by Essam Mohamed Fahmi.
//

import UIKit

class HomeInteractor: HomeInteractorDelegate
{
    // MARK:- Properties
    
    var presenter: HomePresenterDelegate?
    
    var newEpisodes: [Media] = []
    var categories: [Category] = []
    var channels: [Channel] = []

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
        presenter?.didReceiveNewEpisodes([])
    }
    
    func getEpisodes()
    {
        presenter?.didReceiveChannels([])
    }
    
    func getCategories()
    {
        presenter?.didReceiveCategories([])
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
