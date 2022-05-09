//
//  XWClockWidgetView.swift
//  XWidget
//
//  Created by teenloong on 2022/3/31.
//  Copyright © 2022 com.teenloong.com. All rights reserved.
//

import SwiftUI
import WidgetKit

extension XWClockWidgetConfiguration {
    static let analog_plain = XWClockWidgetConfiguration(style: .clock_analog_plain, theme: .clock_analog_plain)
}

struct XWClockWidgetView: XWWidgetView {
    typealias Configuration = XWClockWidgetConfiguration
    let configuration: Configuration
    let family: WidgetFamily
    @Environment(\.colorScheme) var colorScheme: ColorScheme

    var body: some View {
        switch configuration.style {
        case .clock_analog_plain:
            widgetStyle(XWAnalogPlainClockWidgetStyle())
        default:
            EmptyView()
        }
    }
}

#if DEBUG
struct XWClockWidgetView_Previews: PreviewProvider {
    static var previews: some View {
        let config = XWClockWidgetConfiguration.analog_plain
        XWClockWidgetView(configuration: config, family: .systemSmall)
            .previewContext(WidgetPreviewContext(family: .systemSmall))
        XWClockWidgetView(configuration: config, family: .systemMedium)
            .previewContext(WidgetPreviewContext(family: .systemMedium))
        XWClockWidgetView(configuration: config, family: .systemLarge)
            .previewContext(WidgetPreviewContext(family: .systemLarge))
    }
}
#endif

struct XWAnalogPlainClockWidgetStyle: XWWidgetViewStyle {
    typealias Configuration = XWClockWidgetConfiguration
    
    func makeBody(_ configuration: Configuration, family: WidgetFamily, colorScheme: ColorScheme) -> some View {
        GeometryReader { geometry in
            let length: CGFloat = min(geometry.size.width, geometry.size.height)
            ZStack {
                configuration.theme.background.makeView(family, colorScheme: colorScheme)
                ZStack {
                    ClockMarkView(12, origin: false) { index in
                        Rectangle().frame(width: 2, height: 5)
                    }
                    ClockMarkView(4, origin: true) { index in
                        let hours = [12,3,6,9]
                        Text("\(hours[index])")
                            .font(.system(size: 12, weight: .bold))
                    }
                    .padding()
                    ClockNeedleView(configuration.date, for: .minute) {
                        Rectangle()
                            .frame(width: length / 100, height: length * 0.3)
                    }
                    ClockNeedleView(configuration.date, for: .hour) {
                        Rectangle()
                            .frame(width: length / 80, height: length * 0.2)
                    }
                    Circle().frame(width: length / 50, height: length / 50)
                }
                .padding()
                .frame(width: length, height: length, alignment: .center)
            }
            .frame(width: geometry.size.width, height: geometry.size.height, alignment: .center)
        }
        .foregroundColor(configuration.theme.fontColor.color)
    }
}
