//
//  Created by Essam Mohamed Fahmi.
//

import UIKit

class LibrariesManager
{
    // MARK: Init
    
    private init(){}
    
    // MARK: Methods
    
    static func initLibraries(for application: UIApplication,
                              launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil)
    {
        Notifiy.shared.configNotify()
    }
}
