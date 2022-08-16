//
//  XWPhotoWidgetView.swift
//  XWidget
//
//  Created by teenloong on 2022/3/31.
//  Copyright © 2022 com.teenloong.com. All rights reserved.
//

import SwiftUI
import WidgetKit

struct XWPhotoWidgetView: XWWidgetView {
    typealias Configuration = XWPhotoWidgetConfiguration
    let configuration: Configuration
    let family: WidgetFamily
    @Environment(\.colorScheme) var colorScheme: ColorScheme

    var body: some View {
        widgetStyle(XWPlainPhotoWidgetStyle())
    }
}

#if DEBUG
struct XWPhotoWidgetView_Previews: PreviewProvider {
    static var previews: some View {
        let entry: XWWidgetEntry = .photo_plain
        XWAnyWidgeView(entry: .constant(entry), family: .systemSmall)
            .previewContext(WidgetPreviewContext(family: .systemSmall))
        XWAnyWidgeView(entry: .constant(entry), family: .systemMedium)
            .previewContext(WidgetPreviewContext(family: .systemMedium))
        XWAnyWidgeView(entry: .constant(entry), family: .systemLarge)
            .previewContext(WidgetPreviewContext(family: .systemLarge))
    }
}
#endif

struct XWPlainPhotoWidgetStyle: XWWidgetViewStyle {
    typealias Configuration = XWPhotoWidgetConfiguration

    func makeBody(_ configuration: Configuration, family: WidgetFamily, colorScheme: ColorScheme) -> some View {
        ZStack {
            if let path = configuration.model.photoImageURL?.path, let uiImage = CrossImage(contentsOfFile: path) {
                Image(crossImage: uiImage).resizable().aspectRatio(contentMode: .fill)
            } else {
                Image(family == .systemMedium ? "photo_widget_default_background_image2" : "photo_widget_default_background_image1")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            }
        }
    }
}
