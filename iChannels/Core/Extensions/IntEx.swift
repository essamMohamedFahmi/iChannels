//
//  IntEx.swift
//  Wajeez
//
//  Created by Essam Mohamed Fahmi on 10/25/20.
//

import Foundation

extension Int
{
    var isValidAsStatusCode: Bool
    {
        return (200 ... 299 ~= self)
    }
    
    func timeString() -> String
    {
        let hours = self / 3600
        let minutes = self / 60 % 60
        let seconds = self % 60
        return String(format:"%02i:%02i:%02i", hours, minutes, seconds)
    }
    
    func timeStringWithoutHours() -> String
    {
        let minutes = self / 60 % 60
        let seconds = self % 60
        return String(format:"%02i:%02i", minutes, seconds)
    }
}
