//
//  XWCountdownDaysModel.swift
//  XWidget
//
//  Created by teenloong on 2022/5/10.
//  Copyright © 2022 com.teenloong.com. All rights reserved.
//

import Foundation

enum XWCountdownDaysRepeat: Codable {
    case year(month: Int, day: Int)
    case month(day: Int)
    case week(weekday: Int)
    case never(date: Date)
    
    var targetDate: Date {
        var targetCom =  Calendar.current.dateComponents([.year, .month, .day, .weekday], from: Date())
        let nowCom = Calendar.current.dateComponents([.year, .month, .day, .weekday], from: Date())

        switch self {
        case .year(let month, let day):
            targetCom.year = nowCom.year
            targetCom.month = month
            targetCom.day = day
            if nowCom.month! > targetCom.month! {
                targetCom.year = nowCom.year! + 1
            } else if nowCom.month! == targetCom.month! && nowCom.day! > targetCom.day! {
                targetCom.year = nowCom.year! + 1
            }
            return Calendar.current.date(from: targetCom)!
        case .month(let day):
            targetCom.year = nowCom.year
            targetCom.month = nowCom.month
            targetCom.day = day
            if nowCom.day! > targetCom.day! {
                if nowCom.month! < 12 {
                    targetCom.month = nowCom.month! + 1
                } else {
                    targetCom.year = nowCom.year! + 1
                    targetCom.month = 1
                }
            }
            return Calendar.current.date(from: targetCom)!
        case .week(let weekday):
            targetCom.year = nowCom.year
            targetCom.month = nowCom.month
            targetCom.day = nowCom.day
            
            if nowCom.weekday! < weekday {
                targetCom.day! += (weekday - nowCom.weekday!)
            }
            
            if nowCom.weekday! == weekday {
                targetCom.day! += 7
            }
            
            if nowCom.weekday! > weekday {
                targetCom.day! += 7 - (nowCom.weekday! - weekday)
            }
            return Calendar.current.date(from: targetCom)!
        case .never(let date):
            return date
        }
    }
}

struct XWCountdownDaysModel: Codable {
    var title: String
    var countRepeat: XWCountdownDaysRepeat
    var targetDate: Date
    var targetDateEnd: Date { Calendar.current.dateInterval(of: .day, for: targetDate)!.end }
    
    init(title: String, countRepeat: XWCountdownDaysRepeat) {
        self.title = title
        self.countRepeat = countRepeat
        self.targetDate = countRepeat.targetDate
    }
    
    mutating func checkAndSetRepeat(from date: Date) {
        if date > targetDateEnd {
            self.targetDate = countRepeat.targetDate
        }
    }
    
    func remainingDays(from date: Date) -> Int {
        let targetCom = Calendar.current.dateComponents([.year, .month, .day], from: targetDate)
        let nowCom = Calendar.current.dateComponents([.year, .month, .day], from: date)
        let days = Calendar.current.dateComponents([.day], from: nowCom, to: targetCom).day!
        return days >= 0 ? days : 0
    }
}

extension XWCountdownDaysModel {
    static let memorialDay = XWCountdownDaysModel(title: "Memorial Day", countRepeat: .year(month: 5, day: 20))
}
