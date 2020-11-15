//
//  Refactored by Essam Mohamed Fahmi.
//

import UIKit

extension UIView
{
    static var nib: UINib
    {
        return UINib(nibName: "\(self)", bundle: nil)
    }
    
    static func instantiateFromNib() -> Self?
    {
        return nib.instantiate() as? Self
    }
    
    func loadXIBFromMemory()
    {
        Bundle.main.loadNibNamed("\(Self.self)", owner: self, options: nil)
    }
}

extension UINib
{
    func instantiate() -> Any?
    {
        return instantiate(withOwner: nil, options: nil).first
    }
}
