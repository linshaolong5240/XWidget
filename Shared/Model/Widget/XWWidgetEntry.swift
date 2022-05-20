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

struct XWCountdownDaysWidgetConfiguration: XWWidgetConfiguration {
    var date: Date = Date()
    var style: XWWidgetStyle
    var theme: XWWidgetTheme
    var model: XWCountdownDaysModel
}

struct XWCountupDaysWidgetConfiguration: XWWidgetConfiguration {
    var date: Date = Date()
    var style: XWWidgetStyle
    var theme: XWWidgetTheme
    var model: XWCountupDaysModel
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

struct XWWidgetEntry: TimelineEntry, XWWidgetConfiguration, Codable, Identifiable {
    var date = Date()
    var editedTime: Date = Date()
    var id: String { "\(uuidString)_\(orderID)" }
    var uuidString: String = UUID().uuidString
    var intentThumbnailURL: URL?
    var kind: XWWidgetKind
    var style: XWWidgetStyle
    var theme: XWWidgetTheme
    var orderID: Int = 0
        
    var checkInModel: XWCheckInModel = .drinkWater
    var countdownDaysModel: XWCountdownDaysModel = .memorialDay
    var countupDaysModel: XWCountupDaysModel = .memorialDay
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
        "intent_thumbnail#\(family)#\(id)"
    }
    func photoName(_ family: WidgetFamily) -> String {
        "photo#\(family)#\(id)"
    }
    func backgroundImageName(_ family: WidgetFamily) ->String {
        "background#\(family)#\(id)"
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
    static let checkin_plain = XWWidgetEntry(kind: .checkin, style: .checkin_plain, theme: .checkin_plain)
    static let clock_analog_plain = XWWidgetEntry(kind: .clock, style: .clock_analog_plain, theme: .clock_analog_plain)
    static let countdown_days_plain = XWWidgetEntry(kind: .countdonw_days, style: .countdown_days_plain, theme: .countdown_days_plain)
    static let countup_days_plain = XWWidgetEntry(kind: .countup_days, style: .countup_days_plain, theme: .countup_days_plain)
    static let gif = XWWidgetEntry(kind: .gif, style: .gif, theme: .gif)
    static let photo_plain = XWWidgetEntry(kind: .photo , style: .photo_plain, theme: .photo_plain)
    static let allItems: [XWWidgetEntry] = .allItems
}

extension Array where Element == XWWidgetEntry {
    static let calendars: [XWWidgetEntry] = [.calendar_plain]
    static let checins: [XWWidgetEntry] = [.checkin_plain]
    static let clocks: [XWWidgetEntry] = [.clock_analog_plain]
    static let countDays: [XWWidgetEntry] = [.countdown_days_plain, .countup_days_plain]
    static let photos: [XWWidgetEntry] = [.photo_plain, .gif]
    static let allItems: [XWWidgetEntry] = [.calendar_plain, .clock_analog_plain, .photo_plain]
}
