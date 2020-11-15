//
//  Keys.swift
//  Wajeez
//
//  Created by Essam Mohamed Fahmi on 10/26/20.
//

import Foundation

enum WajeezKeys
{
    enum User: String
    {
        case currentUser = "current-user"
        case token = "token"
        case deviceToken = "deviceToken"
    }
    
    enum Settings: String
    {
        case autoDownloadForBooks = "autoDownloadForBooks"
    }
    
    enum App
    {
        static let appID = 1483042035
        static let supportEmail = "support@wajeez.co"
    }
    
    enum Subscription
    {
        static let subscriptionProgram = "subscriptionProgram"
    }
}
