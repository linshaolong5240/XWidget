//
//  XWWidgetCategory.swift
//  XWidget
//
//  Created by teenloong on 2022/3/31.
//  Copyright © 2022 com.teenloong.com. All rights reserved.
//

import Foundation
import WidgetKit

enum XWWidgetCategory: String, CaseIterable, Identifiable {
    case calendar
    case clock
    case checkin
    case count_days
    case gif
    case photo
    
    var id: String { rawValue }
}

extension XWWidgetCategory {
    var name: String {
        switch self {
        case .calendar:
            return "Calendar"
        case .checkin:
            return "Check In"
        case .clock:
            return "Clock"
        case .count_days:
            return "Count Days"
        case .gif:
            return "Gif"
        case .photo:
            return "Photo"
        }
    }

    func getWidget(family: WidgetFamily) -> [XWWidgetEntry] {
        switch self {
        case .calendar:
            return .calendars
        case .checkin:
            return .checins
        case .clock:
            return .clocks
        case .count_days:
            return .countDays
        case .gif:
            return .gifs
        case .photo:
            return .photos
        }
    }
}
