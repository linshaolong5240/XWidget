//
//  XWWidgetPosition+Extension.swift
//  XWidget (iOS)
//
//  Created by teenloong on 2022/5/9.
//  Copyright © 2022 com.teenloong.com. All rights reserved.
//

import SwiftUI
import WidgetKit

extension WidgetPosition {
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
    
    var origin: CGPoint {
        switch XWScreenInfo(size: CrossScreen.main.bounds.size).type {
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
