//
//  XWidget.swift
//  XWidget
//
//  Created by teenloong on 2022/3/31.
//

import WidgetKit
import SwiftUI
import Intents

@main
struct MainWidgets: WidgetBundle {
    
    init() { }
    
    @WidgetBundleBuilder
    var body: some Widget {
        XWSmallWidget()
        XWMediumWidget()
        XWLargeWidget()
    }
}

struct XWWidgetManager {
    @CombineUserStorge(key: .widgetTransparentConfiguration, container: .group)
    static var transparentConfiguration: XWWidgetTransparentConfiguration = XWWidgetTransparentConfiguration()

    @CombineUserStorge(key: .smallWidgetConfiguration, container: .group)
    static var smallWidgetConfiguration: [XWWidgetEntry] = []

    @CombineUserStorge(key: .mediumWidgetConfiguration, container: .group)
    static var mediumWidgetConfiguration: [XWWidgetEntry] = []

    @CombineUserStorge(key: .largeWidgetConfiguration, container: .group)
    static var largeWidgetConfiguration: [XWWidgetEntry] = []
    
    static func updateWidget(widget: XWWidgetEntry, family: WidgetFamily) {
        switch family {
        case .systemSmall:
            if let index = smallWidgetConfiguration.firstIndex( where: { $0.idForSave == widget.idForSave } ) {
                smallWidgetConfiguration[index] = widget
            }
        case .systemMedium:
            if let index = mediumWidgetConfiguration.firstIndex( where: { $0.idForSave == widget.idForSave } ) {
                mediumWidgetConfiguration[index] = widget
            }
        case .systemLarge:
            if let index = largeWidgetConfiguration.firstIndex( where: { $0.idForSave == widget.idForSave } ) {
                largeWidgetConfiguration[index] = widget
            }
        default:
            break
        }
    }
}

extension IntentTimelineProvider where Entry == XWWidgetEntry {
    
    func widgetPlaceholder(in context: Context) -> XWWidgetEntry {
        .guide
    }
    
    func getWidgetSnapshot<Intent>(for configuration: Intent, in context: Context, completion: @escaping (XWWidgetEntry) -> ()) where Intent: XWWidgetIntent {
        completion(.guide)
    }
    
    func getWidgetTimeline<Intent>(for configuration: Intent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) where Intent: XWWidgetIntent {
        
        func setTransparentBackground(widgetConfiguration: inout XWWidgetEntry) {
            if let identifier = configuration.transparentBackground?.identifier, let rawValue = Int(identifier), let widgetPosition = WidgetPosition(rawValue: rawValue) {
                widgetConfiguration.setTransparentBackground(lightWidgetPostionImageURLDict: XWWidgetManager.transparentConfiguration.lightWidgetPostionImageURLDict, darkWidgetPostionImageURLDict: XWWidgetManager.transparentConfiguration.darkWidgetPostionImageURLDict, postion: widgetPosition)
            }
        }
        
        var widgetEntries = [XWWidgetEntry]()
        switch context.family {
        case .systemSmall:
            widgetEntries = XWWidgetManager.smallWidgetConfiguration
        case .systemMedium:
            widgetEntries = XWWidgetManager.mediumWidgetConfiguration
        case .systemLarge:
            widgetEntries = XWWidgetManager.largeWidgetConfiguration
        default: break
        }
        
        guard let widgetIdentifier = configuration.currentWidget?.identifier, var widgetEntry = widgetEntries.first(where: { $0.id == widgetIdentifier }) else {
            var widgetConfiguration: XWWidgetEntry = .guide
            setTransparentBackground(widgetConfiguration: &widgetConfiguration)
            let entries: [XWWidgetEntry] = [widgetConfiguration]
            let timeline = Timeline(entries: entries, policy: .never)
            completion(timeline)
            return
        }
        
        setTransparentBackground(widgetConfiguration: &widgetEntry)
        
        switch widgetEntry.kind {
        case .guide:
            getStaticTimeline(for: widgetEntry, in: context, completion: completion)
        case .calendar:
            getNextDayTimeline(for: widgetEntry, in: context, completion: completion)
        case .clock:
            getMinutesTimeline(for: widgetEntry, in: context, completion: completion)
        case .checkin:
            getNextDayTimeline(for: widgetEntry, in: context, completion: completion)
        case .countdonw_days:
            getCountdownDaysTimeline(for: widgetEntry, in: context, completion: completion)
        case .gif:
            getGifTimeline(for: widgetEntry, in: context, completion: completion)
        case .photo:
            getPhotoTimeline(for: widgetEntry, in: context, completion: completion)
//        case .clock_analog:
//            getMinutesTimeline(for: widgetType, in: context, completion: completion)
//        case .clock_digital:
//            getMinutesTimeline(for: widgetType, in: context, completion: completion)
//        case .countdown_days:
//            getNextDayTimeline(for: widgetType, in: context, completion: completion)
//        case .notepad:
//            getStaticTimeline(for: widgetType, in: context, completion: completion)
//        case .shortcut:
//            getStaticTimeline(for: widgetType, in: context, completion: completion)
//        case .weather:
//            getWeatherTimeline(for: widgetType, in: context, completion: completion)
        }
        
    }
    
    func getStaticTimeline(for widgetEntry: XWWidgetEntry, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [XWWidgetEntry] = []
        
        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        var entry = widgetEntry
        entry.date = Date()
        entries.append(entry)
        let timeline = Timeline(entries: entries, policy: .never)
        completion(timeline)
    }
    
    func getMinutesTimeline(for widgetEntry: XWWidgetEntry, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [XWWidgetEntry] = []
        
        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let now = Date()
        var minutes = [Date]()
        var interval = DateInterval()
        interval = Calendar.current.dateInterval(of: .hour, for: now)!
        interval.start = now
        minutes.append(interval.start)
        let dates = Calendar.current.generateDates(inside: interval, matching: DateComponents(second: 0))
        minutes.append(contentsOf: dates)
        entries = minutes[..<29].map({ date in
            var entry = widgetEntry
            entry.date = date
            return entry
        })
        
        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
    
    func getNextDayTimeline(for widgetEntry: XWWidgetEntry, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [XWWidgetEntry] = []
        
        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let now = Date()
        var entry = widgetEntry
        entry.date = now
        entries.append(entry)
        let refleshDate: Date = Calendar.current.nextDay(for: now)
        
        let timeline = Timeline(entries: entries, policy: .after(refleshDate))
        completion(timeline)
    }
    
    func getCheckInTimeline(for widgetEntry: XWWidgetEntry, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [XWWidgetEntry] = []
        
        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let now = Date()
        var entry = widgetEntry
        entry.date = now
        entry.checkInModel.checkValidWithReset()

        entries.append(entry)
        let refleshDate: Date = Calendar.current.nextDay(for: now)
        
        let timeline = Timeline(entries: entries, policy: .after(refleshDate))
        completion(timeline)
    }
    
    func getCountdownDaysTimeline(for widgetEntry: XWWidgetEntry, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [XWWidgetEntry] = []
        
        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let now = Date()
        var entry = widgetEntry
        entry.date = now
        entry.countdownDaysModel.checkAndSetRepeat(from: now)
        entries.append(entry)
        let refleshDate: Date = Calendar.current.nextDay(for: now)
        
        let timeline = Timeline(entries: entries, policy: .after(refleshDate))
        completion(timeline)
    }
    
    func getGifTimeline(for widgetEntry: XWWidgetEntry, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [XWWidgetEntry] = []
        
        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let now = Date()
        let refreshDate = now + 60 * 6
        
        for secondOffset in 0 ..< 60 * 5 {
            let entryDate = Calendar.current.date(byAdding: .second, value: secondOffset, to: now)!
            var entry = widgetEntry
            entry.date = entryDate
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .after(refreshDate))
        completion(timeline)
    }
    
    func getPhotoTimeline(for widgetEntry: XWWidgetEntry, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [XWWidgetEntry] = []
        
        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let now = Date()
        let refreshDate = now + 60 * 5
        //limit size 260 * 100Kb
        for secondOffset in 0 ..< 300 {
            let entryDate = Calendar.current.date(byAdding: .second, value: secondOffset, to: now)!
            var entry = widgetEntry
            entry.date = entryDate
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .after(refreshDate))
        completion(timeline)
    }
    
//    func getWeatherTimeline(for widget: XWWidgetEntry, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
//
//        var entries: [XWWidgetEntry] = []
//
//        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
//        let now = Date()
//        let requestFailedDate = now + 5 * 60
//        let refreshDate = Calendar.current.nextHour(for: now)
//
//        var entry = widget
//        entry.date = now
//
//        guard let location = entry.weatherData?.location else {
//            entries.append(entry)
//            let timeline = Timeline(entries: entries, policy: .after(refreshDate))
//            completion(timeline)
//            return
//        }
//
//        CW.request(action: CWApiWeatherAction(location)) { result in
//            switch result {
//            case .success(let response):
//                guard let data = response?.data else {
//                    entries.append(entry)
//                    let timeline = Timeline(entries: entries, policy: .after(requestFailedDate))
//                    completion(timeline)
//                    return
//                }
//                entry.weatherData?.weather = data
//                switch context.family {
//                case .systemSmall:
//                    if let index = savedSmallWidgets.firstIndex(where: { $0.id == entry.id }) {
//                        savedSmallWidgets[index] = entry
//                    }
//                case .systemMedium:
//                    if let index =  savedMediumWidgets.firstIndex(where: { $0.id == entry.id }) {
//                        savedMediumWidgets[index] = entry
//                    }
//                case .systemLarge:
//                    if let index =  savedLargeWidgets.firstIndex(where: { $0.id == entry.id }) {
//                        savedLargeWidgets[index] = entry
//                    }
//                case .systemExtraLarge:
//                    break
//                @unknown default:
//                    break
//                }
//                entries.append(entry)
//                let timeline = Timeline(entries: entries, policy: .after(refreshDate))
//                completion(timeline)
//            case .failure(let error):
//                #if DEBUG
//                print(error)
//                #endif
//                entries.append(entry)
//                let timeline = Timeline(entries: entries, policy: .after(requestFailedDate))
//                completion(timeline)
//            }
//        }
//    }
    
}

struct XWWidgetSmallProvider: IntentTimelineProvider {
    
    func placeholder(in context: Context) -> XWWidgetEntry {
        widgetPlaceholder(in: context)
    }

    func getSnapshot(for configuration: XWSmallWidgetConfigurationIntent, in context: Context, completion: @escaping (XWWidgetEntry) -> ()) {
        getWidgetSnapshot(for: configuration, in: context, completion: completion)
    }

    func getTimeline(for configuration: XWSmallWidgetConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        getWidgetTimeline(for: configuration, in: context, completion: completion)
    }
}

struct XWWidgetMediumProvider: IntentTimelineProvider {

    func placeholder(in context: Context) -> XWWidgetEntry {
        widgetPlaceholder(in: context)
    }

    func getSnapshot(for configuration: XWMediumWidgetConfigurationIntent, in context: Context, completion: @escaping (XWWidgetEntry) -> ()) {
        getWidgetSnapshot(for: configuration, in: context, completion: completion)
    }

    func getTimeline(for configuration: XWMediumWidgetConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        getWidgetTimeline(for: configuration, in: context, completion: completion)
    }
}

struct XWWidgetLargeProvider: IntentTimelineProvider {

    func placeholder(in context: Context) -> XWWidgetEntry {
        widgetPlaceholder(in: context)
    }

    func getSnapshot(for configuration: XWLargeWidgetConfigurationIntent, in context: Context, completion: @escaping (XWWidgetEntry) -> ()) {
        getWidgetSnapshot(for: configuration, in: context, completion: completion)
    }

    func getTimeline(for configuration: XWLargeWidgetConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        getWidgetTimeline(for: configuration, in: context, completion: completion)
    }
}


struct XWWidgetEntryView : View {
    @Environment(\.widgetFamily) var family: WidgetFamily
    var entry: XWWidgetEntry

    var body: some View {
        XWAnyWidgeView(entry: .constant(entry), family: family)
    }
}

struct XWSmallWidget: Widget {
    let kind: String = XWidgetKind.small.rawValue

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: XWSmallWidgetConfigurationIntent.self, provider: XWWidgetSmallProvider()) { entry in
            XWWidgetEntryView(entry: entry)
        }
        .supportedFamilies([.systemSmall])
        .configurationDisplayName("WidgetSmallDisplayName")
        .description("WidgetSmallDescription")
    }
}

struct XWMediumWidget: Widget {
    let kind: String = XWidgetKind.medium.rawValue

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: XWMediumWidgetConfigurationIntent.self, provider: XWWidgetMediumProvider()) { entry in
            XWWidgetEntryView(entry: entry)
        }
        .supportedFamilies([.systemMedium])
        .configurationDisplayName("WidgetMediumDisplayName")
        .description("WidgetMediumDescription")
    }
}

struct XWLargeWidget: Widget {
    let kind: String = XWidgetKind.large.rawValue

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: XWLargeWidgetConfigurationIntent.self, provider: XWWidgetLargeProvider()) { entry in
            XWWidgetEntryView(entry: entry)
        }
        .supportedFamilies([.systemLarge])
        .configurationDisplayName("WidgetLargeDisplayName")
        .description("WidgetLargeDescription")
    }
}

#if DEBUG
struct XWidget_Previews: PreviewProvider {
    static var previews: some View {
        let config = XWWidgetEntry.checkin_plain
        XWWidgetEntryView(entry: config)
            .previewContext(WidgetPreviewContext(family: .systemSmall))
        XWWidgetEntryView(entry: config)
            .previewContext(WidgetPreviewContext(family: .systemMedium))
        XWWidgetEntryView(entry: config)
            .previewContext(WidgetPreviewContext(family: .systemLarge))
    }
}
#endif
