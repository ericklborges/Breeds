//
//  UINavigationController+CustomAppearence.swift
//  Breeds
//
//  Created by erick.lozano.borges on 10/08/20.
//  Copyright © 2020 borges.erick. All rights reserved.
//

import UIKit

extension UINavigationController {
    func applyCustomAppearence() {
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        navBarAppearance.titleTextAttributes = [.foregroundColor: TextColor.title]
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: TextColor.title]
        navBarAppearance.backgroundColor = BackgroundColor.navigation
        
        navigationBar.standardAppearance = navBarAppearance
        navigationBar.scrollEdgeAppearance = navBarAppearance
    }
}
