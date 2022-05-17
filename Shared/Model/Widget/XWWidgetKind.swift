//
//  XWWidgetKind.swift
//  XWidget
//
//  Created by teenloong on 2022/3/31.
//  Copyright © 2022 com.teenloong.com. All rights reserved.
//

import Foundation

enum XWWidgetKind: String, Codable {
    case guide
    case calendar
    case clock
    case checkin
    case countdonw_days
    case gif
    case photo
}

extension XWWidgetKind {
    var name: String {
        switch self {
        case .guide:
            return "Guide"
        case .calendar:
            return "Calendar"
        case .clock:
            return "Clock"
        case .checkin:
            return "Check In"
        case .countdonw_days:
            return "Countdown Days"
        case .gif:
            return "Gif"
        case .photo:
            return "Photo"
        }
    }
    
    var localizedName: String { NSLocalizedString(name, comment: "")}
}
