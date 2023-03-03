//
//  t.swift
//  taskHunter
//
//  Created by Taosong YU on 2023/2/22.
//

import Foundation

class Model_TH {
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
        var title = "New monster"  //任务标题
        var comment = "None"  //任务描述
        var date = Date()  //常量??
        var state: State = .notStarted
        var type = "Undefined"  //任务所属分类
        var successRate = 0  //任务成功率,用百分数表示
        var img = "-1"
        
        
        func dateStr(format: DateFormatter) -> String {
            return format.string(from: date)
        }
        
        func typeStr(taskTypes: inout Array<TaskType>) -> String {
            if type<0 || type>=taskTypes.count {
                return "Undefined"
            }
            return taskTypes[type].title
        }
    }
    ///标记一类任务，类比一个种族
    struct TaskType {
        var title = "New race"
        var comment = "None"
        var tasks: Array<Int> = []
        //        var notStartedCount = 0
        //        var toBeDoneCount = 0
        var doneCount = 0
        var failedCount = 0
        var successRate: Int {
            get {
                if doneCount+failedCount == 0 {
                    return 0
                }
                else {
                    return 100*doneCount/(doneCount+failedCount)
                }
            }
        }
        //        mutating func addTask(task: Int) {
        //            tasks.append(task)
        //        }
        //        mutating func stateCount() {  //统计各状态任务的个数
        //            var notStartedCount = 0
        //            var toBeDoneCount = 0
        //            var doneCount = 0
        //            var failedCount = 0
        //            for task in tasks {
        //                switch task.state {
        //                case .notStarted: notStartedCount += 1
        //                case .toBeDone: toBeDoneCount += 1
        //                case .Done: doneCount += 1
        //                case .Failed: failedCount += 1
        //                }
        //            }
        //        }
    }
    ///标记某天的任务
    struct DailyTasks {
        var date = Date()
        var tasks: Array<Int> = []
    }
    //属性
    private(set) var tasks: Array<Task> = []  //用于保存历史记录过的所有任务
    private(set) var taskTypes: Array<TaskType> = [] //用于保存所有任务类型
    private(set) var dailyTasks = DailyTasks()  //用于存储今天任务
    private(set) var today = "2023-02-23" //TODO: 修改为当天时间
    let yyyy_MM_dd = DateFormatter()
    //方法
    init() {
        yyyy_MM_dd.dateFormat = "yyyy-MM-dd"
        //TODO: 设置定时器用以每日更新
        
    }
    ///测试用初始化函数，预设了任务
    init(tasks: Array<Task>, taskTypes: Array<TaskType>) {
        yyyy_MM_dd.dateFormat = "yyyy-MM-dd"
        self.tasks=tasks
        self.taskTypes=taskTypes
    }
    //MARK: 添加任务类方法。顺序：*addTaskType->addTask->addDailyTask
    ///向tasks添加新任务，返回在tasks中的索引
    func addTask(title: String, comment: String, type: Int) -> Int {
        assert(type>=0 && type<taskTypes.count)
        let task=Task(title: title,
                      comment: comment,
                      date: yyyy_MM_dd.date(from: today) ?? Date(timeIntervalSinceNow: 0),
                      state: .notStarted,
                      type: type)
        tasks.append(task)
        //加入对应的TaskType.tasks中
        let taskId = tasks.count-1
        taskTypes[type].tasks.append(taskId)
        return taskId
    }
    ///向taskType添加新类型，返回在taskTypes中的索引
    func addTaskType(title: String, comment: String) -> Int {
        let taskType = TaskType(title: title, comment: comment, tasks: [], doneCount: 0, failedCount: 0)
        taskTypes.append(taskType)
        return taskTypes.count-1
    }
    ///向dailyTasks添加新任务，返回在dailyTasks中的索引
    func addDailyTask(taskId: Int) -> Int {
        assert(taskId>=0 && taskId<tasks.count)
        dailyTasks.tasks.append(taskId)
        return dailyTasks.tasks.count-1
    }
    ///在dailyTasks中删除已有任务,并删除tasks中的对应任务
    func delDailyTask(dailyTaskId: Int) {
        assert(dailyTaskId>=0 && dailyTaskId<dailyTasks.tasks.count)
        tasks.remove(at: dailyTasks.tasks[dailyTaskId])
        dailyTasks.tasks.remove(at: dailyTaskId)
    }
    //MARK: 更改任务状态类方法
    enum TaskProperty{
        case title, comment, date, state, type
    }
    enum TaskTypeProperty{
        case title, comment, tasks, doneCount, failedCount, successRate
    }
    func setTitle(dailyTaskId: Int, newTitle: String) {
        assert(dailyTaskId>=0 && dailyTaskId<dailyTasks.tasks.count)
        tasks[dailyTasks.tasks[dailyTaskId]].title = newTitle
    }
    func setComment(dailyTaskId: Int, newComment: String) {
        assert(dailyTaskId>=0 && dailyTaskId<dailyTasks.tasks.count)
        tasks[dailyTasks.tasks[dailyTaskId]].comment = newComment
    }
    func setState(dailyTaskId: Int) {
        assert(dailyTaskId>=0 && dailyTaskId<dailyTasks.tasks.count)
        if tasks[dailyTasks.tasks[dailyTaskId]].state == .toBeDone {
            tasks[dailyTasks.tasks[dailyTaskId]].state = .Done
            taskTypes[tasks[dailyTasks.tasks[dailyTaskId]].type].doneCount += 1
        }
        else if tasks[dailyTasks.tasks[dailyTaskId]].state == .Done {
            tasks[dailyTasks.tasks[dailyTaskId]].state = .toBeDone
            taskTypes[tasks[dailyTasks.tasks[dailyTaskId]].type].doneCount -= 1
        }
    }
    func setType(dailyTaskId: Int, type: Int) {
        assert(dailyTaskId>=0 && dailyTaskId<dailyTasks.tasks.count)
        assert(type>=0 && type<taskTypes.count)
        let taskId = dailyTasks.tasks[dailyTaskId]
        //在taskTypes中更新信息
        let oldTaskTypeId = tasks[taskId].type
//        let oldTaskTypeIdId = taskTypes[oldTaskTypeId].tasks.firstIndex(of: taskId)
        taskTypes[oldTaskTypeId].tasks.remove(at: taskId)
        taskTypes[type].tasks.append(taskId)
        tasks[taskId].type = type
    }
    //MARK: 每日更新任务类方法。顺序：updateState->clearDailyTasks
    
    //MARK: TODEL: 测试函数
    ///打印任务列表
    func printTasks(printInfos: [TaskProperty] = [.title, .comment, .date, .state, .type]) {
        for task in tasks {
            if printInfos.contains(.title) {
                print("title: \(task.title) ", terminator: "")
            }
            if printInfos.contains(.comment) {
                print("comment: \(task.comment) ", terminator: "")
            }
            if printInfos.contains(.date) {
                let dateStr: String = yyyy_MM_dd.string(from: task.date)
                print("date: \(dateStr) ", terminator: "")
            }
            if printInfos.contains(.state) {
                var stateStr: String
                switch task.state {
                case .notStarted: stateStr = "notStarted"
                case .toBeDone: stateStr = "toBeDone"
                case .Done: stateStr = "Done"
                case .Failed: stateStr = "Failed"
                }
                print("state: \(stateStr)", terminator: "")
            }
            print("")  //换行
        }
    }
    
    ///清空tasks
    func clearTasks() {
//        printTasks()
        tasks.removeAll()
        print("tasks cleared")
    }
    ///打印任务种类列表
    func printTaskTypes(printInfos: [TaskTypeProperty] = [.title, .comment, .tasks, .doneCount, .failedCount, .successRate]) {
        for taskType in taskTypes {
            if printInfos.contains(.title) {
                print("title: \(taskType.title) ", terminator: "")
            }
            if printInfos.contains(.comment) {
                print("comment: \(taskType.comment) ", terminator: "")
            }
            if printInfos.contains(.tasks) {
                var tasksStr: String = ""
                for taskId in taskType.tasks {
                    tasksStr += "\(tasks[taskId].title), "
                }
                print("tasks: [\(tasksStr)] ", terminator: "")
            }
            if printInfos.contains(.doneCount) {
                print("doneCount: \(taskType.doneCount) ", terminator: "")
            }
            if printInfos.contains(.failedCount) {
                print("failedCount: \(taskType.failedCount) ", terminator: "")
            }
            if printInfos.contains(.successRate) {
                print("successRate: \(taskType.successRate) ", terminator: "")
            }
            print("")  //换行
        }
    }
    ///打印今日任务列表
    func printDailyTasks() {
        var dailyTaskStr = "dailyTasks: ["
        for dailyTask in dailyTasks.tasks {
            dailyTaskStr += "\(tasks[dailyTask].title), "
        }
        print("\(dailyTaskStr)] ")
    }

    ///清空taskTypes
    func clearTaskTypes() {
//        printTaskTypes()
        taskTypes.removeAll()
        print("taskTypes cleared")
    }
    
}
