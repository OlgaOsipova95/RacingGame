//
//  UserDefaults + extensions.swift
//  Racing
//
//  Created by Olga on 29.12.2023.
//

import Foundation

extension UserDefaults {
    
    func set<T: Encodable>(_ encodable: T, forKey: String) {
        if let data = try? JSONEncoder().encode(encodable) {
            setValue(data, forKey: forKey)
        }
    }
    func get<T: Decodable>(_ type: T.Type, forKey: String) -> T? {
        if let data = object(forKey: forKey) as? Data,
           let result = try? JSONDecoder().decode(type, from: data) {
            return result
        }
        return nil
    }
}
