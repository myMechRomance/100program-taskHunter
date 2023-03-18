//
//  AutoClearTask.swift
//  taskHunter
//
//  Created by Taosong YU on 2023/3/9.
//

import SwiftUI

struct DateView: View {
    @EnvironmentObject var userData: UserData
    var dateStr: String {
        get {
//            let calendar = Calendar.current
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy/MM/dd"
            return dateFormatter.string(from: userData.today)
        }
    }
    
    var body: some View {
        HStack {
            Button(action: {previousDay()}) {
                Image(systemName: "arrowtriangle.left.fill")
                //                Text("previous")
            }
            Text(dateStr)
                .bold()
            Button(action: {nextDay()}) {
                Image(systemName: "arrowtriangle.right.fill")
                //                Text("next")
            }
        }
        .font(.title)
    }
    
    func previousDay() {
        userData.today = userData.today.addingTimeInterval(-24*60*60)
    }
    
    func nextDay() {
        userData.today = userData.today.addingTimeInterval(24*60*60)
    }
}
