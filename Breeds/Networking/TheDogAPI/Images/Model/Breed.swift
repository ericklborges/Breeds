//
//  Breed.swift
//  Breeds
//
//  Created by erick.lozano.borges on 05/08/20.
//  Copyright © 2020 borges.erick. All rights reserved.
//

import Foundation

struct Breed: Codable {
    let weight: Dimension
    let height: Dimension
    let name: String
    let bredFor: String?
    let breedGroup: String?
    let lifeSpan: String
    let temperament: String?
    let origin: String?
    
    enum CodingKeys: String, CodingKey {
        case weight = "weight"
        case height = "height"
        case name = "name"
        case bredFor = "bred_for"
        case breedGroup = "breed_group"
        case lifeSpan = "life_span"
        case temperament = "temperament"
        case origin = "origin"
    }
}

struct Dimension: Codable {
    let imperial: String
    let metric: String
}

#if DEBUG
extension Breed {
    static func stub(
        weight: Dimension = Dimension(imperial: "33", metric: "100"),
        height: Dimension = Dimension(imperial: "33", metric: "100"),
        name: String = "Caramelo",
        bredFor: String? = nil,
        breedGroup: String? = nil,
        lifeSpan: String = "15 years" ,
        temperament: String? = nil,
        origin: String? = nil
    ) -> Breed {
        return Breed(
            weight: weight,
            height: height,
            name: name,
            bredFor: bredFor,
            breedGroup: breedGroup,
            lifeSpan: lifeSpan,
            temperament: temperament,
            origin: origin
        )
    }
}
#endif
