//
//  BreedImagesAPI.swift
//  Breeds
//
//  Created by erick.lozano.borges on 06/08/20.
//  Copyright © 2020 borges.erick. All rights reserved.
//

import Foundation

class BreedImagesAPI {
    
    private let manager: RequestManager
    
    init(manager: RequestManager = RequestManagerFactory.create()) {
        self.manager = manager
    }
    
    func fetchImages(limit: Int, page: Int, completion: @escaping(Result<[BreedImage], Error>) -> Void) {
        let url = TheDogAPISources.baseUrl.appendingPathComponent("/v1/images/search")
        let headers = TheDogAPISources.authHeader
        
        let parameters: [String: Any] = [
            "order": "Asc",
            "limit": limit,
            "page": page
        ]
        
        manager.request(url: url, method: .get, parameters: parameters, headers: headers, completion: completion)
    }
}
