//
//  Refactored by Essam Mohamed Fahmi.
//

import UIKit

enum FontType
{
    case light(_ size: CGFloat)
    case regular(_ size: CGFloat)
    case semiBold(_ size: CGFloat)
    case bold(_ size: CGFloat)
}

extension UIFont
{
    class func cairo(_ type: FontType) -> UIFont
    {
        switch type
        {
        case .light(let size):
            return UIFont(name: "Cairo-Light", size: size)!
        case .regular(let size):
            return UIFont(name: "Cairo-Regular", size: size)!
        case .semiBold(let size):
            return UIFont(name: "Cairo-SemiBold", size: size)!
        case .bold(let size):
            return UIFont(name: "Cairo-Bold", size: size)!
        }
    }
}
