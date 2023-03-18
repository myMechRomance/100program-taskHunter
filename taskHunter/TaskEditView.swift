//
//  TaskEditView.swift
//  taskHunter
//
//  Created by Taosong YU on 2023/3/7.
//

import SwiftUI

struct TaskEditView: View {
    @EnvironmentObject var userData: UserData
    @Binding var task: Task
//    private var draftTitle: String{
//        get {
//            return task.title
//        }
//        set {
//            task.title = newValue
//        }
//    }
    
    var body: some View {
        let inset1 = EdgeInsets(top: -8, leading: -10, bottom: -7, trailing: -10)
        let inset2 = EdgeInsets(top: 15 - inset1.top, leading: 20 - inset1.leading, bottom: 15 - inset1.bottom, trailing: 20 - inset1.trailing)
        VStack(alignment: .leading, spacing: 0) {
            //任务标题
            TextField("Title", text: $task.title)
            .background {
                RoundedRectangle(cornerRadius: 5)
                    .fill(Color.clear)
                    .background {
                        RoundedRectangle(cornerRadius: 5)
                            .strokeBorder(Color(red: 0.7, green: 0.7, blue: 0.7))
                            .padding(inset1)
                    }
            }
            .padding(inset2)
            SpeciesEditView(task: $task)
            Spacer()
        }
        .navigationTitle("Monster detail")
    }
    
//    init(task: Binding<Task>) {
//        self.task = task
//        draftTitle = .init(initialValue: task.title)  //默认保存原来的名字
//    }
//
//    private func updateTitle() {
//        guard let index = userData.tasks.firstIndex(of: task) else {
//            return
//        }
//        guard !self.draftTitle.wrappedValue.isEmpty else{
//            return
//        }
//        userData.tasks[index].title = draftTitle.wrappedValue
//    }
//    private func updateSpecies() {
//        guard let index = userData.tasks.firstIndex(of: task) else {
//            return
//        }
//        guard !self.draftTitle.wrappedValue.isEmpty else{
//            return
//        }
//        userData.tasks[index].title = draftTitle.wrappedValue
//    }
//
//
}



//struct TaskEditView_Previews: PreviewProvider {
//    static var previews: some View {
//        TaskEditView(task: Task(title: "Task test"))
//    }
//}
