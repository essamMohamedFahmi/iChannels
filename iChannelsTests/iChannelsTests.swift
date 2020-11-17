//
//  iChannelsTests.swift
//  iChannelsTests
//
//  Created by Essam Mohamed Fahmi on 11/15/20.
//

import XCTest
@testable import iChannels

class iChannelsTests: XCTestCase, ChannelsNetworkManagerInjected
{
    override func setUpWithError() throws
    {
        ChannelsNetworkManagerInjectionMap.channelsNetworkManager = ChannelsNetworkManager(type: .test)
    }
    
    override func tearDownWithError() throws
    {
        ChannelsNetworkManagerInjectionMap.channelsNetworkManager = ChannelsNetworkManager(type: .live)
    }
    
    // MARK: Methods
    
    func testFetchChannels()
    {
        let expectedNumberOfChannels = JSONTestDataManager.shared.getNumberOfChannels()
        var fetchedNumberOfChannels = 0
        
        channelsNetworkManager.getChannels { result in
            if case .success(let response) = result
            {
                fetchedNumberOfChannels = response.data?.channels?.count ?? 0
            }
        }
        
        let message = "expected: \(expectedNumberOfChannels), fetched: \(fetchedNumberOfChannels)"
        XCTAssert(fetchedNumberOfChannels == expectedNumberOfChannels, message)
    }
}
