//
//  taskHunterApp.swift
//  taskHunter
//
//  Created by Taosong YU on 2023/2/21.
//

import SwiftUI



@main
struct taskHunterApp: App {
    let model = Model_TH()
    ///TODO: 测试代码，删去
    init () {
        let land_id = model.addTaskType(title: "land", comment: "Monster live on land.")
        let greatJagras_id = model.addTask(title: "Great Jagras", comment: "It looks pregnated.", type: land_id)
        let tobiKadachi_id = model.addTask(title: "Tobi Kadachi", comment: "Its fur can generate electricity by friction.", type: land_id)
        let bird_id = model.addTaskType(title: "bird", comment: "Monster can fly.")
        let pukeiPukei_id = model.addTask(title: "Pukei-Pukei", comment: "It has a good appetite.", type: bird_id)
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
            View_TH(model: model)
        }
    }
}
