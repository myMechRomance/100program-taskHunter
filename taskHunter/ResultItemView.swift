//
//  ResultItemView.swift
//  taskHunter
//
//  Created by Taosong YU on 2023/3/16.
//

import SwiftUI

struct ResultItemView: View {
    @EnvironmentObject var userData: UserData
    let task: Task
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .foregroundColor(.gray)
            TaskInfoView(task: task)
                
//            Spacer()
//            if task.ifDone {
//                Image(systemName: "checkmark")
//                    .foregroundColor(.green)
//            } else {
//                Image(systemName: "xmark.circle")
//                    .foregroundColor(.red)
//            }
        }
    }
    
    init(task: Task) {
        self.task = task
    }
}
