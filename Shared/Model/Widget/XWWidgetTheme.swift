//
//  XWWidgetTheme.swift
//  XWidget
//
//  Created by teenloong on 2022/3/31.
//  Copyright © 2022 com.teenloong.com. All rights reserved.
//

import SwiftUI
import WidgetKit

struct XWWidgetBackground: Codable, Hashable, Equatable {
    enum BackgroundType: Codable, Hashable {
        case color(XWColorWrapper)
        case colors([XWColorWrapper])
        case imageName(String)
        case imageNameFamily(small: String, medium: String, large: String)
        case imageURL(URL)
        #if canImport(UIKit)
        case transparent(lightImageURL: URL, darkImageURL: URL)
        #endif
    }
    
    let type: BackgroundType
    
    init(_ type: BackgroundType) {
        self.type = type
    }
    
    init(_ color: Color) {
        self.type = .color(color.colorWrapper)
    }
    
    init(_ colors: [Color]) {
        self.type = .colors(colors.map(\.colorWrapper))
    }
    
    init(imageName: String) {
        self.type = .imageName(imageName)
    }
    
    init(imageURL: URL) {
        self.type = .imageURL(imageURL)
    }
    
    init(small: String, medium: String, large: String) {
        self.type = .imageNameFamily(small: small, medium: medium, large: large)
    }
    
#if canImport(UIKit)
    init(transparent: (lightImageURL: URL, darkImageURL: URL)) {
        self.type = .transparent(lightImageURL: transparent.lightImageURL, darkImageURL: transparent.darkImageURL)
    }
#endif
    
    var imageURL: URL? {
        switch type {
        case .imageURL(let url):
            return url
        case .transparent(let lightImageURL, _):
            return lightImageURL
        default:
            return nil
        }
    }
    
    @ViewBuilder func makeView(_ family: WidgetFamily, colorScheme: ColorScheme) -> some View {
        switch type {
        case .color(let wrapperColor):
            wrapperColor.color
        case .colors(let wrapperColors):
            LinearGradient(colors: wrapperColors.map(\.color), startPoint: .topLeading, endPoint: .bottomTrailing)
        case .imageName(let name):
            Image(name).resizable()
        case .imageNameFamily(let small, let medium, let large):
            switch family {
            case .systemSmall: Image(small).resizable()
            case .systemMedium: Image(medium).resizable()
            case .systemLarge: Image(large).resizable()
            default: EmptyView()
            }
        case .imageURL(let url):
            if let uiImage = UIImage(contentsOfFile: url.path) {
                Image(uiImage: uiImage).resizable()
            }else {
                EmptyView()
            }
        case .transparent(let lightImageURL, let darkImageURL):
            switch colorScheme {
            case .light:
                if let uiImage = UIImage(contentsOfFile: lightImageURL.path) {
                    Image(uiImage: uiImage).resizable().aspectRatio(contentMode: .fit)
                } else {
                    EmptyView()
                }
            case .dark:
                if let uiImage = UIImage(contentsOfFile: darkImageURL.path) {
                    Image(uiImage: uiImage).resizable().aspectRatio(contentMode: .fit)
                } else {
                    EmptyView()
                }
            default:
                EmptyView()
            }
        }
    }
}

struct XWWidgetBorder: Codable, Hashable, Equatable {
    enum CWWidgetBorderType: Codable, Hashable, Equatable {
        case color(XWColorWrapper)
        case colors([XWColorWrapper])
        case image(String)
    }
    
    let type: CWWidgetBorderType
    
    init(_ type: CWWidgetBorderType) {
        self.type = type
    }
    
    init(_ color: Color) {
        self.type = .color(color.colorWrapper)
    }
    
    init(_ colors: [Color]) {
        self.type = .colors(colors.map(\.colorWrapper))
    }
    
    init(imageName: String) {
        self.type = .image(imageName)
    }
    
    @ViewBuilder func makeView(family: WidgetFamily? = nil, cornerRadius: CGFloat) -> some View {
        Group {
            switch type {
            case .color(let colorWrapper):
                colorWrapper.color
            case .colors(let colorWrappers):
                LinearGradient(gradient: .init(colors: colorWrappers.map(\.color)), startPoint: .topLeading, endPoint: .bottomTrailing)
            case .image(let imageName):
                Image(imageName)
            }
        }
        .mask(RoundedRectangle(cornerRadius: cornerRadius).strokeBorder(Color.black, lineWidth: family == nil ? 5 : 15))
    }
}

struct XWWidgetColorScheme: Codable, Hashable, Equatable {
    var color0: XWColorWrapper
    var color1: XWColorWrapper
    var color2: XWColorWrapper
    var color3: XWColorWrapper
    
    init() {
        self.init(.black)
    }
    
    init(_ colors: Color...) {
        switch colors.count {
        case 0:
            self.color0 = Color.black.colorWrapper
            self.color1 = Color.black.colorWrapper
            self.color2 = Color.black.colorWrapper
            self.color3 = Color.black.colorWrapper
        case 1:
            self.color0 = colors[0].colorWrapper
            self.color1 = colors[0].colorWrapper
            self.color2 = colors[0].colorWrapper
            self.color3 = colors[0].colorWrapper
        case 2:
            self.color0 = colors[0].colorWrapper
            self.color1 = colors[1].colorWrapper
            self.color2 = colors[1].colorWrapper
            self.color3 = colors[1].colorWrapper
        case 3:
            self.color0 = colors[0].colorWrapper
            self.color1 = colors[1].colorWrapper
            self.color2 = colors[2].colorWrapper
            self.color3 = colors[2].colorWrapper
        default:
            self.color0 = colors[0].colorWrapper
            self.color1 = colors[1].colorWrapper
            self.color2 = colors[2].colorWrapper
            self.color3 = colors[3].colorWrapper
        }
    }
}

typealias XWWidgetColor = XWColorWrapper

struct XWWidgetTheme: Codable, Identifiable, Equatable {
    var id: Int = 0
    var colorScheme: XWWidgetColorScheme? = nil
    var font: XWFontWrapper? = nil
    var fontColor: XWColorWrapper
    var background: XWWidgetBackground
    var border: XWWidgetBorder? = nil
}

extension XWWidgetTheme {
    static let guide = XWWidgetTheme(fontColor: .init(Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1))), background: .init(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))))
    static let calendar_plain = XWWidgetTheme(fontColor: .init(Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1))), background: .init(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))))
    static let clock_analog_plain = XWWidgetTheme(fontColor: .init(Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1))), background: .init(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))))
    static let gif = XWWidgetTheme(fontColor: .init(Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1))), background: .init(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))))
    static let photo_plain = XWWidgetTheme(fontColor: .init(Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1))), background: .init(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))))
}
