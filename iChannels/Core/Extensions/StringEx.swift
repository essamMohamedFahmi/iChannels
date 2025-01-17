//
//  StringEx.swift
//  iChannels
//
//  Created by Essam Mohamed Fahmi on 11/15/20.
//

import UIKit

extension String
{
    func height(constrainedWidth width: CGFloat, font: UIFont) -> CGFloat
    {
        let label =  UILabel(frame: CGRect(x: 0, y: 0, width: width,
                                           height: .greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.text = self
        label.font = font
        label.sizeToFit()
        
        return label.frame.height
    }
}
