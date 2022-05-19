//
//  XWCountupDaysModel.swift
//  XWidget
//
//  Created by teenloong on 2022/5/23.
//  Copyright © 2022 com.teenloong.com. All rights reserved.
//

import Foundation

struct XWCountupDaysModel: Codable {
    var title: String
    var targetDate: Date
    
    init(title: String, targetDate: Date) {
        self.title = title
        self.targetDate = targetDate
    }
    
    func betweenDays(from date: Date) -> Int {
        Calendar.current.numberOfDaysBetween(targetDate, and: date)
    }
}

extension XWCountupDaysModel {
    static let memorialDay = XWCountupDaysModel(title: "Memorial Day", targetDate: Calendar.current.date(from: DateComponents(year: 2022, month: 5, day: 1)) ?? Date())
}
