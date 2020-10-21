//
//  BreedDetailViewModel.swift
//  Breeds
//
//  Created by erick.lozano.borges on 12/10/20.
//  Copyright © 2020 borges.erick. All rights reserved.
//

import Foundation

protocol BreedDetailViewModelDelegate: AnyObject {
    func didReceive(breedImage: BreedImage)
    func didReceiveError()
}

class BreedDetailViewModel {
    // MARK: - Properties
    weak var delegate: BreedDetailViewModelDelegate?
    private let breedImagesAPI: BreedImagesAPI
    
    // MARK: - Init
    init(delegate: BreedDetailViewModelDelegate, manager: RequestManager = RequestManagerFactory.create()) {
        self.delegate = delegate
        self.breedImagesAPI = BreedImagesAPI(manager: manager)
    }
    
}

// MARK: - Networking
extension BreedDetailViewModel {
    func fetchImage(by id: String) {
        breedImagesAPI.fetchImage(by: id) { [weak self] result in
            switch result {
            case let .success(breedImage):
                self?.delegate?.didReceive(breedImage: breedImage)
            case let .failure(error):
                print(error)
                self?.delegate?.didReceiveError()
            }
        }
    }
}
