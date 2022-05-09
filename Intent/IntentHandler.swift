//
//  IntentHandler.swift
//  Intent
//
//  Created by teenloong on 2022/3/31.
//

import Intents
import SwiftUI
import WidgetKit

extension WidgetPosition {
    var imageName: String {
        switch self {
        case .smallTopLeft:
            return "icon_widget_position_small_top_left"
        case .smallTopRight:
            return "icon_widget_position_small_top_right"
        case .smallMiddleLeft:
            return "icon_widget_position_small_middle_left"
        case .smallMiddleRight:
            return "icon_widget_position_small_middle_right"
        case .smallBottomLeft:
            return "icon_widget_position_small_bottom_left"
        case .smallBottomRight:
            return "icon_widget_position_small_bottom_right"
        case .mediumTop:
            return "icon_widget_position_medium_top"
        case .mediumMiddle:
            return "icon_widget_position_medium_middle"
        case .mediumBottom:
            return "icon_widget_position_medium_bottom"
        case .largeTop:
            return "icon_widget_position_large_top"
        case .largeBottom:
            return "icon_widget_position_large_bottom"
        }
    }
}

class IntentHandler: INExtension {
    
    override func handler(for intent: INIntent) -> Any {
        // This is the default implementation.  If you want different objects to handle different intents,
        // you can override this and return the handler you want for that particular intent.
        
        return self
    }
    
}

extension IntentHandler: XWSmallWidgetConfigurationIntentHandling {
    func provideCurrentWidgetOptionsCollection(for intent: XWSmallWidgetConfigurationIntent, with completion: @escaping (INObjectCollection<XWWidgetType>?, Error?) -> Void) {
        provideWidgetOptionsCollection(.systemSmall, for: intent, with: completion)
    }
    
    func provideTransparentBackgroundOptionsCollection(for intent: XWSmallWidgetConfigurationIntent, with completion: @escaping (INObjectCollection<XWWidgetPositionType>?, Error?) -> Void) {
        provideTransparentBackgroundOptionsCollection(family: .systemSmall, for: intent, with: completion)
    }
}

extension IntentHandler: XWMediumWidgetConfigurationIntentHandling {
    func provideCurrentWidgetOptionsCollection(for intent: XWMediumWidgetConfigurationIntent, with completion: @escaping (INObjectCollection<XWWidgetType>?, Error?) -> Void) {
        provideWidgetOptionsCollection(.systemMedium, for: intent, with: completion)
    }
    
    func provideTransparentBackgroundOptionsCollection(for intent: XWMediumWidgetConfigurationIntent, with completion: @escaping (INObjectCollection<XWWidgetPositionType>?, Error?) -> Void) {
        provideTransparentBackgroundOptionsCollection(family: .systemMedium, for: intent, with: completion)
    }
}

extension IntentHandler: XWLargeWidgetConfigurationIntentHandling {
    func provideCurrentWidgetOptionsCollection(for intent: XWLargeWidgetConfigurationIntent, with completion: @escaping (INObjectCollection<XWWidgetType>?, Error?) -> Void) {
        provideWidgetOptionsCollection(.systemLarge, for: intent, with: completion)
    }
    
    func provideTransparentBackgroundOptionsCollection(for intent: XWLargeWidgetConfigurationIntent, with completion: @escaping (INObjectCollection<XWWidgetPositionType>?, Error?) -> Void) {
        provideTransparentBackgroundOptionsCollection(family: .systemLarge, for: intent, with: completion)
    }
}

extension IntentHandler {
    func provideWidgetOptionsCollection<Intent>(_ family: WidgetFamily, for intent: Intent, with completion: @escaping (INObjectCollection<XWWidgetType>?, Error?) -> Void) where Intent: XWWidgetIntent {
        @CombineUserStorge(key: .smallWidgetConfiguration, container: .group)
        var smallWidgetConfiguration: [XWWidgetEntry] = []
        @CombineUserStorge(key: .mediumWidgetConfiguration, container: .group)
        var mediumWidgetConfiguration: [XWWidgetEntry] = []
        @CombineUserStorge(key: .largeWidgetConfiguration, container: .group)
        var largeWidgetConfiguration: [XWWidgetEntry] = []
        
        var configurations = [XWWidgetEntry]()
        switch family {
        case .systemSmall:
            configurations = smallWidgetConfiguration
        case .systemMedium:
            configurations = mediumWidgetConfiguration
        case .systemLarge:
            configurations = largeWidgetConfiguration
        case .systemExtraLarge:
            break
        @unknown default:
            break
        }
        
        let items = configurations.map { item -> XWWidgetType in
            var image: INImage?
            if let url = item.intentThumbnailURL {
                if let data = UIImage(contentsOfFile: url.path)?.jpegData(compressionQuality: 0.6) {
                    image = .init(imageData: data)
                }
            }
            return XWWidgetType(identifier: item.id, display: item.orderName, subtitle: nil, image: image)
        }
        
        completion(INObjectCollection(sections: [INObjectSection(title: "Current Widget", items: items)]),
                   nil)
    }
    
    func provideTransparentBackgroundOptionsCollection<Intent>(family: WidgetFamily, for intent: Intent, with completion: @escaping (INObjectCollection<XWWidgetPositionType>?, Error?) -> Void) where Intent: XWWidgetIntent {
        var positionItems: [WidgetPosition] = []
        switch family {
        case .systemSmall:
            positionItems = WidgetPosition.smallItems
        case .systemMedium:
            positionItems = WidgetPosition.mediumItems
        case .systemLarge:
            positionItems = WidgetPosition.largeItems
        default:
            break
        }
        var items = positionItems.map { item -> XWWidgetPositionType in
            var image: INImage?
            if  let data = UIImage(named: item.imageName)?.pngData() {
                image = .init(imageData: data)
            }
            
            return XWWidgetPositionType(identifier: "\(item.rawValue)", display: NSLocalizedString(item.name, comment: ""), pronunciationHint: nil, subtitle: nil, image: image)
        }
        let image = INImage(imageData: UIImage(systemName: "iphone")!.pngData()!)
        let defaultType = XWWidgetPositionType(identifier: "\(WidgetPosition.allCases.count)", display: "None", pronunciationHint: nil, subtitle: nil, image: image)
        items.insert(defaultType, at: 0)
        completion(INObjectCollection(sections: [INObjectSection(title: nil, items: items)]), nil)
    }
}
