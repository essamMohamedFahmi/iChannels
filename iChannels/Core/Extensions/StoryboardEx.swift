//
//  Created by Essam Mohamed Fahmi on 9/26/20.
//

import UIKit

extension UIStoryboard
{
    enum StoryboardType: String
    {
        case home
        
        var fileName: String
        {
            return firstUppercased
        }
        
        private var firstUppercased: String
        {
            return rawValue.prefix(1).uppercased() + rawValue.dropFirst()
        }
    }
    
    convenience init(storyboard: StoryboardType, bundle: Bundle? = nil)
    {
        self.init(name: storyboard.fileName, bundle: bundle)
    }
    
    // MARK: - Class Functions
    
    class func storyboard(_ storyboard: StoryboardType, bundle: Bundle? = nil) -> UIStoryboard
    {
        return UIStoryboard(name: storyboard.fileName, bundle: bundle)
    }
    
    // MARK: - View Controller Instantiation from Generics
    
    func instantiateViewController<T: UIViewController>() -> T
    {
        guard let viewController = self.instantiateViewController(withIdentifier: T.storyboardIdentifier) as? T else
        {
            fatalError("Couldn't instantiate view controller with identifier \(T.storyboardIdentifier) ")
        }
        
        return viewController
    }
}

protocol StoryboardIdentifiable
{
    static var storyboardIdentifier: String { get }
    static func instantiate(storyboard: UIStoryboard.StoryboardType) -> Self
}

extension StoryboardIdentifiable where Self: UIViewController
{
    static var storyboardIdentifier: String
    {
        return String(describing: self)
    }
    
    static func instantiate(storyboard: UIStoryboard.StoryboardType) -> Self
    {
        return UIStoryboard(storyboard: storyboard).instantiateViewController()
    }
}

extension UIViewController: StoryboardIdentifiable { }
