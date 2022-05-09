//
//  XWWidgetKind.swift
//  XWidget
//
//  Created by teenloong on 2022/3/31.
//  Copyright © 2022 com.teenloong.com. All rights reserved.
//

import Foundation

enum XWWidgetKind: String, Codable {
    case guide = "Guide"
    case calendar = "Calendar"
    case clock = "Clock"
    case gif = "Gif"
    case photo = "Photo"
    
    var name: String { rawValue }
    var localizedName: String { NSLocalizedString(name, comment: "")}
}
