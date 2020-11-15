//
//  Channel.swift
//  iChannels
//
//  Created by Essam Mohamed Fahmi on 11/15/20.
//

struct Channel: Codable
{
    let title: String?
    let series: [Series]?
    let mediaCount: Int?
    let latestMedia: [LatestMedia]?
    let id: String?
    let iconAsset: IconAsset?
    let coverAsset: CoverAsset?

    enum CodingKeys: String, CodingKey
    {
        case title = "title"
        case series = "series"
        case mediaCount = "mediaCount"
        case latestMedia = "latestMedia"
        case id = "id"
        case iconAsset = "iconAsset"
        case coverAsset = "coverAsset"
    }

    init(from decoder: Decoder) throws
    {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        series = try values.decodeIfPresent([Series].self, forKey: .series)
        mediaCount = try values.decodeIfPresent(Int.self, forKey: .mediaCount)
        latestMedia = try values.decodeIfPresent([LatestMedia].self, forKey: .latestMedia)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        iconAsset = try values.decodeIfPresent(IconAsset.self, forKey: .iconAsset)
        coverAsset = try values.decodeIfPresent(CoverAsset.self, forKey: .coverAsset)
    }
}

struct LatestMedia: Codable
{
    let type: String?
    let title: String?
    let coverAsset: CoverAsset?

    enum CodingKeys: String, CodingKey
    {
        case type = "type"
        case title = "title"
        case coverAsset = "coverAsset"
    }

    init(from decoder: Decoder) throws
    {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        type = try values.decodeIfPresent(String.self, forKey: .type)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        coverAsset = try values.decodeIfPresent(CoverAsset.self, forKey: .coverAsset)
    }
}

struct Series: Codable
{
    let title: String?
    let coverAsset: CoverAsset?

    enum CodingKeys: String, CodingKey
    {
        case title = "title"
        case coverAsset = "coverAsset"
    }

    init(from decoder: Decoder) throws
    {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        coverAsset = try values.decodeIfPresent(CoverAsset.self, forKey: .coverAsset)
    }
}

struct IconAsset: Codable
{
    let thumbnailUrl: String?

    enum CodingKeys: String, CodingKey
    {
        case thumbnailUrl = "thumbnailUrl"
    }

    init(from decoder: Decoder) throws
    {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        thumbnailUrl = try values.decodeIfPresent(String.self, forKey: .thumbnailUrl)
    }
}

struct CoverAsset: Codable
{
    let url: String?

    enum CodingKeys: String, CodingKey
    {
        case url = "url"
    }

    init(from decoder: Decoder) throws
    {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        url = try values.decodeIfPresent(String.self, forKey: .url)
    }
}

struct ChannelViewModel
{
    let title: String
    let mediaCount: String
    let imageIconURL: String
}

extension Channel
{
    func toChannelViewModel() -> ChannelViewModel?
    {
        guard let title = self.title,
              let mediaCount = self.mediaCount else { return nil }
        
        let imageURL = self.iconAsset?.thumbnailUrl ?? ""
        return ChannelViewModel(title: title, mediaCount: "\(mediaCount) episodes", imageIconURL: imageURL)
    }
}

struct EpisodeViewModel
{
    let title: String
    let imageCoverURL: String
}

extension LatestMedia
{
    func toEpisodeViewModel() -> EpisodeViewModel?
    {
        guard let title = self.title else { return nil }
        
        let imageURL = self.coverAsset?.url ?? ""
        return EpisodeViewModel(title: title, imageCoverURL: imageURL)
    }
}
