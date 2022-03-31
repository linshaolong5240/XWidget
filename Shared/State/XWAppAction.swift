//
//  XWAppAction.swift
//  XWidget
//
//  Created by teenloong on 2022/3/31.
//  Copyright © 2022 com.teenloong.com. All rights reserved.
//

import SwiftUI
import WidgetKit

enum XWAppAction {
    case initAction
    case error(XWAppError)
    
    //Widget
    case saveWidget(configuration: XWWidgetEntry, family: WidgetFamily)
    case updateWidget(configuration: XWWidgetEntry, family: WidgetFamily)
    case deleteWidget(configuration: XWWidgetEntry, family: WidgetFamily)
    case reloadWidget(kind: String? = nil)
    case setWidgetPostionImageDict(dict: [WidgetPosition : URL], colorScheme: ColorScheme)
    case setWidgetTransparentBackground(imageURL: URL, colorScheme: ColorScheme)
}
