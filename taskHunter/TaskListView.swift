//
//  ContentView.swift
//  taskHunter
//
//  Created by Taosong YU on 2023/2/21.
//
import SwiftUI


//enum mainView {
//    case TaskListView
//    case ResultView
//}

struct TaskListView: View {
    @EnvironmentObject var userData: UserData
//    @EnvironmentObject var popUpControl: PopUpControl
//    @State var ifPopUp = false
    @State var isEditing = false
    @State var draftTitle = ""
    
    var body: some View {
        VStack {
            NavigationView {
                List {
                    TextField("Add task", text: $draftTitle, onCommit: {
                        createTask(draftTitle)
                    })
                    .onSubmit {
                        draftTitle = ""
                    }
                    ForEach(userData.tasks.indices, id: \.self) { taskId in
                        TaskItemView(task: $userData.tasks[taskId], isEditing: $isEditing)
                    }
                }
                .navigationBarItems(leading: DateView(),
                                    trailing: Button(action: {
                    isEditing.toggle()
                }, label: {
                    if self.isEditing {
                        Text("Done").bold()
                    } else {
                        Text("Edit").bold()
                    }
                }))
            }
        }
        .sheet(isPresented: $userData.ifPopUp, onDismiss: {
            userData.tasks.removeAll()
            let calendar = Calendar.current
            let _today = calendar.startOfDay(for: Date())
            userData.today = _today
        }) {  //弹出结算窗口
            PopUpView()
        }
    }

    private func createTask(_ draftTitle: String) {
        guard draftTitle != "" else {return}
        userData.tasks.append(Task(title: draftTitle))
    }
}

//struct TaskListView: View {
//    @EnvironmentObject var userData: UserData
//
//    var body: some View {
//        DateView()
//    }
//}

/////Task outline in the task list
//struct TaskView: View {
//    @State private var info: ViewModel_TH.TaskInfo
//    init(_ info: ViewModel_TH.TaskInfo) {
//        self.info = info
//    }
//    var body: some View {
//        HStack {
//            Toggle("", isOn: $info.finished)
//                .allowsHitTesting(info.enabled)
//                .labelsHidden()
//                .padding(.trailing, 10)
//            Image(info.img)
//                .resizable()
//                .aspectRatio(contentMode: .fill)
//                .frame(width: 100)
//            VStack {
//                Text(info.title)
//                    .font(.title)
//                //TODO: test
//                Text(info.out)
//            }
//        }
//    }
//}
/////Task details view
//struct TaskDetailView: View {
//    @State private var info: ViewModel_TH.TaskDetailInfo
//    init(_ info: ViewModel_TH.TaskDetailInfo) {
//        self.info = info
//    }
////    ///处于不同区间的成功率以不同颜色显示
////    var successRateColor: Color {
////        get {
////            switch(task01)
////            {
////            case 0..<25:
////                return .red
////            case 25..<50:
////                return .yellow
////            case 50..<75:
////                return .orange
////            case 75..<100:
////                return .green
////            default:
////                return .white
////            }
////        }
////    }
//    var body: some View {
//        VStack {
//            Image(info.img)
//                .resizable()
//                .aspectRatio(contentMode: .fill)
//                .frame(width: 150, height: 150)
//            VStack(alignment: .leading) {
//                Text(info.title)
//                    .font(.title)
//                    .bold()
//                Text("Type: \(info.type ?? "undefined")")
//                    .font(.body)
//                Text("Comment: \(info.comment)")
//                    .font(.body   )
//                Text("Start time: \(info.startTime)")
//                    .font(.body)
//                Text("End time: \(info.endTime)")
//                    .font(.body)
//                Text("State: \(info.state)")
//                    .font(.body)
////                Text("Success rate: \(successRate)%")  //保留整数
////                    .font(.body)
////                    .foregroundColor(successRateColor)
//                Spacer()
//                //TODO: test
//                Text(info.out)
//            }
//        }
//    }
//}
///////Add details view
////struct AddTaskView: View {
////
////    var body: some View {
////        VStack {
////            TextField("", text: $title)
////                .labelsHidden()
////        }
////    }
////}


















// //测试
//struct TaskListView: View {
//    @State private var text = ""
//
//    var body: some View {
//        TextField("Input", text: $text)
//            .textFieldStyle(.roundedBorder)
//            .onSubmit {
//                // 清空输入
//                self.text = ""
//            }
//    }
//}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        //初始注入一个UserData
        TaskListView().environmentObject(UserData())
    }
}
