//
//  XWWidgetThemeEditer.swift
//  XWidget
//
//  Created by teenloong on 2022/5/9.
//  Copyright © 2022 com.teenloong.com. All rights reserved.
//

import SwiftUI
import WidgetKit

struct XWWidgetThemeEditer: View {
    @Binding var theme: XWWidgetTheme
    let family: WidgetFamily
    
    var body: some View {
        VStack {
            XWWidgetFontColorPicker(selection: $theme.fontColor)
//                .onChange(of: viewModel.fontColor) { newValue in
//                    viewModel.setFontColor(color: newValue)
//                }
            XWWidgetBackgroundPicker(selection: $theme.background, data: .editItems, family: family)
//                .onChange(of: viewModel.background) { newValue in
//                    viewModel.set(background: newValue)
//                }
            XWWidgetBorderPicker(selection: $theme.border)
//                .onChange(of: viewModel.border) { newValue in
//                    viewModel.set(border: newValue)
//                }
        }
    }
}

#if DEBUG
struct XWWidgetThemeEditerDemo: View {
    @State private var theme: XWWidgetTheme = .guide
    var body: some View {
        XWWidgetThemeEditer(theme: $theme, family: .systemSmall)
    }
}

struct XWWidgetThemeEditer_Previews: PreviewProvider {
    static var previews: some View {
        XWWidgetThemeEditerDemo()
    }
}
#endif
