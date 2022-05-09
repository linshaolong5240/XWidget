//
//  XWWidgetIntent.swift
//  XWidget (iOS)
//
//  Created by qfdev on 2022/5/9.
//  Copyright © 2022 com.teenloong.com. All rights reserved.
//

import Foundation

protocol XWWidgetIntent {
    var currentWidget: XWWidgetType? { get }
    var transparentBackground: XWWidgetPositionType? { get }
}
extension XWSmallWidgetConfigurationIntent: XWWidgetIntent { }
extension XWMediumWidgetConfigurationIntent: XWWidgetIntent { }
extension XWLargeWidgetConfigurationIntent: XWWidgetIntent { }
