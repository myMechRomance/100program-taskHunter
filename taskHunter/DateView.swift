//
//  AutoClearTask.swift
//  taskHunter
//
//  Created by Taosong YU on 2023/3/9.
//

import SwiftUI
///每天第一次打开时自动清空tasks
struct DateView: View {
    @EnvironmentObject var userData: UserData
    @State var date = Day(date: Date())
    @State var test = ""
    
    var body: some View {
        Text(getFormattedDate("yyyy/MM/dd"))
    }
    
    init() {
        let calendar = Calendar.current
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd"
        if calendar.isDate(date.date, inSameDayAs: userData.lastOpenDate.date) {
            return
        }
        userData.tasks.removeAll()
        userData.lastOpenDate = date
    }

    private func getFormattedDate(_ format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: date.date)
    }
}
