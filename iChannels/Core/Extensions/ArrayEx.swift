//
//  ArrayEx.swift
//  Wajeez
//
//  Created by Moawiya Thaher on 11/11/20.
//

import Foundation

extension Array
{
    func split() -> (left: [Element], right: [Element])
    {
        let ct = self.count
        let half = ct / 2
        let leftSplit = self[0 ..< half]
        let rightSplit = self[half ..< ct]
        return (left: Array(leftSplit), right: Array(rightSplit))
    }
}
