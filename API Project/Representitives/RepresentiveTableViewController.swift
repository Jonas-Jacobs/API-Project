//
//  RepresentiveTableViewController.swift
//  API Project
//
//  Created by Jonas Jacobs on 11/18/21.
//

import UIKit

class RepresentiveTableViewController: UIViewController, UITableViewDelegate, UISearchBarDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    let repsItemController = RepsItemController()
    
    var items = [RepItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        fetchItems()
    }
    
    func fetchItems() {
        self.items = []
        self.tableView.reloadData()
        let searchTerm = searchBar.text ?? ""
        
        let query = [
            "zip": searchTerm,
            "output": "json"
        ]
        
        repsItemController.fetchItems(matching: query) { result in
            switch result {case .success(let repitems):
                print(repitems)
                self.items = repitems
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func configure(cell: RepsTableViewCell, forItemAt indexPath: IndexPath) {
        let item = items[indexPath.row]
        cell.nameLabel.text = item.name
        cell.partyAndLocationLabel.text = ("\(item.party), \(item.state)")
        cell.linkLabel.text = item.link
    }
   
    
    
    // MARK: - Table view data source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "representativeCell", for: indexPath) as! RepsTableViewCell
        configure(cell: cell, forItemAt: indexPath)
        
        return cell
    }
}
