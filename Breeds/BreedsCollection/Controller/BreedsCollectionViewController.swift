//
//  BreedsCollectionViewController.swift
//  Breeds
//
//  Created by erick.lozano.borges on 09/08/20.
//  Copyright © 2020 borges.erick. All rights reserved.
//

import UIKit

class BreedsCollectionViewController: UIViewController {
    
    // MARK: Views
    let collectionFlowLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = .zero
        layout.minimumInteritemSpacing = .zero
        return layout
    }()
    
    lazy var collectionView: UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: collectionFlowLayout)
        collection.delegate = self
        collection.dataSource = self
        collection.prefetchDataSource = self
        collection.backgroundColor = BackgroundColor.main
        collection.register(BreedCollectionViewCell.self, forCellWithReuseIdentifier: Identifier.Cell.breedCell)
        collection.translatesAutoresizingMaskIntoConstraints = false
        return collection
    }()
    
    // MARK: Properties
    private lazy var viewModel = BreedsCollectionViewModel(delegate: self)
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupNavigation()
        viewModel.fetchImages()
    }
    
    // MARK: Setup
    func setupNavigation() {
        title = "Breeds"
        navigationController?.applyCustomAppearence()
        navigationController?.navigationBar.prefersLargeTitles = true
    }
}

// MARK: - Autolayout
extension BreedsCollectionViewController: ViewCodable {
    func setupViewHierarchy() {
        view.addSubview(collectionView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}

// MARK: - Navigation
extension BreedsCollectionViewController {
    func showDetailForSelectedBreed() {
        guard
            let selectedBreed = viewModel.currentSelectedBreed,
            let selectedImageUrl = viewModel.currentSelectedImage?.url
            else { return }
        
        let storyboard = UIStoryboard(name: Identifier.Storyboard.Main.name, bundle: Bundle(for: Self.self))
        
        let breedDetailController = storyboard.instantiateViewController(identifier: Identifier.Storyboard.Main.breedDetailViewController, creator: { coder in
            return BreedDetailViewController(coder: coder, breed: selectedBreed, imageUrl: selectedImageUrl)
        })
        
        show(breedDetailController, sender: self)
    }
    
    private func showEmptyBreedFeedback() {
        let alert = UIAlertController(title: "Missing Breed", message: "The selected image does not have a releted Breed yet 😢", preferredStyle: .alert)
        alert.addAction(.init(title: "Ok", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension BreedsCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard viewModel.hasAvailableBreedFor(indexPath.row) else {
            showEmptyBreedFeedback()
            return
        }
        showDetailForSelectedBreed()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = UIScreen.main.bounds.width / 2
        return CGSize(width: size, height: size)
    }
}

// MARK: - UICollectionViewDataSource
extension BreedsCollectionViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Identifier.Cell.breedCell, for: indexPath) as? BreedCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.setup(image: viewModel.images[indexPath.row])
        return cell
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
