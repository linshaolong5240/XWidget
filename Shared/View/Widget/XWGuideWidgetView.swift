//
//  XWGuideWidgetView.swift
//  XWidget
//
//  Created by teenloong on 2022/3/31.
//  Copyright © 2022 com.teenloong.com. All rights reserved.
//

import SwiftUI
import WidgetKit

extension XWGuideWidgetConfiguration {
    static let `default` = XWGuideWidgetConfiguration(style: .guide, theme: .guide)
}

struct XWGuideWidgetView: XWWidgetView {
    typealias Configuration = XWGuideWidgetConfiguration
    let configuration: Configuration
    let family: WidgetFamily
    @Environment(\.colorScheme) var colorScheme: ColorScheme

    var body: some View {
        ZStack {
            VStack(alignment: .leading, spacing: 10) {
                let fontSize: CGFloat = getFontSize()
                Image("AppIcon60x60")
                    .cornerRadius(10)
                Group {
                    Text("DefaultWidget tip1")
                    Text("DefaultWidget tip2")
                    Text("DefaultWidget tip3")
                }
                .font(.system(size: fontSize, weight: .regular))
            }
            .padding(family.padding)
        }
        .foregroundColor(configuration.theme.fontColor.color)
    }
    
    func getFontSize() -> CGFloat {
        switch family {
        case .systemSmall:
            return 12
        case .systemMedium:
            return 14
        case .systemLarge:
            return 16
        case .systemExtraLarge:
            return 16
        @unknown default:
            return 16
        }
    }
}

struct GuideWidgetView_Previews: PreviewProvider {
    static var previews: some View {
        let config = XWGuideWidgetConfiguration.default
        XWGuideWidgetView(configuration: config, family: .systemSmall)
            .previewContext(WidgetPreviewContext(family: .systemSmall))
        XWGuideWidgetView(configuration: config, family: .systemMedium)
            .previewContext(WidgetPreviewContext(family: .systemMedium))
        XWGuideWidgetView(configuration: config, family: .systemLarge)
            .previewContext(WidgetPreviewContext(family: .systemLarge))
    }
}
