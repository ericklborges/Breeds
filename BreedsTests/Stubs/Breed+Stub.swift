//
//  Breed+Stub.swift
//  BreedsTests
//
//  Created by erick.lozano.borges on 16/08/20.
//  Copyright © 2020 borges.erick. All rights reserved.
//

@testable import Breeds

extension Breed {
    static func stub(
        weight: Dimension = Dimension(imperial: "33", metric: "100"),
        height: Dimension = Dimension(imperial: "33", metric: "100"),
        name: String = "Caramelo",
        bredFor: String? = nil,
        breedGroup: String? = nil,
        lifeSpan: String = "15 years" ,
        temperament: String? = nil,
        origin: String? = nil) -> Breed {
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
