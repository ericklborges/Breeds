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

// MARK: - Navigation
extension BreedsCollectionViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard
            segue.identifier == Identifier.Segue.goToBreedDetail,
            let breedDetailController = segue.destination as? BreedDetailViewController
            else { return }
        
        breedDetailController.breed = viewModel.currentSelectedBreed
        breedDetailController.imageUrl = viewModel.currentSelectedImage?.url
    }
    
    private func showEmptyBreedFeedback() {
        let alert = UIAlertController(title: "Missing Breed", message: "The selected image does not have a releted Breed yet 😢", preferredStyle: .alert)
        alert.addAction(.init(title: "Ok", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}

// MARK: - UICollectionViewDelegate
extension BreedsCollectionViewController {
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard viewModel.hasAvailableBreedFor(indexPath.row) else {
            showEmptyBreedFeedback()
            return
        }
        performSegue(withIdentifier: Identifier.Segue.goToBreedDetail, sender: self)
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
