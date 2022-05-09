//
//  XWAppState.swift
//  XWidget
//
//  Created by teenloong on 2022/3/31.
//  Copyright © 2022 com.teenloong.com. All rights reserved.
//

import Foundation

struct XWAppState {
    var error: XWAppError?
    var settings = Settings()
    var widget = Widget()
}

extension XWAppState {
    struct InitStatus {
        @CombineUserStorge(key: .isInit, container: .group)
        var isInit: Bool = false
    }
    struct Settings {
        #if false
        var isFirstLaunch: Bool { get { true } set { }}
        #else
        @CombineUserStorge(key: .isFirstLaunch, container: .group)
        var isFirstLaunch: Bool = true
        #endif
    }
    
    struct Widget {
        @CombineUserStorge(key: .widgetTransparentConfiguration, container: .group)
        var widgetTransparentConfiguration: XWWidgetTransparentConfiguration = XWWidgetTransparentConfiguration()

        @CombineUserStorge(key: .smallWidgetConfiguration, container: .group)
        var smallWidgetConfiguration: [XWWidgetEntry] = []

        @CombineUserStorge(key: .mediumWidgetConfiguration, container: .group)
        var mediumWidgetConfiguration: [XWWidgetEntry] = []

        @CombineUserStorge(key: .largeWidgetConfiguration, container: .group)
        var largeWidgetConfiguration: [XWWidgetEntry] = []
    }
}
