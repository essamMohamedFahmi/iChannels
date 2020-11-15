//
//  IntEx.swift
//  iChannels
//
//  Created by Essam Mohamed Fahmi on 11/15/20.
//

import Foundation

extension Int
{
    var isValidAsStatusCode: Bool
    {
        return (200 ... 299 ~= self)
    }
}
