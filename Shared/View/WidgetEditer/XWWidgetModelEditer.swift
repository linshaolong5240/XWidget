//
//  XWWidgetModelEditer.swift
//  XWidget
//
//  Created by teenloong on 2022/5/9.
//  Copyright © 2022 com.teenloong.com. All rights reserved.
//

import SwiftUI
import WidgetKit

struct XWWidgetModelEditer: View {
    @Binding var widget: XWWidgetEntry
    let family: WidgetFamily

    var body: some View {
        switch widget.kind {
        case .countdonw_days:
            XWWidgetCountdownDaysModelEditer(countdownDaysModel: $widget.countdownDaysModel)
        case .gif:
            XWWidgetGifModelEditer(gifModel: $widget.gifModel, family: family)
        default: EmptyView()
        }
    }
}

#if DEBUG
struct XWWidgetFunctionEditerDemo: View {
    @State private var widget: XWWidgetEntry = .clock_analog_plain

    var body: some View {
        XWWidgetModelEditer(widget: $widget, family: .systemSmall)
    }
}
struct XWWidgetFunctionEditer_Previews: PreviewProvider {
    static var previews: some View {
        XWWidgetFunctionEditerDemo()
    }
}
#endif
