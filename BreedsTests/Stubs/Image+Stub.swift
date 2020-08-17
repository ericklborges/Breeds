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
        url: String = "") -> Image {
        return Image(breeds: breeds, url: url)
    }
}
