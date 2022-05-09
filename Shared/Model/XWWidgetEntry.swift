//
//  XWWidgetEntry.swift
//  XWidget
//
//  Created by teenloong on 2022/3/31.
//  Copyright © 2022 com.teenloong.com. All rights reserved.
//

import Foundation
import SwiftUI
import WidgetKit

protocol XWWidgetConfiguration: Codable {
    var date: Date { get }
    var style: XWWidgetStyle { get }
    var theme: XWWidgetTheme { get }
}

struct XWGuideWidgetConfiguration: XWWidgetConfiguration {
    var date: Date = Date()
    var style: XWWidgetStyle
    var theme: XWWidgetTheme
}

struct XWCalendarWidgetConfiguration: XWWidgetConfiguration {
    var date: Date = Date()
    var style: XWWidgetStyle
    var theme: XWWidgetTheme
}

struct XWClockWidgetConfiguration: XWWidgetConfiguration {
    var date: Date = Date()
    var style: XWWidgetStyle
    var theme: XWWidgetTheme
}

struct XWGifWidgetConfiguration: XWWidgetConfiguration {
    struct GifModel: Codable, Equatable {
        var imagesURL: [URL] = []
        var timeInterval: TimeInterval = 1
    }
    
    var date: Date
    var style: XWWidgetStyle
    var theme: XWWidgetTheme
    var model: GifModel
}

struct XWPhotoWidgetConfiguration: XWWidgetConfiguration {
    struct PhotoModel: Codable {
        var photoImageURL: URL?
        var photoFrameImageURL: URL?
    }
    
    var date: Date
    var style: XWWidgetStyle
    var theme: XWWidgetTheme
    var model: PhotoModel
}

extension XWWidgetEntry {
    func asGuideWidgetConfiguraiton() -> XWGuideWidgetConfiguration {
        XWGuideWidgetConfiguration(date: date, style: style, theme: theme)
    }
    
    func asCalendarWidgetConfiguraiton() -> XWCalendarWidgetConfiguration {
        XWCalendarWidgetConfiguration(date: date, style: style, theme: theme)
    }
    
    func asClockWidgetConfiguraiton() -> XWClockWidgetConfiguration {
        XWClockWidgetConfiguration(date: date, style: style, theme: theme)
    }
    
    func asGifWidgetConfiguration() -> XWGifWidgetConfiguration {
        XWGifWidgetConfiguration(date: date, style: style, theme: theme, model: gifModel)
    }
    
    func asPhotoWidgetConfiguration() -> XWPhotoWidgetConfiguration {
        XWPhotoWidgetConfiguration(date: date, style: style, theme: theme, model: photoModel)
    }
}

struct XWWidgetEntry: TimelineEntry, XWWidgetConfiguration, Codable, Identifiable {
    var date = Date()
    var editedTime: Date = Date()
    var id: String { "\(kind.name)#\(style)#\(theme.id)#\(orderID)" }
    var idForSave: String { "\(kind.name)#\(style)#\(orderID)" }
    var intentThumbnailURL: URL?
    var kind: XWWidgetKind
    var style: XWWidgetStyle
    var theme: XWWidgetTheme
    var orderID: Int = 0
            
    var gifModel: XWGifWidgetConfiguration.GifModel = .init()
    var photoModel: XWPhotoWidgetConfiguration.PhotoModel = .init()

    mutating func setTransparentBackground(lightWidgetPostionImageURLDict: [WidgetPosition: URL], darkWidgetPostionImageURLDict: [WidgetPosition: URL], postion: WidgetPosition) {
        if let lightImageURL = lightWidgetPostionImageURLDict[postion] {
            let darkImageURL = darkWidgetPostionImageURLDict[postion]
            theme.background = XWWidgetBackground(transparent: (lightImageURL: lightImageURL, darkImageURL: darkImageURL ?? lightImageURL))
        }
    }
}

extension XWWidgetEntry {
    func intentThumbnailName(_ family: WidgetFamily) -> String {
        "intent_thumbnail#\(family)#\(idForSave)"
    }
    func photoName(_ family: WidgetFamily) -> String {
        "photo#\(family)#\(idForSave)"
    }
    func backgroundImageName(_ family: WidgetFamily) ->String {
        "background#\(family)#\(idForSave)"
    }
}

extension XWWidgetEntry {
    var name: String { kind.name }
    var localizedName: String { kind.localizedName }
    var orderName: String { kind.localizedName + String(orderID) }
}

extension XWWidgetEntry {
    static let guide = XWWidgetEntry(kind: .guide, style: .guide, theme: .guide)
    static let calendar_plain = XWWidgetEntry(kind: .calendar, style: .calendar_plain, theme: .calendar_plain)
    static let clock_analog_plain = XWWidgetEntry(kind: .clock, style: .clock_analog_plain, theme: .clock_analog_plain)
    static let gif = XWWidgetEntry(kind: .gif, style: .gif, theme: .gif)
    static let photo_plain = XWWidgetEntry(kind: .photo , style: .photo_plain, theme: .photo_plain)
    static let allItems: [XWWidgetEntry] = .allItems
}

extension Array where Element == XWWidgetEntry {
    static let calendars: [XWWidgetEntry] = [.calendar_plain]
    static let clocks: [XWWidgetEntry] = [.clock_analog_plain]
    static let gifs: [XWWidgetEntry] = [.gif]
    static let photos: [XWWidgetEntry] = [.photo_plain]
    static let allItems: [XWWidgetEntry] = [.calendar_plain, .clock_analog_plain, .photo_plain]
}
