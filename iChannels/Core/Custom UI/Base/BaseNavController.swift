//
//  Created by Essam Mohamed Fahmi on 9/26/20.
//

import UIKit

class BaseNavController: UINavigationController
{
    override func viewDidLoad()
    {
        super.viewDidLoad()
        setMainAppNavigationBarStyle()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle
    {
        return .lightContent
    }
}

extension UINavigationController
{
    func setupTransparentNavigation()
    {
        self.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationBar.shadowImage = UIImage()
        self.navigationBar.isTranslucent = true
        self.navigationBar.tintColor = UIColor.black
        self.navigationBar.barTintColor = UIColor.white
    }
}

extension UINavigationController
{
    func setMainAppNavigationBarStyle()
    {
        self.navigationBar.tintColor = .white
        self.navigationBar.barTintColor = .appPrimary
    }
}
