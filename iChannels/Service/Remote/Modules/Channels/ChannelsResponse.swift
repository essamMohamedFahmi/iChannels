//
//  ChannelsResponse.swift
//  iChannels
//
//  Created by Essam Mohamed Fahmi on 11/16/20.
//

import Foundation

struct CategoriesResponse: Codable
{
    let categories: [Category]?
}

struct ChannelsResponse: Codable
{
    let channels: [Channel]?
}

struct NewEpisodesResponse: Codable
{
    let media: [Media]?
}
