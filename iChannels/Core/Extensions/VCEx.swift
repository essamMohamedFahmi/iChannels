//
//  VCEx.swift
//
//  Created by Essam Mohamed Fahmi on 11/4/20.
//

import UIKit

extension UIViewController
{
    typealias AlertCompletionHandler = () -> Void

    func showAlert(_ title: String,
                   _ message: String,
                   _ firstActionTitle: String,
                   _ firstActionHandler: AlertCompletionHandler? = nil,
                   _ secondActionTitle: String,
                   _ secondActionHandler: AlertCompletionHandler? = nil)
    {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: firstActionTitle, style: .default, handler: { _ in
            firstActionHandler?()
        }))
        
        alert.addAction(UIAlertAction(title: secondActionTitle, style: .default, handler: { _ in
            secondActionHandler?()
        }))
        
        DispatchQueue.main.async(execute: { [weak self] in
            self?.present(alert, animated: true, completion: nil)
        })
    }
    
    func showAlert(_ title: String,
                   _ message: String,
                   addCancelAction: Bool = false,
                   okayHandler: AlertCompletionHandler? = nil,
                   _ cancelHandler: AlertCompletionHandler? = nil)
    {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "نعم", style: .default, handler:
            { _ in
                okayHandler?()
        }))
        
        if (addCancelAction){
            alert.addAction(UIAlertAction(title: "الغاء", style: .cancel, handler:
                { _ in
                cancelHandler?()
            }))
        }
        
        DispatchQueue.main.async(execute: { [weak self] in
            self?.present(alert,animated: true,completion: nil)
        })
    }
    
    func animateConstraint(_ constraint: NSLayoutConstraint, to value: CGFloat, with duration: Double)
    {
        if constraint.constant != value
        {
            constraint.constant = value
            UIView.animate(withDuration: duration) { [weak self] in
                self?.view.layoutIfNeeded()
            }
        }
    }
    
    func openURL(_ url: String)
    {
        guard let userSubscriptionsPanelURL = URL(string: url),
              !userSubscriptionsPanelURL.absoluteString.isEmpty else { return }
        
        UIApplication.shared.open(userSubscriptionsPanelURL, options: [:], completionHandler: nil)
    }
    
    func setAsAppRoot()
    {
        if let window = UIApplication.shared.keyWindow
        {
            window.rootViewController = self
            window.makeKeyAndVisible()
        }
    }
}
