//
//  AppDelegate.swift
//  iChannels
//
//  Created by Essam Mohamed Fahmi on 11/15/20.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate
{
    let appFlowManager = AppCoordinator()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool
    {
        LibrariesManager.initLibraries(for: application, launchOptions: launchOptions)
        appFlowManager.start()
        return true
    }
}
