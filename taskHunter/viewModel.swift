//
//  viewModel.swift
//  taskHunter
//
//  Created by Taosong YU on 2023/3/2.
//

import SwiftUI

class ViewModel_TH: ObservableObject {
    @Published var model = Model_TH(ifTest: true)
    var taskNum: Int {
        get {
            return model.dailyTasks.tasks.count
        }
    }
//    var taskTypeNum: Int {
//        get {
//            return model.t
//        }
//    }
    //MARK: 提取model中要应用到视图中的信息
    struct TaskInfo {
        var title = ""
        var finished = false
        var enabled = false
        var img = ""
        
        var out = ""
    }
    func getTaskInfo(task_id: Int) -> TaskInfo {
        var taskInfo = TaskInfo()
        taskInfo.title = model.dailyTasks.tasks[task_id].title
        taskInfo.finished = model.dailyTasks.tasks[task_id].state == .Done
        taskInfo.enabled = taskInfo.finished || model.dailyTasks.tasks[task_id].state == .toBeDone
        taskInfo.img = model.dailyTasks.tasks[task_id].img
        
        taskInfo.out = model.dailyTasks.tasks[task_id].state.rawValue
        return taskInfo
    }
    
    struct TaskDetailInfo {
        var title = ""
        var type: String? = nil
        var comment = ""
        var startTime = "00:00"
        var endTime = "23:59"
        var state = ""
        var img = ""
        
        var out = ""
    }
    func getTaskDetailInfo(task_id: Int) -> TaskDetailInfo {
        var taskDetailInfo = TaskDetailInfo()
        taskDetailInfo.title = model.dailyTasks.tasks[task_id].title
        taskDetailInfo.type = model.dailyTasks.tasks[task_id].type
        let HH_mm = DateFormatter()
        HH_mm.dateFormat = "HH:mm"
        taskDetailInfo.startTime = HH_mm.string(from: model.dailyTasks.tasks[task_id].date+model.dailyTasks.tasks[task_id].startTime)
        taskDetailInfo.endTime = HH_mm.string(from: model.dailyTasks.tasks[task_id].date+model.dailyTasks.tasks[task_id].endTime)
        taskDetailInfo.state = model.dailyTasks.tasks[task_id].state.rawValue
        taskDetailInfo.img = model.dailyTasks.tasks[task_id].img
        
        let testDF = DateFormatter()
        testDF.dateFormat = "yyyy/MM/dd HH:mm:ss"
        taskDetailInfo.out = testDF.string(from: model.dailyTasks.tasks[task_id].date)
        return taskDetailInfo
    }
    
//    func addTask(title: String, comment: String, type_id: Int) -> Int {
//        return model.addTask(title: title, comment: comment, type_id: type_id)
//    }
}
