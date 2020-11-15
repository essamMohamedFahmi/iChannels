//
//  Created by Essam Mohamed Fahmi on 9/26/20.
//

import UIKit

class BaseVC: UIViewController
{
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        navigationController?.setMainAppNavigationBarStyle()
    }
}
