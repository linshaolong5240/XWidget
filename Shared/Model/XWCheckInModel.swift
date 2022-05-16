//
//  XWCheckInModel.swift
//  XWidget (iOS)
//
//  Created by tenloong on 2022/5/16.
//  Copyright © 2022 com.teenloong.com. All rights reserved.
//

import Foundation

enum XWCheckInRepeat: Codable, Equatable {
    case day
    case week(firstWeek: Int)
    case month
    
    func dateInterval(from date: Date) -> DateInterval {
        var calendar = Calendar.current
        switch self {
        case .day:
            return Calendar.current.dateInterval(of: .day, for: date)!
        case .week(let firstWeek):
            calendar.firstWeekday = firstWeek
            return Calendar.current.dateInterval(of: .weekOfMonth, for: date)!
        case .month:
            return Calendar.current.dateInterval(of: .month, for: date)!
        }
    }
}

struct XWCheckInModel {
    var createDate: Date = Date()
    var dateInterval: DateInterval
    
    var title: String
    var currentNumber: Int
    var targetNumber: Int
    var checkInRepeat: XWCheckInRepeat
    var kind: String
    
    var isCheckInValid: Bool { dateInterval.contains(Date()) }
    var isComplete: Bool { currentNumber == targetNumber }

    init(createDate: Date, tilte: String, currentNumber: Int, targetNumber: Int, checkInRepeat: XWCheckInRepeat, kind: String) {
        self.createDate = createDate
        self.dateInterval = checkInRepeat.dateInterval(from: createDate)
        self.title = tilte
        self.currentNumber = currentNumber
        self.targetNumber = targetNumber
        self.checkInRepeat = checkInRepeat
        self.kind = kind
    }
    
    mutating func resetCheckIn() {
        createDate = Date()
        currentNumber = 0
    }
    
    mutating func checkIn() {
        guard isCheckInValid else {
            resetCheckIn()
            currentNumber += 1
            return
        }
        
        guard currentNumber < targetNumber else {
            return
        }
        
        currentNumber += 1
    }
    
}
