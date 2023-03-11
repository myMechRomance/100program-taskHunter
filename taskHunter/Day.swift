//
//  DateModification.swift
//  taskHunter
//
//  Created by Taosong YU on 2023/3/11.
//

import Foundation

struct Day: Equatable, Hashable, Codable, Identifiable {
    
    let id: UUID
    var date: Date
    
    init(date: Date) {
        id = UUID()
        self.date = date
    }
}
