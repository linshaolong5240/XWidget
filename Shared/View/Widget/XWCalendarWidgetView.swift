//
//  XWCalendarWidgetView.swift
//  XWidget
//
//  Created by teenloong on 2022/3/31.
//  Copyright © 2022 com.teenloong.com. All rights reserved.
//

import SwiftUI
import WidgetKit

extension XWCalendarWidgetConfiguration {
    static let calendar_plain = XWCalendarWidgetConfiguration(style: .calendar_plain, theme: .calendar_plain)
}

struct XWCalendarWidgetView: XWWidgetView {
    typealias Configuration = XWCalendarWidgetConfiguration
    let configuration: Configuration
    let family: WidgetFamily
    @Environment(\.colorScheme) var colorScheme: ColorScheme

    var body: some View {
        switch configuration.style {
        case .calendar_plain:
            widgetStyle(XWCalendarPlainWidgetStyle())
        default:
            EmptyView()
        }
    }
}

#if DEBUG
struct XWCalendarWidgetView_Previews: PreviewProvider {
    static var previews: some View {
        let config = XWCalendarWidgetConfiguration.calendar_plain
        XWCalendarWidgetView(configuration: config, family: .systemSmall)
            .previewContext(WidgetPreviewContext(family: .systemSmall))
        XWCalendarWidgetView(configuration: config, family: .systemMedium)
            .previewContext(WidgetPreviewContext(family: .systemMedium))
        XWCalendarWidgetView(configuration: config, family: .systemLarge)
            .previewContext(WidgetPreviewContext(family: .systemLarge))
    }
}
#endif

struct XWCalendarPlainWidgetStyle: XWWidgetViewStyle {
    typealias Configuration = XWCalendarWidgetConfiguration
    
    func makeBody(_ configuration: Configuration, family: WidgetFamily, colorScheme: ColorScheme) -> some View {
        ZStack {
            configuration.theme.background.makeView(family, colorScheme: colorScheme)
            CalendarMonthView(month: configuration.date, hSpacing: 4, vSpacing: 10) { date in
                ZStack {
                    if Calendar.current.isDateInToday(date) {
                        Circle()
                            .foregroundColor(configuration.theme.fontColor.color.opacity(0.3))
                    }
                    Text(String(Calendar.current.component(.day, from: date)))
                        .minimumScaleFactor(0.1)
                        .padding(4)
                }
                .frame(minWidth: 15, idealWidth: 40, maxWidth: .infinity, minHeight: 15, idealHeight: 40, maxHeight: .infinity)
            }
            .padding()
        }
        .foregroundColor(configuration.theme.fontColor.color)
    }
}
