//
//  DogItemController.swift
//  API Project
//
//  Created by Jonas Jacobs on 11/16/21.
//

import Foundation
import UIKit

class DogItemController {
    func fetchItems(completion:
                    @escaping (Result<UIImage, Error>) -> Void) {
        let url = URL(string: "https://dog.ceo/api/breeds/image/random")!
        let task = URLSession.shared.dataTask(with: url)
        { (data, response, error) in
            if let error = error {
                completion(.failure(error))
            } else if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let dogItem = try
                    decoder.decode(DogItem.self, from: data)
                    let dogTask = URLSession.shared.dataTask(with: URL(string: dogItem.message)!) { data, urlresponse, error in
                        if let error = error {
                            print(error)
                            completion(.failure(error))
                        } else if let data = data, let image = UIImage(data: data) {
                            completion(.success(image))
                        }
                    }
                    dogTask.resume()
                } catch {
                    completion(.failure(error))
                }
            }
        }
        task.resume()
    }
}
