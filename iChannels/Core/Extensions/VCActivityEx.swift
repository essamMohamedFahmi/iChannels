//
//  VCActivityEx.swift
//  Wajeez
//
//  Created by Essam Mohamed Fahmi on 11/4/20.
//

import NVActivityIndicatorView

extension UIViewController
{
    static var topViewController: UIViewController?
    {
        if var topController = UIApplication.shared.keyWindow?.rootViewController
        {
            while let presentedViewController = topController.presentedViewController
            {
                topController = presentedViewController
            }
            return topController
        }
        return nil
    }
}

extension UIViewController: NVActivityIndicatorViewable
{
    func showLoader()
    {
        let size = CGSize(width: 50, height: 50)
        startAnimating(size, message: "جاري التحميل ...",
                            messageFont: .cairo(.regular(16.0)),
                            type: .ballClipRotate)
    }
    
    func hideLoader()
    {
        stopAnimating()
    }
}
