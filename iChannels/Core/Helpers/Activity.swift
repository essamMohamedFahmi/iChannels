//
//  Activity.swift
//  Wajeez
//
//  Created by Essam Mohamed Fahmi on 11/4/20.
//

import UIKit

class ActivityIndicator
{
    private static let topViewController = UIViewController.topViewController
    
    public static func startLoading()
    {
        DispatchQueue.main.async
        {
            self.topViewController?.showLoader()
        }
    }
    
    public static func stopLoading()
    {
        DispatchQueue.main.async
        {
            self.topViewController?.hideLoader()
        }
    }
}
