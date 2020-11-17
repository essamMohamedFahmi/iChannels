//
//  JSONTestDataManager.swift
//  iChannels
//
//  Created by Essam Mohamed Fahmi.
//

import Foundation

public class JSONTestDataManager
{
    // MARK:- Properties
    
    static let shared = JSONTestDataManager()
    private let channelsTestJSONDataFileName = "ChannelsTestJSONData"
    
    // MARK:- Initialization
    
    private init(){}
    
    // MARK:- Methods
    
    func getChannelsTestJSONData() -> Data
    {
        let path = Bundle.main.path(forResource: channelsTestJSONDataFileName, ofType: "json")
        if let jsonData = try? NSData(contentsOfFile: path!, options: NSData.ReadingOptions.mappedIfSafe)
        {
            return jsonData as Data
        }
        
        return Data()
    }
    
    func getNumberOfChannels() -> Int
    {
        if let response = try? JSONDecoder().decode(BaseAPIResponse<ChannelsResponse>.self, from: getChannelsTestJSONData())
        {
            return response.data?.channels?.count ?? 0
        }
        
        return 0
    }
}
