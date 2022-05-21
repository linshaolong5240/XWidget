//
//  XWWidgetManager.swift
//  XWidget
//
//  Created by teenloong on 2022/5/10.
//  Copyright © 2022 com.teenloong.com. All rights reserved.
//

import Foundation
import WidgetKit

struct XWWidgetManager {
    @CombineUserStorge(key: .widgetTransparentConfiguration, container: .group)
    var transparentConfiguration: XWWidgetTransparentConfiguration = XWWidgetTransparentConfiguration()

    @CombineUserStorge(key: .smallWidgetConfiguration, container: .group)
    var smallWidgetConfiguration: [XWWidgetEntry] = []

    @CombineUserStorge(key: .mediumWidgetConfiguration, container: .group)
    var mediumWidgetConfiguration: [XWWidgetEntry] = []

    @CombineUserStorge(key: .largeWidgetConfiguration, container: .group)
    var largeWidgetConfiguration: [XWWidgetEntry] = []
    
    func updateWidget(id: String, family: WidgetFamily) {
        
    }
}
