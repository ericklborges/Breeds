//
//  Colors.swift
//  Breeds
//
//  Created by erick.lozano.borges on 10/08/20.
//  Copyright © 2020 borges.erick. All rights reserved.
//

import UIKit

private enum Colors {
    static let darkBlue = UIColor(18, 78, 127)
    static let lightBlue = UIColor(1, 161, 228)
    static let orange = UIColor(251, 207, 59)
    static let white = UIColor(255, 255, 255)
}

enum TextColor {
    static let highlight = Colors.lightBlue
    static let primary = Colors.white
    static let title = Colors.darkBlue
}

enum BackgroundColor {
    static let main = Colors.darkBlue
    static let navigation = Colors.orange
    static let overlay = Colors.darkBlue.withAlphaComponent(0.5)
}
