//
//  Refactored by Essam Mohamed Fahmi.
//

import UIKit

extension UIColor
{
    convenience init(hexString: String)
    {
        let hexString: String = (hexString as NSString).trimmingCharacters(in: .whitespacesAndNewlines)
        let scanner:Scanner = Scanner(string: hexString as String)
        
        if hexString.hasPrefix("#") {
            scanner.scanLocation = 1
        }
        var color: UInt32 = 0
        scanner.scanHexInt32(&color)
        
        let mask = 0x000000FF
        let customred = Int(color >> 16) & mask
        let customgreen = Int(color >> 8) & mask
        let customblue = Int(color) & mask
        
        let red = CGFloat(customred) / 255.0
        let green = CGFloat(customgreen) / 255.0
        let blue = CGFloat(customblue) / 255.0
        self.init(red: red, green: green, blue:blue, alpha: 1)
    }
    
    convenience init(red: Int, green: Int, blue: Int)
    {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    static var random: UIColor
    {
        return UIColor(red: .random(in: 0.0...1.0),
                       green: .random(in: 0.0...1.0),
                       blue: .random(in: 0.0...1.0),
                       alpha: 1.0)
    }
}

extension UIColor
{
    static var appPrimary: UIColor
    {
        return #colorLiteral(red: 0.0862745098, green: 0.4784313725, blue: 0.5215686275, alpha: 1)
    }
    
    static var whiteColor: UIColor
    {
        return #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    }
}
