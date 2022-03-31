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

    public func body(content: Content) -> some View {
        content
            .frame(width: family.size.width, height: family.size.height)
            .cornerRadius(family.cornerRadius)
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

enum WidgetPosition: Int, Identifiable, Codable, CaseIterable {
    case smallTopLeft
    case smallTopRight
    case smallMiddleLeft
    case smallMiddleRight
    case smallBottomLeft
    case smallBottomRight
    case mediumTop
    case mediumMiddle
    case mediumBottom
    case largeTop
    case largeBottom
    
    var id: Int { self.rawValue }
    
    func imageSaveName(colorScheme: ColorScheme) -> String {
        "widget_position_image_\(id)_\(colorScheme == .light ? "light" : "dark")"
    }
    
    var family: WidgetFamily {
        switch self {
        case .smallTopLeft, .smallTopRight, .smallMiddleLeft, .smallMiddleRight, .smallBottomLeft, .smallBottomRight:
            return .systemSmall
        case .mediumTop, .mediumMiddle, .mediumBottom:
            return .systemMedium
        case .largeTop, .largeBottom:
            return .systemLarge
        }
    }
    
    var name: String {
        switch self {
        case .smallTopLeft:
            return "Top Left"
        case .smallTopRight:
            return "Top Right"
        case .smallMiddleLeft:
            return "Middle Left"
        case .smallMiddleRight:
            return "Middle Right"
        case .smallBottomLeft:
            return "Bottom Left"
        case .smallBottomRight:
            return "Bottom Right"
        case .mediumTop:
            return "Top"
        case .mediumMiddle:
            return "Middle"
        case .mediumBottom:
            return "Bottom"
        case .largeTop:
            return "Top"
        case .largeBottom:
            return "Bottom"
        }
    }

    var origin: CGPoint {
        switch ScreenInfo(size: CrossScreen.main.bounds.size).type {
        case .iPhone_428_926:
            switch self {
            case .smallTopLeft:
                return CGPoint(x: 32, y: 82)
            case .smallTopRight:
                return CGPoint(x: 226, y: 82)
            case .smallMiddleLeft:
                return CGPoint(x: 32, y: 294)
            case .smallMiddleRight:
                return CGPoint(x: 226, y: 294)
            case .smallBottomLeft:
                return CGPoint(x: 32, y: 506)
            case .smallBottomRight:
                return CGPoint(x: 226, y: 506)
            case .mediumTop:
                return CGPoint(x: 32, y: 82)
            case .mediumMiddle:
                return CGPoint(x: 32, y: 294)
            case .mediumBottom:
                return CGPoint(x: 32, y: 506)
            case .largeTop:
                return CGPoint(x: 32, y: 82)
            case .largeBottom:
                return CGPoint(x: 32, y: 294)
            }
        case .iPhone_414_896:
            switch self {
            case .smallTopLeft:
                return CGPoint(x: 27, y: 76)
            case .smallTopRight:
                return CGPoint(x: 218, y: 76)
            case .smallMiddleLeft:
                return CGPoint(x: 27, y: 286)
            case .smallMiddleRight:
                return CGPoint(x: 218, y: 286)
            case .smallBottomLeft:
                return CGPoint(x: 27, y: 496)
            case .smallBottomRight:
                return CGPoint(x: 218, y: 496)
            case .mediumTop:
                return CGPoint(x: 27, y: 76)
            case .mediumMiddle:
                return CGPoint(x: 27, y: 286)
            case .mediumBottom:
                return CGPoint(x: 27, y: 496)
            case .largeTop:
                return CGPoint(x: 27, y: 76)
            case .largeBottom:
                return CGPoint(x: 27, y: 286)
            }
        case .iPhone_414_736:
            switch self {
            case .smallTopLeft:
                return CGPoint(x: 33, y: 38)
            case .smallTopRight:
                return CGPoint(x: 224, y: 38)
            case .smallMiddleLeft:
                return CGPoint(x: 33, y: 232)
            case .smallMiddleRight:
                return CGPoint(x: 224, y: 232)
            case .smallBottomLeft:
                return CGPoint(x: 33, y: 426)
            case .smallBottomRight:
                return CGPoint(x: 224, y: 426)
            case .mediumTop:
                return CGPoint(x: 33, y: 38)
            case .mediumMiddle:
                return CGPoint(x: 33, y: 232)
            case .mediumBottom:
                return CGPoint(x: 33, y: 426)
            case .largeTop:
                return CGPoint(x: 33, y: 38)
            case .largeBottom:
                return CGPoint(x: 33, y: 232)
            }
        case .iPhone_390_844:
            switch self {
            case .smallTopLeft:
                return CGPoint(x: 26, y: 77)
            case .smallTopRight:
                return CGPoint(x: 206, y: 77)
            case .smallMiddleLeft:
                return CGPoint(x: 26, y: 273)
            case .smallMiddleRight:
                return CGPoint(x: 206, y: 273)
            case .smallBottomLeft:
                return CGPoint(x: 26, y: 469)
            case .smallBottomRight:
                return CGPoint(x: 206, y: 469)
            case .mediumTop:
                return CGPoint(x: 26, y: 77)
            case .mediumMiddle:
                return CGPoint(x: 26, y: 273)
            case .mediumBottom:
                return CGPoint(x: 26, y: 469)
            case .largeTop:
                return CGPoint(x: 26, y: 77)
            case .largeBottom:
                return CGPoint(x: 26, y: 273)
            }
        case .iPhone_375_812:
            switch self {
            case .smallTopLeft:
                return CGPoint(x: 23, y: 71)
            case .smallTopRight:
                return CGPoint(x: 197, y: 71)
            case .smallMiddleLeft:
                return CGPoint(x: 23, y: 261)
            case .smallMiddleRight:
                return CGPoint(x: 197, y: 261)
            case .smallBottomLeft:
                return CGPoint(x: 23, y: 451)
            case .smallBottomRight:
                return CGPoint(x: 197, y: 451)
            case .mediumTop:
                return CGPoint(x: 23, y: 71)
            case .mediumMiddle:
                return CGPoint(x: 23, y: 261)
            case .mediumBottom:
                return CGPoint(x: 23, y: 451)
            case .largeTop:
                return CGPoint(x: 23, y: 71)
            case .largeBottom:
                return CGPoint(x: 23, y: 261)
            }
        case .iPhone_375_667:
            switch self {
            case .smallTopLeft:
                return CGPoint(x: 27, y: 30)
            case .smallTopRight:
                return CGPoint(x: 200, y: 30)
            case .smallMiddleLeft:
                return CGPoint(x: 27, y: 206)
            case .smallMiddleRight:
                return CGPoint(x: 200, y: 206)
            case .smallBottomLeft:
                return CGPoint(x: 27, y: 382)
            case .smallBottomRight:
                return CGPoint(x: 197, y: 382)
            case .mediumTop:
                return CGPoint(x: 27, y: 30)
            case .mediumMiddle:
                return CGPoint(x: 27, y: 206)
            case .mediumBottom:
                return CGPoint(x: 27, y: 382)
            case .largeTop:
                return CGPoint(x: 27, y: 30)
            case .largeBottom:
                return CGPoint(x: 27, y: 206)
            }
        case .iPhone_360_780_375_812_mini:
            switch self {
            case .smallTopLeft:
                return CGPoint(x: 22, y: 74)
            case .smallTopRight:
                return CGPoint(x: 189, y: 74)
            case .smallMiddleLeft:
                return CGPoint(x: 22, y: 256)
            case .smallMiddleRight:
                return CGPoint(x: 189, y: 256)
            case .smallBottomLeft:
                return CGPoint(x: 22, y: 439)
            case .smallBottomRight:
                return CGPoint(x: 189, y: 439)
            case .mediumTop:
                return CGPoint(x: 22, y: 74)
            case .mediumMiddle:
                return CGPoint(x: 22, y: 256)
            case .mediumBottom:
                return CGPoint(x: 22, y: 439)
            case .largeTop:
                return CGPoint(x: 22, y: 74)
            case .largeBottom:
                return CGPoint(x: 22, y: 256)
            }
        case .iPhone_320_568:
            switch self {
            case .smallTopLeft:
                return CGPoint(x: 14, y: 30)
            case .smallTopRight:
                return CGPoint(x: 165, y: 30)
            case .smallMiddleLeft:
                return CGPoint(x: 14, y: 200)
            case .smallMiddleRight:
                return CGPoint(x: 165, y: 200)
            case .smallBottomLeft:
                return .zero
            case .smallBottomRight:
                return .zero
            case .mediumTop:
                return CGPoint(x: 14, y: 30)
            case .mediumMiddle:
                return CGPoint(x: 14, y: 200)
            case .mediumBottom:
                return .zero
            case .largeTop:
                return CGPoint(x: 14, y: 30)
            case .largeBottom:
                return .zero
            }
        case .unknown:
            return .zero
        }
    }
    
    var rect: CGRect { CGRect(origin: origin, size: family.size) }

}

extension Array where Element == WidgetPosition {
    static let smallItems: [WidgetPosition] = [.smallTopLeft, .smallTopRight, .smallMiddleLeft, .smallMiddleRight, .smallBottomLeft, .smallBottomRight]
    static let mediumItems: [WidgetPosition] = [.mediumTop, .mediumMiddle, .mediumBottom]
    static let largeItems: [WidgetPosition] = [.largeTop, .largeBottom]
}

extension WidgetPosition {
    static var smallItems: [WidgetPosition] { .smallItems }
    static var mediumItems: [WidgetPosition] { .mediumItems }
    static var largeItems: [WidgetPosition] { .largeItems }
}

#endif

