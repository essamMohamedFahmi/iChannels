//
//  SettingsManager.swift
//  Wajeez
//
//  Created by Essam Mohamed Fahmi on 11/11/20.
//

import Foundation

class SettingsManager
{
    // MARK: Properties
    
    public static var instance = SettingsManager()
    
    private(set) var autoDownloadForBooksIsEnabled: Bool
    {
        get
        {
            let key = WajeezKeys.Settings.autoDownloadForBooks.rawValue
            return UserDefaults.standard.bool(forKey: key)
        }
        set
        {
            let key = WajeezKeys.Settings.autoDownloadForBooks.rawValue
            UserDefaults.standard.set(newValue, forKey: key)
            UserDefaults.standard.synchronize()
        }
    }
    
    // MARK: Init
    
    private init(){}
    
    // MARK: Methods
    
    func downloadBooksAutomatically(_ status: Bool)
    {
        autoDownloadForBooksIsEnabled = status
    }
}
