//
//  SubscriptionNetworkable.swift
//  Wajeez
//
//  Created by Essam Mohamed Fahmi on 11/12/20.
//

import Foundation

protocol ChannelsNetworkable: class
{
    // MARK: POST Request

    func getNewEpisodes(completion: @escaping (Result<BaseAPIResponse<NewEpisodesResponse>, NetworkError>) -> Void)
    
    func getChannels(completion: @escaping (Result<BaseAPIResponse<ChannelsResponse>, NetworkError>) -> Void)
    
    func getCategories(completion: @escaping (Result<BaseAPIResponse<CategoriesResponse>, NetworkError>) -> Void)
}
