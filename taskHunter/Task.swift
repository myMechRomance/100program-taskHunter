//
//  Task.swift
//  taskHunter
//
//  Created by Taosong YU on 2023/3/7.
//

import Foundation

struct Task: Equatable, Hashable, Codable, Identifiable {
    
    let id: UUID
    var title: String
    var ifDone: Bool
    var species: String
    
    init(title: String) {
        id = UUID()
        self.title = title
        ifDone = false
        species = ""
    }
    
    init(title: String, species: String) {
        id = UUID()
        self.title = title
        ifDone = false
        self.species = species
    }
}

