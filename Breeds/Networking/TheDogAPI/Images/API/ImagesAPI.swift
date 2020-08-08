//
//  ImagesAPI.swift
//  Breeds
//
//  Created by erick.lozano.borges on 06/08/20.
//  Copyright © 2020 borges.erick. All rights reserved.
//

import Alamofire
import Foundation

class ImagesAPI {
    func fetchImages(breedId: Int, completion: @escaping(DataResponse<[Image], AFError>) -> Void) {
        let path = TheDogAPISources.baseUrl.appendingPathComponent("/v1/images/search")
        let header = HTTPHeaders(TheDogAPISources.authHeader)
        
        let parameters = [
            "breed_id": breedId
        ]
        
        AF.request(path, method: .get, parameters: parameters, headers: header)
            .responseDecodable(of: [Image].self, completionHandler: completion)
    }
}
