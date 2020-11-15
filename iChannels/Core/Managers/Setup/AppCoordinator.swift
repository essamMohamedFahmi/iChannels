//
//  Created by Essam Mohamed Fahmi.
//

import UIKit

class AppCoordinator
{
    private var window: UIWindow?
    
    func start()
    {
        coordinateToLoadingVC()
    }
    
    private func setupAppRoot(with controller: UIViewController)
    {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = controller
        self.window?.makeKeyAndVisible()
    }
}

extension AppCoordinator
{
    func coordinateToLoadingVC()
    {
        let loadingVC: LoadingVC = LoadingVC.instantiate(storyboard: .loading)
        LoadingBuilder.createLoadingModule(around: loadingVC)
        setupAppRoot(with: loadingVC)
    }
    
    #warning("Testing")

    func coordinateToWelcomeVC()
    {
        let welcomeVC: WelcomeVC = WelcomeVC.instantiate(storyboard: .welcome)
        WelcomeBuilder.createWelcomeModule(around: welcomeVC)
        setupAppRoot(with: welcomeVC)
    }
        
    func coordinateToTabBar()
    {
        let tab = TabBarC.instantiate(storyboard: .tabBar)
        TabBarBulder.createTabBarModule(around: tab)
        setupAppRoot(with: tab)
    }
    
    func coordinateToSettingsVC()
    {
        let nav = BaseNavController()
        setupAppRoot(with: nav)
        
        let settingsVC: SettingsVC = SettingsVC.instantiate(storyboard: .settings)
        SettingsBuilder.createSettingsModule(around: settingsVC)
        nav.pushViewController(settingsVC, animated: true)
    }
}
