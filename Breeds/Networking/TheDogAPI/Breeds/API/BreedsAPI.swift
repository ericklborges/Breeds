//
//  BreedsAPI.swift
//  Breeds
//
//  Created by erick.lozano.borges on 05/08/20.
//  Copyright © 2020 borges.erick. All rights reserved.
//

import Alamofire
import Foundation

class BreedsAPI {
    func fetchBreeds(limit: Int, page: Int, completion: @escaping(DataResponse<[Breed], AFError>) -> Void) {
        let path = TheDogAPISources.baseUrl + "/v1/breeds"
        let header = HTTPHeaders(TheDogAPISources.authHeader)
        
        let parameters = [
            "limit": limit,
            "page": page
        ]
        
        AF.request(path, method: .get, parameters: parameters, headers: header)
            .responseDecodable(of: [Breed].self, completionHandler: completion)
    }
}
