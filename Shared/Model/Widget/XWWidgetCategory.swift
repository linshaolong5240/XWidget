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
    case calendar = "Calendar"
    case clock = "Clock"
    case countdown_days = "Countdown Days"
    case gif = "Gif"
    case photo = "Photo"
    
    var id: String { rawValue }
    var name: String { rawValue }
}

extension XWWidgetCategory {
    func getWidget(family: WidgetFamily) -> [XWWidgetEntry] {
        switch self {
        case .calendar:
            return .calendars
        case .clock:
            return .clocks
        case .countdown_days:
            return .countdownDays
        case .gif:
            return .gifs
        case .photo:
            return .photos
        }
    }
}
