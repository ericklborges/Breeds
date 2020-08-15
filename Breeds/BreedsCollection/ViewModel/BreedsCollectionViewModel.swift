//
//  BreedsCollectionViewModel.swift
//  Breeds
//
//  Created by erick.lozano.borges on 12/08/20.
//  Copyright © 2020 borges.erick. All rights reserved.
//

import Foundation

protocol BreedsCollectionViewModelDelegate: AnyObject {
    func didReceiveImages()
    func didReceiveError()
}

class BreedsCollectionViewModel {
    
    // MARK: Properties
    private let pageSize = 20
    private var currentPage = 0
    private var isFetching = false
    private let imagesApi: ImagesAPI
    weak var delegate: BreedsCollectionViewModelDelegate?
    
    private(set) var images: [Image] = []
    
    // MARK: Init
    init(delegate: BreedsCollectionViewModelDelegate, manager: RequestManager = RequestManagerFactory.create()) {
        self.delegate = delegate
        self.imagesApi = ImagesAPI(manager: manager)
    }
    
    // MARK: Methods
    func shouldPrefetchImages(for indexPaths: [IndexPath]) -> Bool {
        guard
            !isFetching,
            let indexPath = indexPaths.first
            else { return false }
        
        let prefetchRow = indexPath.row
        let threshold = images.count - 10
        
        if prefetchRow > threshold {
            return true
        }
        
        return false
    }
}

// MARK: - Networking
extension BreedsCollectionViewModel {
    func fetchImages() {
        isFetching = true
        imagesApi.fetchImages(limit: pageSize, page: currentPage) { [weak self] result in
            switch result {
            case let .success(images):
                self?.handleSuccess(with: images)
            case let .failure(error):
                print(error)
                self?.handleError()
            }
            self?.isFetching = false
        }
    }
    
    private func handleSuccess(with images: [Image]) {
        self.images.append(contentsOf: images)
        currentPage += 1
        delegate?.didReceiveImages()
    }
    
    private func handleError() {
        guard currentPage > 0 else { return }
        delegate?.didReceiveError()
    }
}
