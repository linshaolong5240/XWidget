//
//  XWWidgetHelper.swift
//  XWidget
//
//  Created by teenloong on 2022/3/31.
//  Copyright © 2022 com.teenloong.com. All rights reserved.
//

import SwiftUI
import WidgetKit

public struct WidgetPreviewModifier: ViewModifier {
    let family: WidgetFamily
    let scale: CGFloat
    
    init(family: WidgetFamily, scale: CGFloat = 1.0) {
        self.family = family
        self.scale = scale
    }

    public func body(content: Content) -> some View {
        content
            .frame(width: family.size.width, height: family.size.height)
            .cornerRadius(family.cornerRadius)
            .scaleEffect(scale)
            .frame(width: family.size.width * scale, height: family.size.height * scale)
            .shadow(radius: 10)
    }
}

public struct WidgetPreviewModifierDemoView: View {
    public var body: some View {
        ZStack {
            Color.orange
            Text("Hello World")
        }
        .modifier(WidgetPreviewModifier(family: .systemSmall))
        .navigationTitle("WidgetPreview")
#if canImport(UIKit)
        .navigationBarTitleDisplayMode(.inline)
#endif
    }
}

#if canImport(UIKit)
import UIKit

#if DEBUG
struct WidgetPreviewModifier_Previews: PreviewProvider {
    static var previews: some View {
        WidgetPreviewModifierDemoView()
    }
}
#endif

extension WidgetFamily {
    var widgetSmallSize: CGSize {
        switch UIScreen.screenType  {
        case .iPhone_428_926:   return CGSize(width: 170, height: 170)
        case .iPhone_414_896:   return CGSize(width: 169, height: 169)
        case .iPhone_414_736:   return CGSize(width: 157, height: 157)//CGSize(width: 159, height: 159)
        case .iPhone_390_844:   return CGSize(width: 158, height: 158)
        case .iPhone_375_812:   return CGSize(width: 155, height: 155)
        case .iPhone_375_667:   return CGSize(width: 148, height: 148)
        case .iPhone_360_780_375_812_mini:   return CGSize(width: 149, height: 149)//CGSize(width: 155, height: 155)
        case .iPhone_320_568:   return CGSize(width: 141, height: 141)
        case .unknown:          return .zero
        }
    }
    
    var widgetMediumSize: CGSize {
        switch UIScreen.screenType  {
        case .iPhone_428_926:   return CGSize(width: 364, height: 170)
        case .iPhone_414_896:   return CGSize(width: 360, height: 169)
        case .iPhone_414_736:   return CGSize(width: 348, height: 157)//CGSize(width: 348, height: 159)
        case .iPhone_390_844:   return CGSize(width: 338, height: 158)
        case .iPhone_375_812:   return CGSize(width: 329, height: 155)
        case .iPhone_375_667:   return CGSize(width: 321, height: 148)
        case .iPhone_360_780_375_812_mini:   return CGSize(width: 316, height: 149)//CGSize(width: 329, height: 155)
        case .iPhone_320_568:   return CGSize(width: 292, height: 141)
        case .unknown:          return .zero
        }
   }
    
    var widgetLargeSize: CGSize {
        switch UIScreen.screenType  {
        case .iPhone_428_926:   return CGSize(width: 364, height: 382)
        case .iPhone_414_896:   return CGSize(width: 360, height: 379)
        case .iPhone_414_736:   return CGSize(width: 348, height: 351)//CGSize(width: 348, height: 357)
        case .iPhone_390_844:   return CGSize(width: 338, height: 354)
        case .iPhone_375_812:   return CGSize(width: 329, height: 345)
        case .iPhone_375_667:   return CGSize(width: 321, height: 324)
        case .iPhone_360_780_375_812_mini:   return CGSize(width: 316, height: 331.2)//CGSize(width: 329, height: 345)
        case .iPhone_320_568:   return CGSize(width: 292, height: 311)
        case .unknown:          return .zero
        }
   }
    
    var size: CGSize {
        switch self {
        case .systemSmall: return widgetSmallSize
        case .systemMedium: return widgetMediumSize
        case .systemLarge: return widgetLargeSize
        case .systemExtraLarge: return .zero
        @unknown default: return .zero
        }
    }
    
    var miniSize: CGSize {
        switch self {
        case .systemSmall: return CGSize(width: 141, height: 141)
        case .systemMedium: return CGSize(width: 292, height: 141)
        case .systemLarge: return CGSize(width: 292, height: 311)
        case .systemExtraLarge: return .zero
        @unknown default: return .zero
        }
    }
    
    var thumbnailSize: CGSize {
        switch self {
        case .systemSmall:      return .init(width: 40, height: 40)
        case .systemMedium:     return .init(width: 40 * 2.1411, height: 40)
        case .systemLarge:      return .init(width: 40 * 0.9528, height: 40)
        case .systemExtraLarge: return .init(width: 40, height: 40)
        @unknown default:       return .init(width: 40, height: 40)
        }
    }
    
    var ratio: CGFloat { size.width / size.height }
    
    var cornerRadius: CGFloat { 20 }

    var padding: CGFloat {
        switch self {
        case .systemSmall:
            return 11
        case .systemMedium:
            return 16
        case .systemLarge:
            return 16
        case .systemExtraLarge:
            return 16
        @unknown default: return 11
        }
    }
    
}

#endif

