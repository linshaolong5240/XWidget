//
//  XWWidgetPosition.swift
//  XWidget
//
//  Created by teenloong on 2022/5/9.
//  Copyright © 2022 com.teenloong.com. All rights reserved.
//

import SwiftUI
import WidgetKit

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
