//
//  ContentView.swift
//  taskHunter
//
//  Created by Taosong YU on 2023/2/21.
//

import SwiftUI

struct View_TH: View {
    let viewModel: ViewModel_TH
    let model: Model_TH
    init(model: Model_TH) {
        self.viewModel = ViewModel_TH(model)
    }
    //TODO: 测试代码，删去
//    @State private var taskViews = [
//        TaskView(img: "child-大凶豺龙", title: "Great Jagras", type: "land"),
//        TaskView(img: "child-毒妖鸟", title: "Pukei-Pukei", type: "bird"),
//        TaskView(img: "child-飞雷龙", title: "Tobi Kadachi", type: "land"),
//    ]
//    @State private var taskDetailViews = [
//        TaskDetailView(img: "child-大凶豺龙", title: "Great Jagras", type: "land", comment: "It looks pregnated.", successRate: 25),
//        TaskDetailView(img: "child-毒妖鸟", title: "Pukei-Pukei", type: "bird", comment: "It has a good appetite.", successRate: 50),
//        TaskDetailView(img: "child-飞雷龙", title: "Tobi Kadachi", type: "land", comment: "Its fur can generate electricity by friction.", successRate: 76)
//    ]
    //    init(_viewModel: ViewModel_TH) {
    //        viewModel = _viewModel
    //        //TODO: 将view和viewModel相连
    //    }
    func getFormattedDate(_ format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: Date())
    }
    func void() {
        //TODO: 补全“添加任务”按钮按下后的动作
    }
    var body: some View {
        //main view
        NavigationView {
            List {
                ForEach(0..<model.tasks.count) { i in
                    NavigationLink (destination: TaskDetailView(task: model.tasks[i])) {
                        TaskView(task: model.tasks[i])
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
                    Button("➕", action: void)
                        .font(.title)
                        .bold()
                }
            }
        }
    }
}
///Task outline in the task list
struct TaskView: View {
    @State var img: String
    @State var title: String
    @State var type: String
    @State var ifDone = false
    var body: some View {
        HStack {
            Toggle("", isOn: $ifDone)
                .labelsHidden()
                .padding(.trailing, 10)
            Image(img)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 100)
            VStack {
                Text(title)
                    .font(.title)
                Text(type)
                    .font(.body)
            }
        }
    }
}
///Task details view
struct TaskDetailView: View {
    var task: Model_TH.Task
    ///处于不同区间的成功率以不同颜色显示
    var successRateColor: Color {
        get {
            switch(task01)
            {
            case 0..<25:
                return .red
            case 25..<50:
                return .yellow
            case 50..<75:
                return .orange
            case 75..<100:
                return .green
            default:
                return .white
            }
        }
    }
    //TODO: 增加
    var body: some View {
        VStack {
            Image(img)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 150, height: 150)
            VStack(alignment: .leading) {
                Text(title)
                    .font(.title)
                    .bold()
                Text("Type: \(type)")
                    .font(.body)
                Text("Comment: \(comment)")
                    .font(.body)
                Text("Success rate: \(successRate)%")  //保留整数
                    .font(.body)
                    .foregroundColor(successRateColor)
                Spacer()
            }
        }
    }
}
///Add details view
struct AddTaskView: View {
    @State var img: String
    @State var title: String
    @State var type: String
    @State var comment: String
    @State var stateStr: String
    var body: some View {
        VStack {
            TextField("", text: $title)
                .labelsHidden()
        }
    }
}















struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        View_TH()
    }
}
