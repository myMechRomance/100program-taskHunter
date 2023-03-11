//
//  Species.swift
//  taskHunter
//
//  Created by Taosong YU on 2023/3/8.
//

import Foundation

struct Species : Equatable, Hashable, Codable, Identifiable {

    let id: UUID
    var title: String
    
    init(title: String) {
        id = UUID()
        self.title = title
    }
}
