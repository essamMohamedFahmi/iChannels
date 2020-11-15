import Foundation

enum Environment: String
{
    case development = "development"
    case production = "production"

    var baseURL: String
    {
        switch self
        {
        case .development: return "https://pastebin.com/raw"
        case .production: return "https://pastebin.com/raw"
        }
    }

    static var current: Environment
    {
        let currentEnvironment = UserDefaults.standard.string(forKey: "environment") ?? Environment.production.rawValue
        return Environment(rawValue: currentEnvironment)!
    }
}
