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
    let baseView = BreedDetailView()
    
    // MARK: Properties
    let breed: Breed
    let imageUrl: String
    
    // MARK: Init
    init(breed: Breed, imageUrl: String) {
        self.breed = breed
        self.imageUrl = imageUrl
        super.init(nibName: nil, bundle: nil)
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
        title = breed.name
        navigationItem.largeTitleDisplayMode = .never
        baseView.setup(breed: breed, imageUrl: imageUrl)
    }
}
