//
//  BreedCollectionViewCell.swift
//  Breeds
//
//  Created by erick.lozano.borges on 09/08/20.
//  Copyright © 2020 borges.erick. All rights reserved.
//

import SwiftUI
import UIKit

protocol ViewCodable {
    func setupViews()
    func setupViewHierarchy()
    func setupConstraints()
    func setupAditionalConfiguration()
}

extension ViewCodable {
    func setupViews() {
        setupViewHierarchy()
        setupConstraints()
        setupAditionalConfiguration()
    }
    
    func setupAditionalConfiguration() { }
}

class BreedCollectionViewCell: UICollectionViewCell {
    
    // MARK: Views
    let imageView: UIImageView = {
        let image = UIImageView(frame: .zero)
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let overlayView: UIView = {
        let view = UIImageView(frame: .zero)
        view.backgroundColor = BackgroundColor.overlay
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.numberOfLines = 1
        label.textColor = TextColor.primary
        label.font = UIFont.systemFont(ofSize: 13, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: Life Cycle
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupViews()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Setup
    func setup(image: Image) {
        nameLabel.text = image.breeds.first?.name ?? "Breed not identified"
        imageView.setImage(url: URL(string: image.url))
    }
}

// MARK: Autolayout
extension BreedCollectionViewCell: ViewCodable {
    func setupViewHierarchy() {
        addSubview(imageView)
        addSubview(overlayView)
        overlayView.addSubview(nameLabel)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
        
            overlayView.heightAnchor.constraint(equalToConstant: 24),
            overlayView.bottomAnchor.constraint(equalTo: bottomAnchor),
            overlayView.leadingAnchor.constraint(equalTo: leadingAnchor),
            overlayView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            nameLabel.topAnchor.constraint(equalTo: overlayView.topAnchor),
            nameLabel.bottomAnchor.constraint(equalTo: overlayView.bottomAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: overlayView.leadingAnchor, constant: 16),
            nameLabel.trailingAnchor.constraint(equalTo: overlayView.trailingAnchor, constant: -16)
        ])
    }
}
