//
//  Plist.swift
//  Breeds
//
//  Created by erick.lozano.borges on 05/08/20.
//  Copyright © 2020 borges.erick. All rights reserved.
//
// swiftlint:disable line_length

import Foundation

enum Plist {
    case secrets

    var name: String {
        switch self {
        case .secrets:
            return "Secrets"
        }
    }

    static func read<T: Decodable>(from plist: Plist, key: String, type: T.Type) -> T? {
        guard let path = Bundle.main.path(forResource: plist.name, ofType: "plist") else {
            preconditionFailure("\(plist.name).plist was not found in bundle \(Bundle.main.description)")
        }
        
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path))
            guard let values = try PropertyListSerialization.propertyList(from: data, options: .mutableContainers, format: nil) as? [String: T] else {
                preconditionFailure("No value of type \(T.self) was found on \(plist.name).plist")
            }
            
            guard let value = values[key] else {
                preconditionFailure("No \(T.self) value was found for key \"\(key)\"")
            }
            
            return value
        } catch let error {
            print(error)
            return nil
        }
    }
}
