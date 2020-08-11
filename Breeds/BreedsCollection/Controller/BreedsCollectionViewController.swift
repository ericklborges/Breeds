//
//  BreedsCollectionViewController.swift
//  Breeds
//
//  Created by erick.lozano.borges on 09/08/20.
//  Copyright © 2020 borges.erick. All rights reserved.
//

import UIKit

class BreedsCollectionViewController: UICollectionViewController {
    
    // MARK: Init
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
    }
    
    // MARK: Setup
    private func setupNavigation() {
        navigationController?.applyCustomAppearence()
        navigationController?.navigationBar.prefersLargeTitles = true
    }
}

// MARK: - UICollectionViewDataSource
extension BreedsCollectionViewController {
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Identifier.Cell.breedCell, for: indexPath) as? BreedCollectionViewCell else {
             return UICollectionViewCell()
        }
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension BreedsCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = UIScreen.main.bounds.width / 2
        return CGSize(width: size, height: size)
    }
}
