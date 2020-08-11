//
//  BreedCollectionViewCell.swift
//  Breeds
//
//  Created by erick.lozano.borges on 09/08/20.
//  Copyright © 2020 borges.erick. All rights reserved.
//

import UIKit

class BreedCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    func setup(image: Image) {
        nameLabel.text = image.breeds.first?.name
        imageView.setImage(url: URL(string: image.url))
    }
    
}
