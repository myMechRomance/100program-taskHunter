//
//  taskHunterTests.swift
//  taskHunterTests
//
//  Created by Taosong YU on 2023/2/21.
//

import XCTest
@testable import taskHunter  //使单元测试可以访问taskHunter中的内部类型和函数

final class taskHunterTests: XCTestCase {
    var sut = Model_TH()
    var fruitId: Int = -1
    var meatId: Int = -1
    var appleId: Int = -1
    var bananaId: Int = -1
    var beefId: Int = -1
    var apple2Id: Int = -1
    var appleDailyId: Int = -1
    var bananaDailyId: Int = -1
    var apple2DailyId: Int = -1
    var beefDailyId: Int = -1
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        sut.clearTasks()
        sut.clearTaskTypes()
        //添加若干种类
        fruitId = sut.addTaskType(title: "fruit", comment: "Fruit is expensive in Japan")
        assert(fruitId == 0)
        meatId = sut.addTaskType(title: "meat", comment: "I can't understand vegetarians")
        assert(meatId == 1)
        //添加若干任务
        appleId = sut.addTask(title: "apple", comment: "An apple a day makes doctor away.", type: fruitId)
        assert(appleId == 0)
        bananaId = sut.addTask(title: "banana", comment: "Yoshiko loves banana", type: fruitId)
        assert(bananaId == 1)
        beefId = sut.addTask(title: "beef", comment: "Kobe's name is from Kobe beef.", type: meatId)
        assert(beefId == 2)
        apple2Id = sut.addTask(title: "apple", comment: "An apple a day makes doctor away.", type: meatId)
        assert(apple2Id == 3)
        //添加今日任务
        appleDailyId = sut.addDailyTask(taskId: appleId)
        bananaDailyId = sut.addDailyTask(taskId: bananaId)
        apple2DailyId = sut.addDailyTask(taskId: apple2Id)
        beefDailyId = sut.addDailyTask(taskId: beefId)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    ///测试向tasks添加新任务
    ///
    func test_printTasks() {
        sut.printTasks()
    }
    
    func test_printTaskTypes() {
        print("--------------test_printTaskTypes--------------")
        sut.printTaskTypes()
    }

    func test_printDailyTasks() {
        print("--------------test_printDailyTasks--------------")
        sut.printDailyTasks()
    }
    
    func test_taskSetters() {
        print("--------------test_taskSetters--------------")
        sut.setTitle(dailyTaskId: apple2DailyId, newTitle: "apple 2")
        sut.setComment(dailyTaskId: apple2DailyId, newComment: "Another apple a day makes doctor die.")
        sut.setState(dailyTaskId: apple2DailyId)  //由于仍处于notStarted状态，该语句无效果
        sut.setType(dailyTaskId: apple2DailyId, type: fruitId)
        sut.printTasks()
        sut.printTaskTypes()
    }
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
