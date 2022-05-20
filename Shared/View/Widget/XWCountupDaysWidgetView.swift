//
//  XWCountupDaysWidgetView.swift
//  XWidget
//
//  Created by teenloong on 2022/5/19.
//  Copyright © 2022 com.teenloong.com. All rights reserved.
//

import SwiftUI
import WidgetKit

extension XWCountupDaysWidgetConfiguration {
    static let countup_days_plain = XWCountupDaysWidgetConfiguration(style: .countup_days_plain, theme: .countup_days_plain, model: .memorialDay)
}

struct XWCountupDaysWidgetView: XWWidgetView {
    typealias Configuration = XWCountupDaysWidgetConfiguration
    let configuration: Configuration
    let family: WidgetFamily
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    
    var body: some View {
        switch configuration.style {
        case .countup_days_plain:
            widgetStyle(XWCountupDaysPlainWidgetStyle())
        default:
            EmptyView()
        }
    }
}

#if DEBUG
struct XWCountupDaysWidgetView_Previews: PreviewProvider {
    static var previews: some View {
        let config: XWCountupDaysWidgetConfiguration = .countup_days_plain
        XWCountupDaysWidgetView(configuration: config, family: .systemSmall)
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
#endif

struct XWCountupDaysPlainWidgetStyle: XWWidgetViewStyle {
    typealias Configuration = XWCountupDaysWidgetConfiguration
    
    func makeBody(_ configuration: Configuration, family: WidgetFamily, colorScheme: ColorScheme) -> some View {
        VStack {
            Text(configuration.model.title)
            Text("\(configuration.model.betweenDays(from: configuration.date)) days")
            Text("target date: \(configuration.model.targetDate)")
        }
        .padding()
    }
}
