//
//  taskHunterApp.swift
//  taskHunter
//
//  Created by Taosong YU on 2023/2/21.
//

import SwiftUI

@main
struct taskHunterApp: App {
    @EnvironmentObject var userData: UserData
    //测试
    let defaultUserData = UserData()
    init() {
        defaultUserData.tasks = [
            Task(title: "Do 20 bench presses", species: "Bull"),
            Task(title: "Read part 5 of THE TALE OF GENJI", species: "Bookworm")
        ]
    }

    var body: some Scene {
            WindowGroup {
                TaskListView().environmentObject(defaultUserData)
            }
        }
//
//    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
//        TaskListView().environmentObject(UserData(ifTest: true))
//        return true
//    }
}


///预设任务：
///Do 20 bench presses
///Read Chpt. 5 of Hamlet

