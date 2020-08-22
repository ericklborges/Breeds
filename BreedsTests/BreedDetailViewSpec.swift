//
//  BreedDetailViewSpec.swift
//  BreedsTests
//
//  Created by erick.lozano.borges on 17/08/20.
//  Copyright © 2020 borges.erick. All rights reserved.
//

import Quick
import Nimble
import Nimble_Snapshots

@testable import Breeds

class BreedDetailViewSpec: QuickSpec {
    override func spec() {
        describe("BreedCollectionView") {
            var sut: BreedDetailView!
            
            context("when initialized") {
                beforeEach {
                    sut = BreedDetailView()
                    sut.setup(breed: .stub(), imageUrl: AssetHelper.LocalImage.carameloDog.url)
                    sut.frame.size = CGSize(width: 375, height: 600)
                }
                
                it("should layout itself properly") {
//                    expect(sut).toEventually(recordSnapshot(named: "BreedDetailView_Layout", identifier: nil, usesDrawRect: false), timeout: 0.5)
                    expect(sut).toEventually(haveValidSnapshot(named: "BreedDetailView_Layout"), timeout: 1)
                }
            }
        }
    }
}

