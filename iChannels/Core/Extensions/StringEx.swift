import UIKit

extension String
{
    // MARK: Properties
    
    /// Returns if a string hasn't whitespaces And Newlines
    var trimmed: String
    {
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    var isNotEmptyOrSpaces: Bool
    {
        return !(self.isEmpty && self.trimmed.isEmpty)
    }
    
    var isEmptyOrSpaces: Bool
    {
        return isEmpty || trimmed.isEmpty
    }
    
    func isURL() -> Bool
    {
        return URL(string: self) != nil
    }
    
    func isBirthDateGreaterThan(_ years: Int) -> Bool
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-YYYY"
        let dateOfBirth = dateFormatter.date(from: self)!
        
        let today = Date()
        
        let gregorian = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)!
        let age = gregorian.components([.year], from: dateOfBirth, to: today, options: [])
        
        if age.year! < years {
            return false
        }
        return true
    }
    
    var htmlToAttributedString: NSAttributedString?
    {
        guard let data = data(using: .utf8) else { return nil }
        do
        {
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = .right
            
            let content = try NSMutableAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
            
            content.addAttributes([NSAttributedString.Key.paragraphStyle: paragraphStyle,
                                   NSAttributedString.Key.font: UIFont.cairo(.semiBold(20)),
                                   NSAttributedString.Key.foregroundColor: UIColor.appPrimary],
                                  range: NSMakeRange(0, content.length))
            
            return content
        }
        catch
        {
            return nil
        }
    }
    
    var htmlToString: String
    {
        return htmlToAttributedString?.string ?? ""
    }
    
    // MARK: Methods
    
    func capitalizeFirst() -> String
    {
        return prefix(1).capitalized + dropFirst()
    }
    
    mutating func capitalizeFirst()
    {
        self = capitalizeFirst()
    }
}

// MARK: Validation

extension String
{
    func validatedText(_ validationType: ValidatorType) throws
    {
        switch validationType
        {
            case .name:
                try validateUsername()
            
            case .email:
                try validateEmail()
            
            case .phone(let coutnryCode):
                try validatePhoneNumber(with: coutnryCode)
            
            case .password:
                try validatePassword()
            
            case .passwordMatches(let confirmPassword):
                try matchPassword(with: confirmPassword)
            
            case .age:
                try validateBirthDate()
            
            case .required(let fieldKey):
                try validateRequired(key: fieldKey)
            
            case .normal(let fieldKey):
                try validateEmpty(key: fieldKey)
        }
    }
    
    // MARK: Private Methods
    
    private func validateRequired(key: String) throws
    {
        if isEmpty
        {
            throw ValidationError.requiredField(key: key)
        }
    }
    
    private func validateUsername() throws
    {
        if isEmpty
        {
            throw ValidationError.emptyUserName
        }
        
        if !isValidName
        {
            throw ValidationError.invalidUserName
        }
        
        if count < 3
        {
            throw ValidationError.shortUserName
        }
        
        if count > 18
        {
            throw ValidationError.longUserName
        }
    }
    
    private func validatePhoneNumber(with coutnryCode: String) throws
    {
        if !"\(coutnryCode)\(self)".isValidPhone
        {
            throw ValidationError.invalidPhone
        }
    }
    
    private func validatePassword() throws
    {
        if isEmpty
        {
            throw ValidationError.emptyPassword
        }
        
        if count < 6
        {
            throw ValidationError.passwordCount
        }
    }
    
    private func validateEmail() throws
    {
        if isEmpty
        {
            throw ValidationError.emailEmpty
        }
        
        if !isValidEmail
        {
            throw ValidationError.invalidEmail
        }
    }
    
    private func matchPassword(with confirmPassword: String) throws
    {
        if self != confirmPassword
        {
            throw ValidationError.passwordMatch
        }
    }
    
    private func validateBirthDate(greaterThan age: Int = 18) throws
    {
        if isEmpty
        {
            throw ValidationError.emptyText("Birth Date")
        }
        
        if !isBirthDateGreaterThan(age)
        {
            throw ValidationError.invalidAge
        }
    }
    
    private func validateEmpty(key: String) throws
    {
        if isEmptyOrSpaces
        {
            throw ValidationError.emptyText(key)
        }
    }
}


extension String
{
    var isValidEmail: Bool
    {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        let isValid = emailTest.evaluate(with: self)
        return isValid
    }
    
    var isValidName: Bool
    {
        let nameRegEx = "[A-Za-zء-ي]+[[ ._-]?[A-Z0-9a-zء-ي]+]*"
        let nameTest = NSPredicate(format: "SELF MATCHES %@", nameRegEx)
        let isValid = nameTest.evaluate(with: self)
        return isValid
    }
    
    var isValidPhone: Bool
    {
        do
        {
            let detector = try NSDataDetector(types: NSTextCheckingResult.CheckingType.phoneNumber.rawValue)
            let matches = detector.matches(in: self, options: [], range: NSMakeRange(0, self.count))
            if let res = matches.first
            {
                return res.resultType == .phoneNumber
                       && res.range.location == 0
                       && res.range.length == self.count
            }
            else
            {
                return false
            }
        }
        catch
        {
            return false
        }
    }
    
    var isValidSaudiNumber: Bool
    {
        guard self.hasPrefix("+966") || self.hasPrefix("00966") else {
            return false
        }
        return true
    }
    
    func isValidPhoneLength(length: Int) -> Bool
    {
        guard self.count == length && self.isValidPhone else {
            return false
        }
        return true
    }
}

// MARK: Subscript

extension String
{
    subscript (i: Int) -> String
    {
        return self[i ..< i + 1]
    }
    
    subscript (r: Range<Int>) -> String
    {
        let range = Range(uncheckedBounds: (lower: max(0, min(count, r.lowerBound)),
                                            upper: min(count, max(0, r.upperBound))))
        let start = index(startIndex, offsetBy: range.lowerBound)
        let end = index(start, offsetBy: range.upperBound - range.lowerBound)
        return String(self[start ..< end])
    }
    
    func substring(fromIndex: Int) -> String
    {
        return self[min(fromIndex, count) ..< count]
    }
    
    func substring(toIndex: Int) -> String
    {
        return self[0 ..< max(0, toIndex)]
    }
    
//    func convertIntToMinute(length: Int) -> String
//    {
//        let formatter = DateComponentsFormatter()
//        formatter.allowedUnits = [.minute]
//        formatter.unitsStyle = .positional
//
//        let formattedString = formatter.string(from: TimeInterval(length))!
//        
//       return formattedString
//        
//    }
    
    func convertToSecondAndMinute(interval: TimeInterval) -> String
    {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.minute, .second]
        formatter.unitsStyle = .positional
        formatter.zeroFormattingBehavior = .pad
        formatter.allowsFractionalUnits = true
        let formattedString = formatter.string(from: TimeInterval(interval))
        return formattedString!
    }
}

