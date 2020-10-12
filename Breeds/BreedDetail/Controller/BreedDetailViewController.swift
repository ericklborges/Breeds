//
//  BreedDetailViewController.swift
//  Breeds
//
//  Created by erick.lozano.borges on 15/08/20.
//  Copyright © 2020 borges.erick. All rights reserved.
//

import UIKit

class BreedDetailViewController: UIViewController {
    
    // MARK: Views
    private let baseView = BreedDetailView()
    
    // MARK: Properties
    private var breed: Breed?
    private var imageUrl: String?
    private let breedImageId: String?
    private lazy var viewModel = BreedDetailViewModel(delegate: self)
    
    // MARK: Init
    init(breed: Breed, imageUrl: String) {
        self.breed = breed
        self.imageUrl = imageUrl
        self.breedImageId = nil
        super.init(nibName: nil, bundle: nil)
    }
    
    init(breedImageId: String) {
        self.breedImageId = breedImageId
        super.init(nibName: nil, bundle: nil)
        viewModel.fetchImage(by: breedImageId)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Life Cycle
    override func loadView() {
        view = baseView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    // MARK: Setup
    private func setup() {
        title = breed?.name
        navigationItem.largeTitleDisplayMode = .never
        baseView.setup(breed: breed, imageUrl: imageUrl)
    }
}

// MARK: BreedDetailViewModelDelegate
extension BreedDetailViewController: BreedDetailViewModelDelegate {
    func didReceive(breedImage: BreedImage) {
        guard let receivedBreed = breedImage.breeds.first else { return }
        breed = receivedBreed
        imageUrl = breedImage.url
        setup()
    }
    
    func didReceiveError() {
        print("Detail Rrror State")
    }
}
