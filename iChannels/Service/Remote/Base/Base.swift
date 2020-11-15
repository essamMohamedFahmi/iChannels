import Foundation

struct BaseAPIResponse<Data: Codable>: Codable
{
    let data: Data?
}

enum ServiceType
{
    case live
    case test
}
