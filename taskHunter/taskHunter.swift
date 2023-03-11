//
//  taskHunterApp.swift
//  taskHunter
//
//  Created by Taosong YU on 2023/2/21.
//

import SwiftUI



@main
struct taskHunterApp: App {
    ///TODO: 测试代码，删去
//    let userData: UserData
//    let taskListView: TaskListView
var body: some Scene {
        WindowGroup {
            TaskListView().environmentObject(UserData())
        }
    }
}
