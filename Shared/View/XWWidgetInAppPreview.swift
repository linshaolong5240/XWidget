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
    let scale: CGFloat
    let isEditing: Bool
    
    init(widget: XWWidgetEntry, family: WidgetFamily, scale: CGFloat = 1.0, isEditing: Bool = false) {
        self.widget = widget
        self.family = family
        self.scale = scale
        self.isEditing = isEditing
    }
    
    var body: some View {
        XWAnyWidgeView(entry: .constant(widget), family: family)
            .modifier(WidgetPreviewModifier(family: family, scale: scale))
    }
}

#if DEBUG
struct XWWidgetInAppPreview_Previews: PreviewProvider {
    static var previews: some View {
        let widget: XWWidgetEntry = .checkin_plain
        XWWidgetInAppPreview(widget: widget, family: .systemSmall)
    }
}
#endif