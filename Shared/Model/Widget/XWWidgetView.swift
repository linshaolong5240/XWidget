//
//  XWWidgetView.swift
//  XWidget
//
//  Created by teenloong on 2022/3/31.
//  Copyright © 2022 com.teenloong.com. All rights reserved.
//

import SwiftUI
import WidgetKit

protocol XWWidgetView: View {
    associatedtype Configuration: XWWidgetConfiguration
    var configuration: Configuration { get }
    var family: WidgetFamily { get }
    var colorScheme: ColorScheme { get }
}

extension XWWidgetView {
    func widgetStyle<S>(_ style: S) -> some View where S: XWWidgetViewStyle, Self.Configuration == S.Configuration {
        style.makeBody(configuration, family: family, colorScheme: colorScheme)
    }
}

protocol XWWidgetViewStyle {
    associatedtype Body: View
    associatedtype Configuration: XWWidgetConfiguration
    @ViewBuilder func makeBody(_ configuration: Self.Configuration, family: WidgetFamily, colorScheme: ColorScheme) -> Self.Body
}
