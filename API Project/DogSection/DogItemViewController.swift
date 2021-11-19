//
//  DogItemViewController.swift
//  API Project
//
//  Created by Jonas Jacobs on 11/17/21.
//

import UIKit

class DogItemViewController: UIViewController {
    
    @IBOutlet weak var dogImage: UIImageView!
    
    let dogItemController = DogItemController()
    
    func fetchMatchingItems() {
        
        dogItemController.fetchItems() { result in
            switch result { case .success(let image):
                DispatchQueue.main.async {
                    self.dogImage.image = image
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    @IBAction func newDogButtonTapped(_ sender: Any) {
        fetchMatchingItems()
    }
}
