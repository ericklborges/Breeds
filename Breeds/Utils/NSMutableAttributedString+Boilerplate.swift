//
//  NSMutableAttributedString+Boilerplate.swift
//  Breeds
//
//  Created by erick.lozano.borges on 15/08/20.
//  Copyright © 2020 borges.erick. All rights reserved.
//

import UIKit
import Foundation

extension NSMutableAttributedString {
    
    @discardableResult
    func regular(_ text: String, size: CGFloat = 17, color: UIColor = TextColor.primary) -> NSMutableAttributedString {
        return self.mutableAttributedString(weight: .regular, text, size: size, color: color)
    }
    
    @discardableResult
    func bold(_ text: String, size: CGFloat = 17, color: UIColor = TextColor.primary) -> NSMutableAttributedString {
        return self.mutableAttributedString(weight: .bold, text, size: size, color: color)
    }
    
    private func mutableAttributedString(weight: UIFont.Weight, _ text: String, size: CGFloat, color: UIColor) -> NSMutableAttributedString {
        let mutableString = NSMutableAttributedString(
            string: text,
            attributes: [
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: size, weight: weight),
                NSAttributedString.Key.foregroundColor: color
            ]
        )
        self.append(mutableString)
        return self
    }
    
}
