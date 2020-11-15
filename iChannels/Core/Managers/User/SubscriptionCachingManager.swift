//
//  SubscriptionCachingManager.swift
//  Wajeez
//
//  Created by Essam Mohamed Fahmi on 11/12/20.
//

import Foundation

struct SubscriptionProgram: Codable
{
    var transactionID: String?
    var subscriptionType: String?
    var receiptData: String?
    var verifiedWithServer: Bool?
   
    enum CodingKeys: String, CodingKey
    {
        case transactionID, subscriptionType, receiptData, verifiedWithServer
    }
    
    // MARK:- Methods
    
    func save()
    {
        SubscriptionCachingManager.shared.saveUserSubscription(self)
    }
}

class SubscriptionCachingManager
{
    // MARK: Properties
    
    public static var shared = SubscriptionCachingManager()
    
    private(set) var program: SubscriptionProgram?
    {
        get
        {
            guard let data = UserDefaults.standard.data(forKey: WajeezKeys.Subscription.subscriptionProgram) else { return nil }
            
            return try? JSONDecoder().decode(SubscriptionProgram.self, from: data)
        }
        set
        {
            if let data = try? JSONEncoder().encode(newValue)
            {
                UserDefaults.standard.set(data, forKey: WajeezKeys.Subscription.subscriptionProgram)
            }
            else
            {
                UserDefaults.standard.removeObject(forKey: WajeezKeys.Subscription.subscriptionProgram)
            }
            
            UserDefaults.standard.synchronize()
        }
    }
    
    var verifiedWithServer: Bool
    {
        return program?.verifiedWithServer ?? false
    }
    
    // MARK: Init
    
    private init(){}
    
    // MARK: Methods
    
    func saveUserSubscription(_ program: SubscriptionProgram)
    {
        self.program = program
    }
}
