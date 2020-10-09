//
//  BreedImage.swift
//  Breeds
//
//  Created by erick.lozano.borges on 06/08/20.
//  Copyright © 2020 borges.erick. All rights reserved.
//

import Foundation

struct BreedImage: Decodable {
    let breeds: [Breed]
    let url: String
}
