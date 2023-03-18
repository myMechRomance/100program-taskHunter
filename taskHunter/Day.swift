////
////  DateModification.swift
////  taskHunter
////
////  Created by Taosong YU on 2023/3/11.
////

//import Foundation

//struct Day: Equatable, Hashable, Codable, Identifiable{
//    var id: UUID
//    var year: Int
//    var month: Int
//    var day: Int
//    var toDate: Date {  //输出一个Date类型表示该日期的零点时刻
//        get {
//            let calendar = Calendar.current
//            var components = DateComponents()
//            components.year = year
//            components.month = month
//            components.day = day
//            let retVal = calendar.date(from: components)
//            return retVal!
//        }
//    }
//
//    init(_ date: Date = Date()) {  //用Date类型初始化
//        id = UUID()
//        let calendar = Calendar.current
//        let components = calendar.dateComponents([.year, .month, .day], from: date)
//        year = components.year!
//        month = components.month!
//        day = components.day!
//    }
//        init() {
//            id = UUID()
//            year = 2023
//            month = 1
//            day = 1
//        }
//    init(year: Int, month: Int, day: Int) {  //用年月日分别初始化
//        id = UUID()
//        assert(year >= 2000 && year <= 2050)
//        self.year = year
//        assert(month >= 1 && month <= 12)
//        self.month = month
//        assert(day >= 1 && day <= 31)
//        self.day = day
//    }
////    // 定义比较运算符
////    static func < (lhs: Day, rhs: Day) -> Bool {
////        if lhs.year != rhs.year {
////            return lhs.year < rhs.year
////        } else if lhs.month != rhs.month {
////            return lhs.month < rhs.month
////        } else {
////            return lhs.day < rhs.day
////        }
////    }
////
////    // 定义拷贝方法
////    func copy() -> Day {
////        var retVal = Day()
////        retVal.year = year
////        retVal.month = month
////        retVal.day = day
////        return retVal
////    }
//    
//    //输出日期字符串
//    func toStr() -> String {
//        return "\(year)/\(month)/\(day)"
//    }
//    
//    输出特定格式的日期字符串
//    func getFormattedDate(_ format: String = "yyyy/MM/dd") -> String {
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = format
//        return dateFormatter.string(from: toDate)
//    }
//    
//    //    // 定义日期增减方法
//    //    func addingDays(_ days: Int) -> Day {
//    //        var date = self.copy()
//    //        date.day += days
//    //        while date.day > numberOfDaysInMonth() {
//    //            date.day -= numberOfDaysInMonth()
//    //            date.month += 1
//    //            if date.month > 12 {
//    //                date.month = 1
//    //                date.year += 1
//    //            }
//    //        }
//    //        return date
//    //    }
//    //
//    //    // 辅助方法，返回当前月份的天数
//    //    private func numberOfDaysInMonth() -> Int {
//    //        switch month {
//    //        case 2:
//    //            if isLeapYear() {
//    //                return 29
//    //            } else {
//    //                return 28
//    //            }
//    //        case 4, 6, 9, 11:
//    //            return 30
//    //        default:
//    //            return 31
//    //        }
//    //    }
//    //
//    //    // 辅助方法，判断当前年份是否为闰年
//    //    private func isLeapYear() -> Bool {
//    //        return (year % 4 == 0 && year % 100 != 0) || year % 400 == 0
//    //    }
//    //}
//    
//}
