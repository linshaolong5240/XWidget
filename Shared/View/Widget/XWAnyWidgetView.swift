//
//  XWWidgetUniversalView.swift
//  XWidget
//
//  Created by teenloong on 2022/3/31.
//  Copyright © 2022 com.teenloong.com. All rights reserved.
//

import SwiftUI
import WidgetKit

struct XWWidgetEntryParseView: View {
    let entry: XWWidgetEntry
    let family: WidgetFamily
    @Environment(\.colorScheme) var colorScheme: ColorScheme

    var body: some View {
        ZStack {
            entry.theme.background.makeView(family, colorScheme: colorScheme)
            switch entry.kind {
            case .guide:
                XWGuideWidgetView(configuration: entry.asGuideWidgetConfiguraiton(), family: family)
            case .calendar:
                XWCalendarWidgetView(configuration: entry.asCalendarWidgetConfiguraiton(), family: family)
            case .clock:
                XWClockWidgetView(configuration: entry.asClockWidgetConfiguraiton(), family: family)
            case .photo:
                XWPhotoWidgetView(configuration: entry.asPhotoWidgetConfiguration(), family: family)
            }
            entry.theme.boarder?.makeView(family: family)
        }
    }
}

struct WidgetView_Previews: PreviewProvider {
    static var previews: some View {
        XWWidgetEntryParseView(entry: .guide, family: .systemSmall)
            .previewContext(WidgetPreviewContext(family: .systemSmall))
        XWWidgetEntryParseView(entry: .guide, family: .systemMedium)
            .previewContext(WidgetPreviewContext(family: .systemMedium))
        XWWidgetEntryParseView(entry: .guide, family: .systemLarge)
            .previewContext(WidgetPreviewContext(family: .systemLarge))
    }
}
