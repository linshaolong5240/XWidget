//
//  XWCountdownDaysView.swift
//  XWidget
//
//  Created by teenloong on 2022/5/10.
//  Copyright © 2022 com.teenloong.com. All rights reserved.
//

import SwiftUI
import WidgetKit

extension XWCountDaysWidgetConfiguration {
    static let countdown_days_plain = XWCountDaysWidgetConfiguration(style: .countdown_days_plain, theme: .countdown_days_plain, model: .memorialDay)
}

struct XWCountdownDaysView: XWWidgetView {
    typealias Configuration = XWCountDaysWidgetConfiguration
    let configuration: Configuration
    let family: WidgetFamily
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    
    var body: some View {
        switch configuration.style {
        case .countdown_days_plain:
            widgetStyle(XWCountdownDaysPlainWidgetStyle())
        default:
            EmptyView()
        }
    }
}

#if DEBUG
struct XWCountdownDaysView_Previews: PreviewProvider {
    static var previews: some View {
        let config = XWCountDaysWidgetConfiguration.countdown_days_plain
        XWCountdownDaysView(configuration: config, family: .systemSmall)
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
#endif

struct XWCountdownDaysPlainWidgetStyle: XWWidgetViewStyle {
    typealias Configuration = XWCountDaysWidgetConfiguration
    
    func makeBody(_ configuration: Configuration, family: WidgetFamily, colorScheme: ColorScheme) -> some View {
        VStack {
            Text(configuration.model.title)
            Text("\(configuration.model.remainingDays(from: configuration.date)) days")
        }
        .foregroundColor(configuration.theme.fontColor.color)
    }
}
