//
//  Identifier.swift
//  Breeds
//
//  Created by erick.lozano.borges on 10/08/20.
//  Copyright © 2020 borges.erick. All rights reserved.
//

import Foundation

enum Identifier {
    enum Storyboard {
        enum Main {
            static let name = "Main"
            static let breedDetailViewController = "BreedDetailViewController"
        }
    }
    
    enum Cell {
        static let breedCell = "BreedCell"
    }
    
    enum Segue {
        static let goToBreedDetail = "GoToBreedDetail"
    }   
}
