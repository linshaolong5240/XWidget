//
//  XWColorWrapper.swift
//  XWidget
//
//  Created by teenloong on 2022/3/31.
//  Copyright © 2022 com.teenloong.com. All rights reserved.
//

import SwiftUI

struct XWColorWrapper: Codable, Equatable, Hashable {
    var red: Double
    var green: Double
    var blue: Double
    var alpha: Double
    
    public init(red: Double, green: Double, blue: Double, alpha: Double = 1.0) {
        self.red = red
        self.green = green
        self.blue = blue
        self.alpha = alpha
    }
}

@available(iOS 14.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
extension XWColorWrapper {
    public init(_ color: Color) {
        guard let c = CrossColor(color).cgColor.components, c.count == 4 else {
            self.init(red: 1, green: 1, blue: 1, alpha: 1)
            return
        }
        self.init(red: Double(c[0]), green: Double(c[1]), blue: Double(c[2]), alpha: Double(c[3]))
    }
    
    var color: Color { Color(red: red, green: green, blue: blue, opacity: alpha) }
}

extension XWColorWrapper {
    public init(_ color: CrossColor) {
        guard let c = color.cgColor.components, c.count == 4 else {
            self.init(red: 1, green: 1, blue: 1, alpha: 1)
            return
        }
        self.init(red: Double(c[0]), green: Double(c[1]), blue: Double(c[2]), alpha: Double(c[3]))
    }
}

extension Color {
    var colorWrapper: XWColorWrapper { .init(self) }
}
