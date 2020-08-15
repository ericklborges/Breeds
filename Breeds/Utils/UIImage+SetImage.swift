//
//  UIImage+SetImage.swift
//  Breeds
//
//  Created by erick.lozano.borges on 09/08/20.
//  Copyright © 2020 borges.erick. All rights reserved.
//

import Kingfisher
import UIKit

extension UIImageView {
    func setImage(url: URL?) {
        self.kf.indicatorType = .activity
        self.kf.setImage(with: url)
    }
}
