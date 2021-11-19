//
//  File.swift
//  API Project
//
//  Created by Jonas Jacobs on 11/18/21.
//

import Foundation

struct RepItem: Codable {
    var name: String
    var party: String
    var state: String
    var link: String
}
struct searchResponse: Codable {
    var results: [RepItem]
}
