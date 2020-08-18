//
//  BreedCollectionViewCellSpec.swift
//  BreedsTests
//
//  Created by erick.lozano.borges on 16/08/20.
//  Copyright © 2020 borges.erick. All rights reserved.
//

import Quick
import Nimble
import Nimble_Snapshots

@testable import Breeds

class BreedCollectionViewCellSpec: QuickSpec {
    override func spec() {
        describe("BreedCollectionViewCell") {
            var sut: BreedCollectionViewCell!
            
            context("when initialized") {
                beforeEach {
                    sut = BreedCollectionViewCell()
                    sut.setup(image: .stub(url: AssetHelper.LocalImage.carameloDog.url))
                    sut.frame.size = CGSize(width: 200, height: 200)
                }
                
                it("should layout itself properly") {
                    expect(sut).toEventually(haveValidSnapshot(named: "BreedCollectionViewCell_Layout"), timeout: 0.5)
                }
            }
        }
    }
}
