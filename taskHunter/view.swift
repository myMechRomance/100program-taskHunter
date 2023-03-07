//
//  ContentView.swift
//  taskHunter
//
//  Created by Taosong YU on 2023/2/21.
//
let defaultImg = "undefined-lv0"

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel = ViewModel_TH()
    func getFormattedDate(_ format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: Date())
    }
    @State var title = ""
    @State var comment = ""
    @State var type_id = -1
    @State var typeName: String?
    @State var ifCreateNewTask = false
    
    var body: some View {
        //main view
        VStack {
            NavigationView {
                List {
                    ForEach(0..<viewModel.taskNum) { task_id in
                        NavigationLink (destination: TaskDetailView(viewModel.getTaskDetailInfo(task_id: task_id))) {
                            TaskView(viewModel.getTaskInfo(task_id: task_id))
                        }
                    }
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Text(getFormattedDate("MM/dd"))  //TODO: 改成当前日期
                            .font(.title)
                            .bold()
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button("➕") {
                            ifCreateNewTask = true
                        }
                            .font(.title)
                            .bold()
                    }
                }
                .sheet(isPresented: $ifCreateNewTask) {
                    //添加新任务弹窗
                    TextField("Title", text: $title).font(.title)
                    TextField("Comment", text: $comment).font(.title)
                    Picker("Type", selection: $type_id) {
                        ForEach(0..<5) {type_id in
                            Text(String(type_id)).tag(type_id)
                        }
                    }
                    Spacer()
                    Button("OK") {
                        if title != "" {
                            if typeName != nil {
                                //TODO: 增加新种类
                            }
                            viewModel.model.addTask(title: title, comment: comment, type_id: type_id)
                            ifCreateNewTask = false
                        }
                    }
                }
            }
        }
    }
}
///Task outline in the task list
struct TaskView: View {
    @State private var info: ViewModel_TH.TaskInfo
    init(_ info: ViewModel_TH.TaskInfo) {
        self.info = info
    }
    var body: some View {
        HStack {
            Toggle("", isOn: $info.finished)
                .allowsHitTesting(info.enabled)
                .labelsHidden()
                .padding(.trailing, 10)
            Image(info.img)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 100)
            VStack {
                Text(info.title)
                    .font(.title)
                //TODO: test
                Text(info.out)
            }
        }
    }
}
///Task details view
struct TaskDetailView: View {
    @State private var info: ViewModel_TH.TaskDetailInfo
    init(_ info: ViewModel_TH.TaskDetailInfo) {
        self.info = info
    }
//    ///处于不同区间的成功率以不同颜色显示
//    var successRateColor: Color {
//        get {
//            switch(task01)
//            {
//            case 0..<25:
//                return .red
//            case 25..<50:
//                return .yellow
//            case 50..<75:
//                return .orange
//            case 75..<100:
//                return .green
//            default:
//                return .white
//            }
//        }
//    }
    var body: some View {
        VStack {
            Image(info.img)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 150, height: 150)
            VStack(alignment: .leading) {
                Text(info.title)
                    .font(.title)
                    .bold()
                Text("Type: \(info.type ?? "undefined")")
                    .font(.body)
                Text("Comment: \(info.comment)")
                    .font(.body   )
                Text("Start time: \(info.startTime)")
                    .font(.body)
                Text("End time: \(info.endTime)")
                    .font(.body)
                Text("State: \(info.state)")
                    .font(.body)
//                Text("Success rate: \(successRate)%")  //保留整数
//                    .font(.body)
//                    .foregroundColor(successRateColor)
                Spacer()
                //TODO: test
                Text(info.out)
            }
        }
    }
}
/////Add details view
//struct AddTaskView: View {
//
//    var body: some View {
//        VStack {
//            TextField("", text: $title)
//                .labelsHidden()
//        }
//    }
//}















struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
