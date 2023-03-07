//
//  t.swift
//  taskHunter
//
//  Created by Taosong YU on 2023/2/22.
//

import Foundation
import SwiftUI

struct Model_TH: {
    //预定义类型
    ///标记任务完成状态
    enum State: String{
        case notStarted = "notStarted"
        case toBeDone = "toBeDone"
        case Done = "Done"
        case Failed = "Failed"
    }

    ///一项任务，类比一个怪物
    struct Task {
        var title: String  //标题
        var comment: String?  //描述
        var date = {
            // 获取今天凌晨0点的时间
            let calendar = Calendar.current
            let dateComponents = calendar.dateComponents([.year, .month, .day], from: Date())
            let startOfDay = calendar.date(from: dateComponents)!
            return startOfDay
        }()  //创建日期（当天零点）
        var startTime = TimeInterval(0)  //开始时间（以秒计算）
        var endTime = TimeInterval(24*60*60-60)  //结束时间（以秒计算）
        var state: State = .notStarted  //完成状态
        var img: String  //图片
        var type: String?
        
        var timer: TimeInterval {
            mutating get {
                let time = Date().timeIntervalSince(date)
                if time >= startTime && state == .notStarted {
                    state = .toBeDone
                }
                if time > endTime && startTime < endTime && state == .toBeDone {
                    state = .Failed
                }
                return endTime-time
            }
        }
//        var dateStr: String {
//            get {
//                let time2Str = DateFormatter()
//                time2Str.dateFormat = "yyyy-MM-dd HH:mm:ss.SSS"
//                return time2Str.string(from: date ?? Date(timeIntervalSince1970: 0))
//            }
//        }
//        var stateStr: String {
//            get {
//                return state.rawValue
//            }
//        }
    }
//    ///标记一类任务，类比一个种族
//    struct TaskType: Equatable {
//        var title: String  //标题
//        var comment: String?  //描述
//        var img: String?  //图片
//        var tasks: Array<Task> = []
//        //        var notStartedCount = 0
//        //        var toBeDoneCount = 0
//        var doneCount = 0
//        var failedCount = 0
////        var doneCount: Int {
////            get{
////                var count = 0
////                for task in tasks {
////                    if task.state == .Done {
////                        count += 1
////                    }
////                }
////                return count
////            }
////        }
////        var failedCount: Int {
////            get{
////                var count = 0
////                for task in tasks {
////                    if task.state == .Failed {
////                        count += 1
////                    }
////                }
////                return count
////            }
////        }
//        var successRate: Int {
//            get {
//                if doneCount+failedCount == 0 {
//                    return 0
//                }
//                else {
//                    return 100*doneCount/(doneCount+failedCount)
//                }
//            }
//        }
//        //        mutating func stateCount() {  //统计各状态任务的个数
//        //            var notStartedCount = 0
//        //            var toBeDoneCount = 0
//        //            var doneCount = 0
//        //            var failedCount = 0
//        //            for task in tasks {
//        //                switch task.state {
//        //                case .notStarted: notStartedCount += 1
//        //                case .toBeDone: toBeDoneCount += 1
//        //                case .Done: doneCount += 1
//        //                case .Failed: failedCount += 1
//        //                }
//        //            }
//        //        }
//        //若标题相同，则属于同一任务
//        static public func ==(lhs: TaskType, rhs:TaskType) -> Bool{
//            return lhs.title == rhs.title
//        }
//    }
    //TODO: 测试日期变更
    ///标记某天的任务
    struct DailyTasks {
        var tasks: Array<Task> = []
        var date: Date
        var dateStr: String {
            get {
                let date2Str = DateFormatter()
                date2Str.dateFormat = "yyyy-MM-dd"
                return date2Str.string(from: date)
            }
        }
        init(_ date: Date) {
            self.date = date
        }
    }

    //属性
//    private(set) var tasks: Array<Task> = []  //用于保存历史记录过的所有任务
//    private(set) var taskTypes: Array<TaskType> = [] //用于保存所有任务类型
    @Published private(set) var dailyTasks = DailyTasks(Date())  //用于存储今天任务
    //方法
    init() {}
    ///测试用初始化函数，预设了任务
    init(ifTest: Bool) {
        assert(ifTest)
//        addTaskType(title: "land", comment: "Monster live on land.")
        var greatJagras_id = addTask(title: "Great Jagras", comment: "It looks pregnated.", type_id: 0)
        var tobiKadachi_id = addTask(title: "Tobi Kadachi", comment: "Its fur can generate electricity by friction.", type_id: 0)
//        bird_id = model.addTaskType(title: "bird", comment: "Monster can fly.")
        var pukeiPukei_id = addTask(title: "Pukei-Pukei", comment: "It has a good appetite.", type_id: 1)
    }
    //TODO: 随机生成不同的图像，返回其路径
    private func genImg(type_id: Int, level: Int) -> String {
//        let srcImg = taskTypes[type_id].title+"/lv"+String(level)
//        print("Generating img from "+srcImg)
        return "undefined-lv1"
    }
    //MARK: 添加任务类方法。顺序：*addTaskType->addTask->addDailyTask
    ///向dailyTasks添加新任务，返回在dailyTasks中的索引
    mutating public func addTask(title: String, comment: String, type_id: Int) -> Int {
//        assert(type_id>=0 && type_id<taskTypes.count)
        let img = genImg(type_id: type_id, level: 0)
        let task=Task(title: title,
                      comment: comment,
                      img: img,
                      type: String(type_id))
        dailyTasks.tasks.append(task)
        return dailyTasks.tasks.count-1
    }
    ///向taskType添加新类型，返回在taskTypes中的索引
//    public func addTaskType(title: String, comment: String) -> Int {
//        var taskType = TaskType(title: title, comment: comment)
//        while taskTypes.contains(taskType) {  //与taskTypes中已有标题重复
//            taskType.title += "*"
//        }
//        taskTypes.append(taskType)
//        return taskTypes.count-1
//    }
    ///在dailyTasks中删除任务
    mutating public func delTask(task_id: Int) {
        assert(task_id>=0 && task_id<dailyTasks.tasks.count)
        dailyTasks.tasks.remove(at: task_id)
    }
//    //MARK: 更改任务状态类方法
//    enum TaskProperty{
//        case title, comment, date, state, type
//    }
//    enum TaskTypeProperty{
//        case title, comment, tasks, doneCount, failedCount, successRate
//    }
//    func setTitle(dailyTaskId: Int, newTitle: String) {
//        assert(dailyTaskId>=0 && dailyTaskId<dailyTasks.tasks.count)
//        tasks[dailyTasks.tasks[dailyTaskId]].title = newTitle
//    }
//    func setComment(dailyTaskId: Int, newComment: String) {
//        assert(dailyTaskId>=0 && dailyTaskId<dailyTasks.tasks.count)
//        tasks[dailyTasks.tasks[dailyTaskId]].comment = newComment
//    }
//    func setState(dailyTaskId: Int) {
//        assert(dailyTaskId>=0 && dailyTaskId<dailyTasks.tasks.count)
//        if tasks[dailyTasks.tasks[dailyTaskId]].state == .toBeDone {
//            tasks[dailyTasks.tasks[dailyTaskId]].state = .Done
//            taskTypes[tasks[dailyTasks.tasks[dailyTaskId]].type].doneCount += 1
//        }
//        else if tasks[dailyTasks.tasks[dailyTaskId]].state == .Done {
//            tasks[dailyTasks.tasks[dailyTaskId]].state = .toBeDone
//            taskTypes[tasks[dailyTasks.tasks[dailyTaskId]].type].doneCount -= 1
//        }
//    }
//    func setType(dailyTaskId: Int, type: Int) {
//        assert(dailyTaskId>=0 && dailyTaskId<dailyTasks.tasks.count)
//        assert(type>=0 && type<taskTypes.count)
//        let taskId = dailyTasks.tasks[dailyTaskId]
//        //在taskTypes中更新信息
//        let oldTaskTypeId = tasks[taskId].type
////        let oldTaskTypeIdId = taskTypes[oldTaskTypeId].tasks.firstIndex(of: taskId)
//        taskTypes[oldTaskTypeId].tasks.remove(at: taskId)
//        taskTypes[type].tasks.append(taskId)
//        tasks[taskId].type = type
//    }
    //MARK: 定时类函数
//    ///每分钟更新任务状态
//    func updateState() {
//
//    }
    ///每日更新任务类方法。顺序：archiveTasks->levelUp->clearTasks
    ///将dailyTasks中的任务分类存入taskTypes
//    public func archiveTasks() {
//        for task in dailyTasks.tasks {
//            let type_id = taskTypes.firstIndex(where: {$0.title == task.type})
//            switch task.state {
//            case .Failed:
//                taskTypes[type_id!].failedCount += 1
//            case .Done:
//                taskTypes[type_id!].doneCount += 1
//            default:
//                //TODO: 处理超期的.tobeDone和notStarted
//                let a=0
//            }
//            taskTypes[type_id!].tasks.append(task)
//        }
//    }
//    //MARK: TODEL: 测试函数
//    ///打印任务列表
//    func printTasks(printInfos: [TaskProperty] = [.title, .comment, .date, .state, .type]) {
//        for task in tasks {
//            if printInfos.contains(.title) {
//                print("title: \(task.title) ", terminator: "")
//            }
//            if printInfos.contains(.comment) {
//                print("comment: \(task.comment) ", terminator: "")
//            }
//            if printInfos.contains(.date) {
//                let dateStr: String = yyyy_MM_dd.string(from: task.date)
//                print("date: \(dateStr) ", terminator: "")
//            }
//            if printInfos.contains(.state) {
//                var stateStr: String
//                switch task.state {
//                case .notStarted: stateStr = "notStarted"
//                case .toBeDone: stateStr = "toBeDone"
//                case .Done: stateStr = "Done"
//                case .Failed: stateStr = "Failed"
//                }
//                print("state: \(stateStr)", terminator: "")
//            }
//            print("")  //换行
//        }
//    }
//    
//    ///清空tasks
//    func clearTasks() {
////        printTasks()
//        tasks.removeAll()
//        print("tasks cleared")
//    }
//    ///打印任务种类列表
//    func printTaskTypes(printInfos: [TaskTypeProperty] = [.title, .comment, .tasks, .doneCount, .failedCount, .successRate]) {
//        for taskType in taskTypes {
//            if printInfos.contains(.title) {
//                print("title: \(taskType.title) ", terminator: "")
//            }
//            if printInfos.contains(.comment) {
//                print("comment: \(taskType.comment) ", terminator: "")
//            }
//            if printInfos.contains(.tasks) {
//                var tasksStr: String = ""
//                for taskId in taskType.tasks {
//                    tasksStr += "\(tasks[taskId].title), "
//                }
//                print("tasks: [\(tasksStr)] ", terminator: "")
//            }
//            if printInfos.contains(.doneCount) {
//                print("doneCount: \(taskType.doneCount) ", terminator: "")
//            }
//            if printInfos.contains(.failedCount) {
//                print("failedCount: \(taskType.failedCount) ", terminator: "")
//            }
//            if printInfos.contains(.successRate) {
//                print("successRate: \(taskType.successRate) ", terminator: "")
//            }
//            print("")  //换行
//        }
//    }
    ///打印今日任务列表
    func printDailyTasks() {
        var dailyTaskStr = "dailyTasks: ["
        for dailyTask in dailyTasks.tasks {
            dailyTaskStr += "\(dailyTask.title), "
        }
        print("\(dailyTaskStr)] ")
    }
//
//    ///清空taskTypes
//    func clearTaskTypes() {
////        printTaskTypes()
//        taskTypes.removeAll()
//        print("taskTypes cleared")
//    }
//    
}
