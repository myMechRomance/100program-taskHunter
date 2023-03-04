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
    init () {
        
    }
//        model: Model_TH(
//        tasks: [
//        Model_TH.Task(title: "Great Jagras", comment: "It looks pregnated.",img: "child-大凶豺龙"),
//        Model_TH.Task(title: "Pukei-Pukei", comment: "It has a good appetite.", img: "child-毒妖鸟"),
//        Model_TH.Task(title: "Tobi Kadachi", comment: "Its fur can generate electricity by friction.", img: "child-飞雷龙")
//        ],
//        taskTypes: [
//            Model_TH.TaskType(title: "land",
//        ]))
    var body: some Scene {
        WindowGroup {
            View_TH()
        }
    }
}
