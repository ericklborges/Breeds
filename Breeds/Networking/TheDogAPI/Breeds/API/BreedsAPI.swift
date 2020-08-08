//
//  BreedsAPI.swift
//  Breeds
//
//  Created by erick.lozano.borges on 05/08/20.
//  Copyright © 2020 borges.erick. All rights reserved.
//

import Foundation

class BreedsAPI {
    
    private let manager: RequestManager
    
    init(manager: RequestManager) {
        self.manager = manager
    }
    
    func fetchBreeds(limit: Int, page: Int, completion: @escaping(Result<[Breed], Error>) -> Void) {
        let url = TheDogAPISources.baseUrl.appendingPathComponent("/v1/breeds")
        let headers = TheDogAPISources.authHeader
        
        let parameters = [
            "limit": limit,
            "page": page
        ]
        
        manager.request(url: url, method: .get, parameters: parameters, headers: headers, completion: completion)
    }
}
