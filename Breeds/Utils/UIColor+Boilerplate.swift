//
//  UIColor+Boilerplate.swift
//  Breeds
//
//  Created by erick.lozano.borges on 10/08/20.
//  Copyright © 2020 borges.erick. All rights reserved.
//

import UIKit

extension UIColor {
    convenience init(_ red: CGFloat, _ green: CGFloat, _ blue: CGFloat, _ alpha: CGFloat = 1.0) {
        self.init(red: red/255.0, green: green/255.0, blue: blue/255.0, alpha: alpha)
    }
}
