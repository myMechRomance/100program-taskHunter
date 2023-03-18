//
//  PopUpControl.swift
//  taskHunter
//
//  Created by Taosong YU on 2023/3/16.
//

import SwiftUI

//class PopUpControl: ObservableObject {
//    @Published var isPresented: Bool? = false
//}

struct PopUpView: View {
//    @EnvironmentObject var popUpControl: PopUpControl
    @EnvironmentObject var userData: UserData
    
    var body: some View {
        ScrollView {
            List {
                ForEach(userData.tasks) { task in
                    ResultItemView(task: task)
                }
            }
        }
//        Text("This is PopUpView")
    }
}


