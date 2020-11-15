//
//  DictionaryEx.swift
//  Wajeez
//
//  Created by Essam Mohamed Fahmi on 10/22/20.
//

import Foundation

// MARK: '+' Operator Overloading

func + <Key, Value> (lhs: [Key: Value], rhs: [Key: Value]) -> [Key: Value]
{
    var result = lhs
    rhs.forEach{ result[$0] = $1 }
    return result
}
