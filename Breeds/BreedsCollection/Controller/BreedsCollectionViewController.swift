//
//  BreedsCollectionViewController.swift
//  Breeds
//
//  Created by erick.lozano.borges on 09/08/20.
//  Copyright © 2020 borges.erick. All rights reserved.
//

import UIKit

class BreedsCollectionViewController: UICollectionViewController {

    // MARK: Properties
    private lazy var viewModel = BreedsCollectionViewModel(delegate: self)
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
        viewModel.fetchImages()
        collectionView.prefetchDataSource = self
    }
    
    func setupNavigation() {
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
        return viewModel.images.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Identifier.Cell.breedCell, for: indexPath) as? BreedCollectionViewCell else {
             return UICollectionViewCell()
        }
        cell.setup(image: viewModel.images[indexPath.row])
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension BreedsCollectionViewController {
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: Identifier.Segue.goToBreedDetail, sender: self)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension BreedsCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = UIScreen.main.bounds.width / 2
        return CGSize(width: size, height: size)
    }
}

// MARK: - UICollectionViewDataSourcePrefetching
extension BreedsCollectionViewController: UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        if viewModel.shouldPrefetchImages(for: indexPaths) {
            viewModel.fetchImages()
        }
    }
}

// MARK: - BreedsCollectionViewModelDelegate
extension BreedsCollectionViewController: BreedsCollectionViewModelDelegate {
    func didReceiveImages() {
        collectionView.reloadData()
    }
    
    func didReceiveError() {
        print("Error State")
    }
}
