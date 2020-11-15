//
//  UINavControllerEx.swift
//  Wajeez
//
//  Created by Essam Mohamed Fahmi on 10/22/20.
//

import UIKit

extension UINavigationController
{
    func popToViewController(ofType type: UIViewController.Type, animated: Bool = true)
    {
        if let controller = viewControllers.first (where: { $0.isKind(of: type) })
        {
            popToViewController(controller, animated: animated)
        }
    }
}
