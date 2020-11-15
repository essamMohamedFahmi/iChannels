//
//  VCEx.swift
//  Wajeez
//
//  Created by Essam Mohamed Fahmi on 11/4/20.
//

import MessageUI
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

extension UIViewController
{
    private struct AssociatedKeys {
        static var cardTransitionManager = "CardTransitionManager"
    }
    private(set) var cardTransitionManager: CardTransitionManager? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.cardTransitionManager) as? CardTransitionManager
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.cardTransitionManager, newValue, .OBJC_ASSOCIATION_RETAIN)
        }
    }

    @available(iOS 10.0, *)
    public func presentCard(_ viewControllerToPresent: UIViewController,
                            configuration: CardConfiguration? = nil,
                            animated flag: Bool,
                            completion: (() -> Void)? = nil)
    {
        if #available(iOS 13, *), CardPresentationController.useSystemPresentationOniOS13 {
            //    if we are on iOS 13, fallback to default system look & behavior
            present(viewControllerToPresent, animated: flag, completion: completion)
        } else {
            //    make it custom
            viewControllerToPresent.modalPresentationStyle = .overFullScreen
            
            //    enforce statusBarStyle preferred by presented UIVC
            viewControllerToPresent.modalPresentationCapturesStatusBarAppearance = true

            //    card config, using supplied or default
            let config = configuration ?? CardConfiguration.shared
            
            //    then build transition manager
            let tm = CardTransitionManager(configuration: config)
            self.cardTransitionManager = tm
            
            viewControllerToPresent.transitioningDelegate = tm

            present(viewControllerToPresent,
                    animated: flag,
                    completion: completion)
        }
    }

    func removeCardTransitionManager() {
        cardTransitionManager = nil
    }
    
    func selectionVibrate(){
        let feedbackGenerator = UISelectionFeedbackGenerator()
        feedbackGenerator.selectionChanged()
    }
    
    func feedbackVibrate(style : UINotificationFeedbackGenerator.FeedbackType){
        let feedbackGenerator = UINotificationFeedbackGenerator()
        feedbackGenerator.notificationOccurred(style)
    }
    
    func feedBackImpactVibirate(style : UIImpactFeedbackGenerator.FeedbackStyle){
        let feedbackGenerator = UIImpactFeedbackGenerator(style: style)
        feedbackGenerator.impactOccurred()
    }
    
    func changeStatusBarColorWithBarStyle(statusBarColor: UIColor, barStyle: UIBarStyle){
        if #available(iOS 13.0, *)
        {
            let statusBar =  UIView()
            statusBar.frame = (UIApplication.shared.keyWindow?.windowScene?.statusBarManager!.statusBarFrame)!

                statusBar.backgroundColor = statusBarColor
                navigationController?.navigationBar.barStyle = barStyle
            UIApplication.shared.keyWindow?.addSubview(statusBar)
        }
        else
        {
            let statusBar: UIView = UIApplication.shared.value(forKey: "statusBar") as! UIView
           
                statusBar.backgroundColor = statusBarColor
                navigationController?.navigationBar.barStyle = barStyle
        }
    }
    
    func changeStatusBarColor(statusBarColor: UIColor) {
        
        if #available(iOS 13.0, *)
        {
            let statusBar =  UIView()
            statusBar.frame = (UIApplication.shared.keyWindow?.windowScene?.statusBarManager!.statusBarFrame)!
            
            statusBar.backgroundColor = statusBarColor
            
            UIApplication.shared.keyWindow?.addSubview(statusBar)
        }
        else
        {
            let statusBar: UIView = UIApplication.shared.value(forKey: "statusBar") as! UIView
            
            statusBar.backgroundColor = statusBarColor
            
        }
    }
}

// MARK:- MFMailComposeViewControllerDelegate

extension UIViewController: MFMailComposeViewControllerDelegate
{
    func sendEmailWithTransactionData()
    {
        if let subscriptionProgram = SubscriptionCachingManager.shared.program,
           let transactionID = subscriptionProgram.transactionID,
           let receiptData = subscriptionProgram.receiptData,
           let userID = UserSessionManager.instance.user?.ID
        {
            let messageBody = """
            \n \n ------------------------------- \n يرجى عدم تعديل النص التالي \n Please don't edit this \n User ID: \(userID) \n Transaction ID: \(transactionID) \n Purchase token: \(receiptData)"
            """
            
            sendEmail(body: messageBody)
        }
    }
    
    func sendEmail(to recipient: String = WajeezKeys.App.supportEmail, body: String = "")
    {
        if MFMailComposeViewController.canSendMail()
        {
            let mailController = MFMailComposeViewController()
            mailController.mailComposeDelegate = self
            mailController.setToRecipients([recipient])
            mailController.setMessageBody(body, isHTML: false)
            present(mailController, animated: true)
        }
    }
    
    public func mailComposeController(_ controller: MFMailComposeViewController,
                               didFinishWith result: MFMailComposeResult, error: Error?)
    {
        controller.dismiss(animated: true)
    }
}
