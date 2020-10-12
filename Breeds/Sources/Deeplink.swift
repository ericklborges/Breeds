//
//  Deeplink.swift
//  Breeds
//
//  Created by erick.lozano.borges on 12/10/20.
//  Copyright © 2020 borges.erick. All rights reserved.
//

import Foundation

enum Deeplink {
    case detail(breedImageId: String)
    
    private var scheme: String {
        return "breeds"
    }
    
    private var host: String {
        switch self {
        case .detail:
            return "detail"
        }
    }
    
    private var queryItems: [URLQueryItem] {
        switch self {
        case let .detail(breedImageId):
            return [
                URLQueryItem(name: "breedImageId", value: breedImageId)
            ]
        }
    }
    
    var url: URL? {
        var components = URLComponents()
        components.scheme = scheme
        components.host = host
        components.queryItems = queryItems
        return components.url
    }
}
