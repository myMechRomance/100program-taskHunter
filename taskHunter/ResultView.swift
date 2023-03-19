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

struct ResultView: View {
//    @EnvironmentObject var popUpControl: PopUpControl
    @EnvironmentObject var userData: UserData
    
    var body: some View {
        ScrollView {
            Text("Hunting results")
                .font(.title)
                .bold()
            ForEach(userData.tasks) { task in
                ResultItemView(task: task)
                    .padding(10)
            }
        }
//        Text("This is PopUpView")
    }
}


