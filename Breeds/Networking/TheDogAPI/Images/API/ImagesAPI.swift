//
//  ImagesAPI.swift
//  Breeds
//
//  Created by erick.lozano.borges on 06/08/20.
//  Copyright © 2020 borges.erick. All rights reserved.
//

import Foundation

class ImagesAPI {
    
    private let manager: RequestManager
    
    init(manager: RequestManager) {
        self.manager = manager
    }
    
    func fetchImages(breedId: Int, completion: @escaping(Result<[Image], Error>) -> Void) {
        let url = TheDogAPISources.baseUrl.appendingPathComponent("/v1/images/search")
        let headers = TheDogAPISources.authHeader
        
        let parameters = [
            "breed_id": breedId
        ]
        
        manager.request(url: url, method: .get, parameters: parameters, headers: headers, completion: completion)
    }
}
