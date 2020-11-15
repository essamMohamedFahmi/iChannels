//
//  ChannelsAPI.swift
//
//  Created by Essam Mohamed Fahmi.
//

import Moya

enum ChannelsAPI
{
    case getNewEpisodes
    case getChannels
    case getCategories
}

extension ChannelsAPI: TargetType
{
    var baseURL: URL
    {
        let base = Environment.development.baseURL
        guard let url = URL(string: base) else
        { fatalError("baseURL could not be configured") }
        return url
    }
    
    var path: String
    {
        switch self
        {
        case .getNewEpisodes:
            return "/z5AExTtw"
        case .getChannels:
            return "/Xt12uVhM"
        case .getCategories:
            return "/A0CgArX3"
        }
    }
    
    var method: Moya.Method
    {
        return .get
    }
    
    var sampleData: Data
    {
        return Data()
    }
    
    var headers: [String: String]?
    {
        var headersParameters: [String: String] = [:]
        headersParameters["Content-type"] = "application/json"
        return headersParameters
    }
    
    var task: Task
    {
        return .requestPlain
    }
}
