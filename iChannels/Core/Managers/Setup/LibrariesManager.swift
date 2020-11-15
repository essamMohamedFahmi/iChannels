//
//  Created by Essam Mohamed Fahmi on 10/7/20.
//

import IQKeyboardManagerSwift

class LibrariesManager
{
    // MARK: Init
    
    private init(){}
    
    // MARK: Methods
    
    static func initLibraries(for application: UIApplication,
                              launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil)
    {
        Notifiy.shared.configNotify()
        enableKeyboardManager()
    }
    
    private static func enableKeyboardManager()
    {
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.enableAutoToolbar = true
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
    }
}
