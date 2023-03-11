//
//  UserDefaultValue.swift
//  taskHunter
//
//  Created by Taosong YU on 2023/3/7.
//

import Foundation
///将属性的getter和setter（通过JSON存储在UserDefaults中）封装在UserDefaultValue中
@propertyWrapper
struct UserDefaultValue<Value: Codable> {
    
    let key: String
    let defaultValue: Value
    ///Import/export user data
    var wrappedValue: Value {
        get {
            let data = UserDefaults.standard.data(forKey: key)
            let value = data.flatMap {
                try? JSONDecoder().decode(Value.self, from: $0)
            }
            return value ?? defaultValue
        }
        set {
            let data = try? JSONEncoder().encode(newValue)
            UserDefaults.standard.set(data, forKey: key)
        }
    }
}
