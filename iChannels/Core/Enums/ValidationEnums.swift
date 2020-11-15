//
//  ValidationEnums.swift
//  Wajeez
//
//  Created by Essam Mohamed Fahmi on 10/25/20.
//

import Foundation

enum ValidatorType
{
    case email
    case name
    case phone(_ countryCode: String = "")
    case password
    case passwordMatches(confirmPassword: String)
    case age
    case required(fieldKey: String)
    case normal(fieldKey: String)
}

enum ValidationError: Error, LocalizedError
{
    case emptyUserName
    case shortUserName
    case longUserName
    case invalidUserName
    case invalidEmail
    case emailEmpty
    case passwordCount
    case passwordMatch
    case emptyPassword
    case emptyText(_ placeholder: String)
    case invalidAge
    case invalidPhone
    case requiredField(key: String)
    
    var localizedDescription: String
    {
        switch self
        {
            case .emptyUserName:
                return "Name must not be empty"
            
            case .shortUserName:
                return "Name must contain more than three characters"
            
            case .longUserName:
                return "Name must not conain more than 18 characters"
            
            case .invalidUserName:
                return "Invalid name, name should not contain whitespaces, numbers or special characters"
            
            case .emailEmpty:
                return "Email is required"
            
            case .invalidEmail:
                return "Wrong Email format"
            
            case .emptyPassword:
                return "Password is required!"
            
            case .passwordCount:
                return "Password is too short"
            
            case .passwordMatch:
                return "Password not matches"
            
            case let .emptyText(placeholder):
                return "\(placeholder) is empty, check inputs!"
            
            case .invalidAge:
                return "Age is under 18"
            
            case .invalidPhone:
                return "Check Phone length and format"
            
            case .requiredField(let key):
                return "\(key) is required!"
        }
    }
}
