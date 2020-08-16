//
//  Image+Stub.swift
//  BreedsTests
//
//  Created by erick.lozano.borges on 16/08/20.
//  Copyright © 2020 borges.erick. All rights reserved.
//

@testable import Breeds

extension Image {
    static func stub(
        breeds: [Breed] = [.stub()],
        url: String = "https://fotos.amomeupet.org/uploads/fotos/1300x0_1568662224_5d7fe2d09bccd.jpeg") -> Image {
        return Image(breeds: breeds, url: url)
    }
}
