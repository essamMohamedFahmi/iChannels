//
//  SubscriptionNetworkManager.swift
//  Wajeez
//
//  Created by Essam Mohamed Fahmi on 11/12/20.
//

import Foundation

struct ChannelsNetworkManagerInjectionMap
{
    static var channelsNetworkManager: ChannelsNetworkable = ChannelsNetworkManager()
}

protocol ChannelsNetworkManagerInjected{}

extension ChannelsNetworkManagerInjected
{
    var channelsNetworkManager: ChannelsNetworkable
    {
        get
        {
            return ChannelsNetworkManagerInjectionMap.channelsNetworkManager
        }
    }
}

class ChannelsNetworkManager: ChannelsNetworkable
{
    // MARK: Properties
    
    private let moyaServiceHelper: MoyaServiceHelper<ChannelsAPI>
    
    // MARK: Init
   
    init(type: ServiceType = .live)
    {
        moyaServiceHelper = MoyaServiceHelper(type: type)
    }
    
    // MARK: Method
    
    func getNewEpisodes(completion: @escaping (Result<BaseAPIResponse<NewEpisodesResponse>, NetworkError>) -> Void)
    {
        moyaServiceHelper.request(targetCase: .getNewEpisodes, completion: completion)
    }
    
    func getChannels(completion: @escaping (Result<BaseAPIResponse<ChannelsResponse>, NetworkError>) -> Void)
    {
        moyaServiceHelper.request(targetCase: .getChannels, completion: completion)
    }
    
    func getCategories(completion: @escaping (Result<BaseAPIResponse<CategoriesResponse>, NetworkError>) -> Void)
    {
        moyaServiceHelper.request(targetCase: .getCategories, completion: completion)
    }
}
