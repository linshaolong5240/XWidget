//
//  XWGifWidgetView.swift
//  XWidget
//
//  Created by teenloong on 2022/5/9.
//  Copyright © 2022 com.teenloong.com. All rights reserved.
//

import SwiftUI
import WidgetKit

struct XWGifWidgetView: XWWidgetView {
    typealias Configuration = XWGifWidgetConfiguration
    let configuration: Configuration
    let family: WidgetFamily
    @Environment(\.colorScheme) var colorScheme: ColorScheme

    var body: some View {
        switch configuration.style {
        case .gif:
            widgetStyle(XWGifWidgetStyle())
        default:
            EmptyView()
        }
    }
}

#if DEBUG
struct XWGifWidgetView_Previews: PreviewProvider {
    static var previews: some View {
        let entry: XWWidgetEntry = .clock_analog_plain
        XWAnyWidgeView(entry: entry, family: .systemSmall)
            .previewContext(WidgetPreviewContext(family: .systemSmall))
        XWAnyWidgeView(entry: entry, family: .systemMedium)
            .previewContext(WidgetPreviewContext(family: .systemMedium))
        XWAnyWidgeView(entry: entry, family: .systemLarge)
            .previewContext(WidgetPreviewContext(family: .systemLarge))
    }
}
#endif

struct XWGifWidgetStyle: XWWidgetViewStyle {
    typealias Configuration = XWGifWidgetConfiguration
    
    func makeBody(_ configuration: Configuration, family: WidgetFamily, colorScheme: ColorScheme) -> some View {
        ZStack {
            if !configuration.model.imagesURL.isEmpty {
                let index = Int(configuration.date.timeIntervalSince1970) % configuration.model.imagesURL.count
                if let image = configuration.model.imagesURL[index].image {
                    Image(crossImage: image)
                        .resizable()
                }
            } else {
                Image(family == .systemMedium ? "photo_widget_default_background_image2" : "photo_widget_default_background_image1")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            }
        }
    }
}
