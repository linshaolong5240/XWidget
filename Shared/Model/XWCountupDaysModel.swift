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
    
    func betweenDays(from date: Date) {
        let date = Calendar.current.startOfDay(for: <#T##Date#>)
    }
}
