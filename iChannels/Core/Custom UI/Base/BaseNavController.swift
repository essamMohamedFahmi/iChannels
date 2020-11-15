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
        
        let titleAttributes: [NSAttributedString.Key: Any] = [.font: UIFont.cairo(.semiBold(20)), .foregroundColor: UIColor.white]
        navigationBar.titleTextAttributes = titleAttributes
        
        UIBarButtonItem.appearance().setTitleTextAttributes([.font: UIFont.cairo(.regular(18)), .foregroundColor: UIColor.white], for: .normal)

        if #available(iOS 11.0, *)
        {
            let largeTitleAttributes: [NSAttributedString.Key: Any] =
                [.font: UIFont.cairo(.bold(32)), .foregroundColor: UIColor.white]
            navigationBar.largeTitleTextAttributes = largeTitleAttributes
        }
    }
}
