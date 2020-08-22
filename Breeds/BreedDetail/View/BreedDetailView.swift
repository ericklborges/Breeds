//
//  BreedDetailView.swift
//  Breeds
//
//  Created by erick.lozano.borges on 15/08/20.
//  Copyright © 2020 borges.erick. All rights reserved.
//

import UIKit

class BreedDetailLabel: UILabel {
    
    // MARK: Init
    init() {
        super.init(frame: .zero)
        self.numberOfLines = 0
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Setup
    func setup(title: String, description: String?) {
        guard let description = description, !description.isEmpty else {
            removeFromSuperview()
            return
        }
        
        let attributedText = NSMutableAttributedString()
        attributedText.bold(title)
        attributedText.regular(description)
        self.attributedText = attributedText
    }
}

class BreedDetailView: UIView, NibLoadable {
    
    // MARK: Views
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView(frame: .zero)
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    let breedImage: UIImageView = {
        let image = UIImageView(frame: .zero)
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let stackView: UIStackView = {
        let stack = UIStackView(frame: .zero)
        stack.spacing = 16.0
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    let nameLabel = BreedDetailLabel()
    let weightLabel = BreedDetailLabel()
    let heightLabel = BreedDetailLabel()
    let lifespanLabel = BreedDetailLabel()
    let temperamentLabel = BreedDetailLabel()
    let bredForLabel = BreedDetailLabel()
    let breedGroupLabel = BreedDetailLabel()
    let originLabel = BreedDetailLabel()
    
    init() {
        super.init(frame: .zero)
        setupViews()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setup(breed: Breed?, imageUrl: String?) {
        guard
            let breed = breed,
            let imageUrl = imageUrl
            else { return }
        
        breedImage.setImage(url: URL(string: imageUrl))
        nameLabel.setup(title: "Name: ", description: breed.name)
        weightLabel.setup(title: "Weight: ", description: breed.weight.metric)
        heightLabel.setup(title: "Height: ", description: breed.height.metric)
        lifespanLabel.setup(title: "Life Span: ", description: breed.lifeSpan)
        temperamentLabel.setup(title: "Temperament: ", description: breed.temperament)
        bredForLabel.setup(title: "Breed For: ", description: breed.bredFor)
        breedGroupLabel.setup(title: "BreedGroup: ", description: breed.breedGroup)
        originLabel.setup(title: "Origin: ", description: breed.origin)
    }
}

// MARK: Autolayout
extension BreedDetailView: ViewCodable {
    func setupViewHierarchy() {
        addSubview(scrollView)
        
        scrollView.addSubview(breedImage)
        scrollView.addSubview(stackView)
        
        stackView.addArrangedSubview(nameLabel)
        stackView.addArrangedSubview(weightLabel)
        stackView.addArrangedSubview(heightLabel)
        stackView.addArrangedSubview(lifespanLabel)
        stackView.addArrangedSubview(temperamentLabel)
        stackView.addArrangedSubview(bredForLabel)
        stackView.addArrangedSubview(breedGroupLabel)
        stackView.addArrangedSubview(originLabel)
        stackView.addArrangedSubview(nameLabel)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            breedImage.topAnchor.constraint(equalTo: scrollView.topAnchor),
            breedImage.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            breedImage.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            breedImage.widthAnchor.constraint(equalTo: widthAnchor),
            breedImage.heightAnchor.constraint(equalTo: breedImage.widthAnchor, multiplier: 1),
            
            stackView.topAnchor.constraint(equalTo: breedImage.bottomAnchor, constant: 16),
            stackView.bottomAnchor.constraint(greaterThanOrEqualTo: scrollView.bottomAnchor, constant: -16),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -16)
        ])
    }
    
    func setupAditionalConfiguration() {
        backgroundColor = BackgroundColor.main
    }
}
