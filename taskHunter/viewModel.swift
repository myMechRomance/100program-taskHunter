//
//  viewModel.swift
//  taskHunter
//
//  Created by Taosong YU on 2023/3/2.
//

import SwiftUI

class ViewModel_TH: ObservableObject {
    @Published private var model: Model_TH
    init() {
        self.model = Model_TH()
        
    }
    init(_ model: Model_TH) {
        self.model = model
    }
}
