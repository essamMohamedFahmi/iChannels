//
//  Created by Essam Mohamed Fahmi.
//

import UIKit

class AppCoordinator
{
    private var window: UIWindow?
    
    func start()
    {
        coordinateToHomeVC()
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
    func coordinateToHomeVC()
    {
        let homeVC: HomeVC = HomeVC.instantiate(storyboard: .home)
        HomeBuilder.createHomeModule(around: homeVC)
        setupAppRoot(with: homeVC)
    }
}
