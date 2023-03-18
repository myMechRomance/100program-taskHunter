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
    
//    init() {
//        setLastOpenDate()
//    }
    
    var body: some Scene {
            WindowGroup {
                TaskListView().environmentObject(UserData())
            }
        }

//    func setLastOpenDate() {
//        let defaults = UserDefaults.standard
//        let today = Date()
//        // 获取最近一次打开应用程序的日期
//        if let lastOpenedDate = defaults.object(forKey: "today") as? Date
//        {
//            print("Today: \(today)")
//            print("lastOpenedDate: \(lastOpenedDate)")
//            // 判断最近一次打开应用程序的日期是否与当前日期相同
//            if Calendar.current.isDate(lastOpenedDate, inSameDayAs: today) {
//                // 最近一次打开应用程序的日期与当前日期相同，不需要运行特定语句
//            } else {
//                // 最近一次打开应用程序的日期与当前日期不同，删除任务列表
//                userData.tasks.removeAll()
//                // 存储当前日期为最近一次打开应用程序的日期
//                defaults.set(today, forKey: "today")
//            }
//        }
//        else {
//            defaults.set(today, forKey: "today")  //
//            return
//        }
//    }
}
