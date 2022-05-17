//
//  XWWidgetUniversalView.swift
//  XWidget
//
//  Created by teenloong on 2022/3/31.
//  Copyright © 2022 com.teenloong.com. All rights reserved.
//

import SwiftUI
import WidgetKit

struct XWAnyWidgeView: View {
    @Binding var entry: XWWidgetEntry
    let family: WidgetFamily
    @Environment(\.colorScheme) var colorScheme: ColorScheme

    var body: some View {
        ZStack {
            entry.theme.background.makeView(family, colorScheme: colorScheme)
            switch entry.kind {
            case .guide:
                XWGuideWidgetView(configuration: .init(date: entry.date, style: entry.style, theme: entry.theme), family: family)
            case .calendar:
                XWCalendarWidgetView(configuration: .init(date: entry.date, style: entry.style, theme: entry.theme), family: family)
            case .clock:
                XWClockWidgetView(configuration: .init(date: entry.date, style: entry.style, theme: entry.theme), family: family)
            case .checkin:
                XWCheckInWidgetView(entry: $entry, family: family)
            case .countdonw_days:
                XWCountdownDaysView(configuration: .init(date: entry.date, style: entry.style, theme: entry.theme, model: entry.countdownDaysModel), family: family)
            case .gif:
                XWGifWidgetView(configuration: .init(date: entry.date, style: entry.style, theme: entry.theme, model: entry.gifModel), family: family)
            case .photo:
                XWPhotoWidgetView(configuration: .init(date: entry.date, style: entry.style, theme: entry.theme, model: entry.photoModel), family: family)
            }
            entry.theme.border?.makeView(family: family, cornerRadius: family.cornerRadius)
        }
    }
}

//#if DEBUG
//struct WidgetView_Previews: PreviewProvider {
//    static var previews: some View {
//        XWAnyWidgeView(entry: .guide, family: .systemSmall)
//            .previewContext(WidgetPreviewContext(family: .systemSmall))
//        XWAnyWidgeView(entry: .guide, family: .systemMedium)
//            .previewContext(WidgetPreviewContext(family: .systemMedium))
//        XWAnyWidgeView(entry: .guide, family: .systemLarge)
//            .previewContext(WidgetPreviewContext(family: .systemLarge))
//    }
//}
//#endif
