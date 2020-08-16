//
//  BreedDetailView.swift
//  Breeds
//
//  Created by erick.lozano.borges on 15/08/20.
//  Copyright © 2020 borges.erick. All rights reserved.
//

import UIKit

class BreedDetailView: UIView, NibLoadable {
    
    @IBOutlet weak var breedImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var lifespanLabel: UILabel!
    @IBOutlet weak var temperamentLabel: UILabel!
    @IBOutlet weak var bredForLabel: UILabel!
    @IBOutlet weak var breedGroupLabel: UILabel!
    @IBOutlet weak var originLabel: UILabel!
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupFromNib()
    }
    
    func setup(breed: Breed?, imageUrl: String?) {
        guard
            let breed = breed,
            let imageUrl = imageUrl
            else { return }
        
        breedImage.setImage(url: URL(string: imageUrl))
        setup(title: "Name: ", description: breed.name, label: nameLabel)
        setup(title: "Weight: ", description: breed.weight.metric, label: weightLabel)
        setup(title: "Height: ", description: breed.height.metric, label: heightLabel)
        setup(title: "Life Span: ", description: breed.lifeSpan, label: lifespanLabel)
        setup(title: "Temperament: ", description: breed.temperament, label: temperamentLabel)
        setup(title: "Breed For: ", description: breed.bredFor, label: bredForLabel)
        setup(title: "BreedGroup: ", description: breed.breedGroup, label: breedGroupLabel)
        setup(title: "Origin: ", description: breed.origin, label: originLabel)
    }
    
    func setup(title: String, description: String?, label: UILabel) {
        guard let description = description, !description.isEmpty else {
            label.removeFromSuperview()
            return
        }
        
        let attributedText = NSMutableAttributedString()
        attributedText.bold(title)
        attributedText.regular(description)
        label.attributedText = attributedText
    }
    
}
