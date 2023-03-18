//
//  TaskInfoView.swift
//  taskHunter
//
//  Created by Taosong YU on 2023/3/18.
//

import SwiftUI
//显示task条目的基本信息
struct TaskInfoView: View {
    let task: Task
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(.background)
                .brightness(0.9)
            HStack {
                Image(systemName: "person")
                    .resizable()
                    .frame(width: 50, height: 50)
                VStack(alignment: .leading) {
                    Text(task.title)
                        .font(.title)
                    Text(task.species)
                }
                Spacer()
            }
            .padding(10)
        }
        .frame(maxWidth: .infinity, minHeight: 0)
    }
}
