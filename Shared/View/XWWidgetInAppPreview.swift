//
//  XWWidgetInAppPreview.swift
//  XWidget
//
//  Created by teenloong on 2022/5/17.
//  Copyright © 2022 com.teenloong.com. All rights reserved.
//

import SwiftUI
import WidgetKit

struct XWWidgetInAppPreview: View {
    let widget: XWWidgetEntry
    let family: WidgetFamily
    let showName: Bool
    let scale: CGFloat
    let isEditing: Bool
    
    init(widget: XWWidgetEntry, family: WidgetFamily, showName: Bool, scale: CGFloat = 1.0, isEditing: Bool = false) {
        self.widget = widget
        self.family = family
        self.showName = showName
        self.scale = scale
        self.isEditing = isEditing
    }
    
    var body: some View {
        VStack {
            XWAnyWidgeView(entry: .constant(widget), family: family)
                .modifier(WidgetPreviewModifier(family: family, scale: scale))
            if showName {
                Text(widget.kind.name)
            }
        }
    }
}

#if DEBUG
struct XWWidgetInAppPreview_Previews: PreviewProvider {
    static var previews: some View {
        let widget: XWWidgetEntry = .checkin_plain
        XWWidgetInAppPreview(widget: widget, family: .systemSmall, showName: true)
    }
}
#endif
