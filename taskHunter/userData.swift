//
//  userData.swift
//  taskHunter
//
//  Created by Taosong YU on 2023/3/7.
//

import SwiftUI
//import Foundation
import Combine
//TODO: 测试
private let defaultTasks = [
    Task(title: "Do 20 bench presses"),
    Task(title: "Read part 5 of THE TALE OF GENJI")
]
private let defaultSpecieses = [
    Species(title: "Muscle gorilla"),
    Species(title: "Book worm")
]
//用于在不同视图间共享任务数据
final class UserData: ObservableObject {
    let objectWillChange = PassthroughSubject<UserData, Never>()
    var ifPopUp = false
    
    //将defaultTasks传入tasks
    @UserDefaultValue(key: "tasks", defaultValue: defaultTasks)
    var tasks: [Task] {
        didSet {
            objectWillChange.send(self)
        }
    }
    @UserDefaultValue(key: "Species", defaultValue: defaultSpecieses)
    var specieses: [Species] {
        didSet {
            objectWillChange.send(self)
        }
    }
    @UserDefaultValue(key: "today", defaultValue: Date(timeIntervalSince1970: 0))
    var today: Date {
        didSet {
            objectWillChange.send(self)
        }
    }
    
    init () {
        let calendar = Calendar.current
        let _today = calendar.startOfDay(for: Date())
        if today != _today {  //如果日期更迭，弹出结算窗口
            ifPopUp = true
        }
    }
}




