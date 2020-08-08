//
//  AlamofireRequestManager.swift
//  Breeds
//
//  Created by erick.lozano.borges on 08/08/20.
//  Copyright © 2020 borges.erick. All rights reserved.
//

import Alamofire

class AlamofireRequestManager: RequestManager {
    func request<T: Decodable>(url: URL, method: HTTPMethod, parameters: [String: Any], headers: [String: String], completion: @escaping (Result<T, Error>) -> Void) {
        AF.request(url, method: method.alamofire, parameters: parameters, headers: HTTPHeaders(headers)).responseData { response in
            switch response.result {
            case let .success(data):
                do {
                    let object = try JSONDecoder().decode(T.self, from: data)
                    completion(.success(object))
                } catch let error {
                    completion(.failure(error))
                }
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}
