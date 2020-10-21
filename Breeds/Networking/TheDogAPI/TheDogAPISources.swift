//
//  TheDogAPISources.swift
//  Breeds
//
//  Created by erick.lozano.borges on 05/08/20.
//  Copyright © 2020 borges.erick. All rights reserved.
//

import Keys
import UIKit

enum TheDogAPISources {
    static var baseUrl: URL = {
        guard let url = URL(string: "https://api.thedogapi.com") else {
            preconditionFailure("The url used in \(TheDogAPISources.self) is not valid")
        }
        return url
    }()

    static var authHeader: [String: String] {
        return [
            "x-api-key": BreedsKeys().theDogAPIKey
        ]
    }
}
