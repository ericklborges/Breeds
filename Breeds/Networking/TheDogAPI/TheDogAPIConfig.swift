//
//  TheDogAPIConfig.swift
//  Breeds
//
//  Created by erick.lozano.borges on 05/08/20.
//  Copyright © 2020 borges.erick. All rights reserved.
//

import UIKit

enum TheDogAPISources {
    static let baseUrl = "https://api.thedogapi.com"

    static var authHeader: [String: String] {
        return [
            "x-api-key": Plist.read(from: .secrets, key: "TheDogAPIKey", type: String.self) ?? ""
        ]
    }
}
