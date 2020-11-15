//
//  DateEx.swift
//  Wajeez
//
//  Created by Essam Mohamed Fahmi on 11/12/20.
//

import Foundation

extension Date
{
    var toString: String
    {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let dateAsString = formatter.string(from: self)
        return dateAsString
    }
}
