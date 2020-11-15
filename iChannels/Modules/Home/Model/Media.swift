//
//  Media.swift
//  iChannels
//
//  Created by Essam Mohamed Fahmi on 11/15/20.
//

import Foundation

struct Media: Codable
{
    let type: String?
    let title: String?
    let coverAsset: CoverAsset?
    let channel: Channel?

    enum CodingKeys: String, CodingKey
    {
        case type = "type"
        case title = "title"
        case coverAsset = "coverAsset"
        case channel = "channel"
    }

    init(from decoder: Decoder) throws
    {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        type = try values.decodeIfPresent(String.self, forKey: .type)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        coverAsset = try values.decodeIfPresent(CoverAsset.self, forKey: .coverAsset)
        channel = try values.decodeIfPresent(Channel.self, forKey: .channel)
    }
}

struct NewEpisodeViewModel
{
    let title: String
    let channel: String
    let imageCoverURL: String
}

extension Media
{
    func toNewEpisodeViewModel() -> NewEpisodeViewModel?
    {
        guard let title = self.title,
              let channel = self.channel?.title,
              let imageURL = self.coverAsset?.url else { return nil }
        
        return NewEpisodeViewModel(title: title, channel: channel, imageCoverURL: imageURL)
    }
}
