//
//  UITextFieldEx.swift
//  Wajeez
//
//  Created by Essam Mohamed Fahmi on 10/25/20.
//

import UIKit

extension UITextField
{
    func validatedText(_ validationType: ValidatorType) throws
    {
        do
        {
            try text?.validatedText(validationType)
        }
        catch let validationError
        {
            shake()
            throw validationError
        }
    }
    
    func shake()
    {
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.1
        animation.repeatCount = 5
        animation.fromValue = NSValue(cgPoint: CGPoint(x: center.x + 6, y: center.y))
        animation.toValue = NSValue(cgPoint: CGPoint(x: center.x - 6, y: center.y))
        layer.add(animation, forKey: "position")
    }
    
    func clear()
    {
        text = ""
    }
}
