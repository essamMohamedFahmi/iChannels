//
//  EncodableEx.swift
//  Wajeez
//
//  Created by Essam Mohamed Fahmi on 10/22/20.
//

import Foundation

extension Encodable
{
    func toJSONData() -> Data
    {
        let data = try? JSONEncoder().encode(self)
        return data ?? Data()
    }
    
    func toJSONString() -> String
    {
        let string = String(data: self.toJSONData(), encoding: String.Encoding.utf8) ?? ""
        return string
    }
    
    func toJSONObject() -> [String: Any]
    {
        let jsonObject = try? JSONSerialization.jsonObject(with: self.toJSONData(), options: []) as? [String: Any]
        return jsonObject ?? [:]
    }
}
