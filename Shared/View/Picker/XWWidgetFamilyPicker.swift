//
//  XWWidgetFamilyPicker.swift
//  XWidget
//
//  Created by teenloong on 2022/3/31.
//  Copyright © 2022 com.teenloong.com. All rights reserved.
//

import SwiftUI
import WidgetKit

struct XWWidgetFamilyPicker: View {
    @Binding var selection: WidgetFamily
    
    var body: some View {
        HStack {
            Button {
                selection = .systemSmall
            } label: {
                Text("Small")
            }
            Button {
                selection = .systemMedium
            } label: {
                Text("Medium")
            }
            Button {
                selection = .systemLarge
            } label: {
                Text("Large")
            }
            Spacer()
        }
    }
}

#if DEBUG
struct XWWidgetFamilyPicker_Previews: PreviewProvider {
    static var previews: some View {
        XWWidgetFamilyPicker(selection: .constant(.systemSmall))
    }
}
#endif
