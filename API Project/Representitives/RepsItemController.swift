//
//  RepsItemController.swift
//  API Project
//
//  Created by Jonas Jacobs on 11/18/21.
//

import Foundation

class RepsItemController {
    func fetchItems(matching query: [String: String], completion:
       @escaping (Result<[RepItem], Error>) -> Void) {
        var urlComponents = URLComponents(string:
           "http://whoismyrepresentative.com/getall_mems.php?")!
        urlComponents.queryItems = query.map { URLQueryItem(name: $0.key,
           value: $0.value) }
        let task = URLSession.shared.dataTask(with: urlComponents.url!)
           { (data, response, error) in
            if let error = error {
                completion(.failure(error))
            } else if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let searchResponse = try
                       decoder.decode(searchResponse.self, from: data)
                    completion(.success(searchResponse.results))
                } catch {
                    completion(.failure(error))
                }
            }
        }
        task.resume()
    }
    
}
