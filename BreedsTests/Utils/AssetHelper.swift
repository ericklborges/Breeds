//
//  AssetHelper.swift
//  BreedsTests
//
//  Created by erick.lozano.borges on 17/08/20.
//  Copyright © 2020 borges.erick. All rights reserved.
//

import Foundation

class AssetHelper {
    
    enum LocalImage: String {
        case carameloDog = "caramelo_dog.jpg"

        var fileName: String {
            let components = rawValue.components(separatedBy: ".")
            return components[0]
        }
        
        var fileExtension: String {
            let components = rawValue.components(separatedBy: ".")
            return components[1]
        }
        
        var url: String {
            guard let path = Bundle(for: AssetHelper.self).path(forResource: fileName, ofType: fileExtension) else { return "" }
            return URL(fileURLWithPath: path).absoluteString
        }
    }
    
}
