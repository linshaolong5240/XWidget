//
//  XWFontWrapper.swift
//  XWidget
//
//  Created by teenloong on 2022/3/31.
//  Copyright © 2022 com.teenloong.com. All rights reserved.
//

import SwiftUI

public struct XWFontWrapper: Codable, Hashable, Equatable {
    public var name: String
    public var size: CGFloat

    public init(name: String, size: CGFloat) {
        self.name = name
        self.size = size
    }

}

extension XWFontWrapper {
    public init(_ font: CrossFont) {
        self.name = font.fontName
        self.size = font.pointSize
    }
    
    public var uiFont: CrossFont? { CrossFont(name: name, size: size) }
}

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
extension XWFontWrapper {
    public var font: Font { Font.custom(name, size: size) }
}

extension XWFontWrapper {
    static let `default` = XWFontWrapper(.systemFont(ofSize: 14))
}
