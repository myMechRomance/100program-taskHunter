//
//  TaskItemView.swift
//  taskHunter
//
//  Created by Taosong YU on 2023/3/7.
//

import SwiftUI
///单条任务显示
struct TaskItemView: View {
    @EnvironmentObject var userData: UserData
    @Binding var task: Task
    @Binding var isEditing: Bool
    
    var body: some View {
        if isEditing {  //编辑中，显示删除按钮
            HStack {
                Image(systemName: "minus.circle")
                    .foregroundColor(.red)
                    .onTapGesture(count: 1) {
                    deleteTask()
                }
                NavigationLink(destination: TaskEditView(task: $task), label: {TaskInfoView(task: task)})
                Image(systemName: "chevron.right")
                    .foregroundColor(.gray)
            }
            .padding(10)
        } else {  //未编辑，显示标题; 点击切换完成状态
            ZStack{
                HStack {
                    Button(action: {task.ifDone.toggle()}, label: {TaskInfoView(task: task)})
                    Spacer()
                }
                HStack {
                    Spacer()
                    if task.ifDone {
                        Image(systemName: "checkmark")
                            .foregroundColor(.green)
                            .padding(10)
                    }
                }
            }
        }
    }
    
//    private func toggleDone() {
//        guard isEditing == false else {
//            return
//        }
//        guard let index = userData.tasks.firstIndex(where: {$0.id == task.id}) else {  //在tasks中检索task的id
//            return
//        }
//        userData.tasks[index].ifDone.toggle()
//    }
    
    private func deleteTask() {
        userData.tasks.removeAll { (task) -> Bool in
            task.id == self.task.id
        }
        userData.tasks = userData.tasks.compactMap {$0}
    }
    
}
//
//struct TaskItemView_Previews: PreviewProvider {
//    static var previews: some View {
//        TaskItemView(task: Task(title: "None"), isEditing: isEditing)
//    }
//}
