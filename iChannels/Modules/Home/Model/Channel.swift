//
//  Channel.swift
//  iChannels
//
//  Created by Essam Mohamed Fahmi on 11/15/20.
//

struct Channel: Codable
{
    let title: String?
    let series: [ChannelItem]?
    let mediaCount: Int?
    let latestMedia: [ChannelItem]?
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
        series = try values.decodeIfPresent([ChannelItem].self, forKey: .series)
        mediaCount = try values.decodeIfPresent(Int.self, forKey: .mediaCount)
        latestMedia = try values.decodeIfPresent([ChannelItem].self, forKey: .latestMedia)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        iconAsset = try values.decodeIfPresent(IconAsset.self, forKey: .iconAsset)
        coverAsset = try values.decodeIfPresent(CoverAsset.self, forKey: .coverAsset)
    }
}

extension Channel
{
    var seriesSample: [ChannelItem]
    {
        return Array(series?.prefix(6) ?? [])
    }
    
    var episodesSample: [ChannelItem]
    {
        return Array(latestMedia?.prefix(6) ?? [])
    }
}

struct ChannelItem: Codable
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

struct ChannelSectionHeaderViewModel
{
    let title: String
    let subTitle: String
    let imageIconURL: String
}

extension Channel
{
    func toChannelSectionHeaderViewModel() -> ChannelSectionHeaderViewModel?
    {
        guard let title = self.title else { return nil }
        
        let imageURL = self.iconAsset?.thumbnailUrl ?? ""

        let seriesCount = series?.count ?? 0
        let episodesCount = latestMedia?.count ?? 0
        let subTitle = isSeriesType ? "\(seriesCount) series" : "\(episodesCount) episodes"
        
        return ChannelSectionHeaderViewModel(title: title, subTitle: subTitle, imageIconURL: imageURL)
    }
    
    var isSeriesType: Bool
    {
        return !(series?.isEmpty ?? true)
    }
}

struct ChannelViewModel
{
    let title: String
    let imageCoverURL: String
    let constraintImageHeight: Int
}

extension ChannelItem
{
    func toChannelViewModel(isSeries: Bool = false) -> ChannelViewModel?
    {
        guard let title = self.title else { return nil }
        
        let imageURL = self.coverAsset?.url ?? ""
        let imageHeight = isSeries ? SeriesCell.imageHeight : EpisodeCell.imageHeight
        
        return ChannelViewModel(title: title, imageCoverURL: imageURL, constraintImageHeight: imageHeight)
    }
}
