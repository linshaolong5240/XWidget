//
//  XWCheckInWidgetView.swift
//  XWidget
//
//  Created by teenloong on 2022/5/17.
//  Copyright © 2022 com.teenloong.com. All rights reserved.
//

import SwiftUI
import WidgetKit

struct XWCheckInWidgetView: View {
    @Binding var entry: XWWidgetEntry
    let family: WidgetFamily
    let isEditing: Bool
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    
    var body: some View {
        VStack {
            Text(entry.checkInModel.title)
            Text("\(entry.checkInModel.currentNumber) / \(entry.checkInModel.targetNumber)")
                .onTapGesture {
                    entry.checkInModel.checkIn()
                }
                .disabled(!isEditing)
                .widgetURL(URL(string: "MyApp:///CheckIn?id=\(entry.id)&family=\(family.rawValue)")!)
        }
    }
}

#if DEBUG
struct XWCheckInWidgetViewDemo: View {
    @State private var widget: XWWidgetEntry = .checkin_plain
    var body: some View {
        XWAnyWidgeView(entry: $widget, family: .systemSmall)

    }
}

struct XWCheckInWidgetView_Previews: PreviewProvider {
    static var previews: some View {
        XWCheckInWidgetViewDemo()
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
#endif
