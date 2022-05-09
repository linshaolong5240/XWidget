//
//  XWStore.swift
//  XWidget
//
//  Created by teenloong on 2022/3/31.
//  Copyright © 2022 com.teenloong.com. All rights reserved.
//

import Foundation
import Combine
import WidgetKit

public class Store: ObservableObject {
    var cancellables = Set<AnyCancellable>()
    public static let shared = Store()
    @Published var appState = XWAppState()
    
    func dispatch(_ action: XWAppAction) {
        #if DEBUG
        print("[ACTION]: \(action)")
        #endif
        let result = reduce(state: appState, action: action)
        appState = result.0
        if let appCommand = result.1 {
            #if DEBUG
            print("[COMMAND]: \(appCommand)")
            #endif
            appCommand.execute(in: self)
        }
    }
    
    
    func reduce(state: XWAppState, action: XWAppAction) -> (XWAppState, AppCommand?) {
        var XWAppState = state
        var appCommand: AppCommand? = nil
        switch action {
        case .initAction:
            appCommand = InitActionCommand()
        case .error(let error):
            XWAppState.error = error
        case .saveWidget(var configuration, let family):
            func getValidConfiguration(configurations: [XWWidgetEntry], configuration: XWWidgetEntry) -> Int {
                let id = configurations.filter({ item in
                    item.kind == configuration.kind
                }).map(\.orderID).max() ?? 0
                return id + 1
            }
            
            setWidgetThumbnail(configuration: &configuration, family: family)
            
            switch family {
            case .systemSmall:
                configuration.orderID = getValidConfiguration(configurations: appState.widget.smallWidgetConfiguration, configuration: configuration)
                appState.widget.smallWidgetConfiguration.insert(configuration, at: 0)
            case .systemMedium:
                configuration.orderID = getValidConfiguration(configurations: appState.widget.mediumWidgetConfiguration, configuration: configuration)
                appState.widget.mediumWidgetConfiguration.insert(configuration, at: 0)
            case .systemLarge:
                configuration.orderID = getValidConfiguration(configurations: appState.widget.largeWidgetConfiguration, configuration: configuration)
                appState.widget.largeWidgetConfiguration.insert(configuration, at: 0)
            default:
                break
            }
        case .updateWidget(var configuration, let family):
            setWidgetThumbnail(configuration: &configuration, family: family)
            switch family {
            case .systemSmall:
                if let index = appState.widget.smallWidgetConfiguration.firstIndex( where: { $0.idForSave == configuration.idForSave } ) {
                    appState.widget.smallWidgetConfiguration[index] = configuration
                    appState.widget.smallWidgetConfiguration.move(fromOffsets: .init(integer: index), toOffset: 0)
                    appCommand = WidgetReloadCommand(kind: XWidgetKind.small.rawValue)
                }
            case .systemMedium:
                if let index = appState.widget.mediumWidgetConfiguration.firstIndex( where: { $0.idForSave == configuration.idForSave } ) {
                    appState.widget.mediumWidgetConfiguration[index] = configuration
                    appState.widget.mediumWidgetConfiguration.move(fromOffsets: .init(integer: index), toOffset: 0)
                    appCommand = WidgetReloadCommand(kind: XWidgetKind.medium.rawValue)
                }
            case .systemLarge:
                if let index = appState.widget.largeWidgetConfiguration.firstIndex( where: { $0.idForSave == configuration.idForSave } ) {
                    appState.widget.largeWidgetConfiguration[index] = configuration
                    appState.widget.largeWidgetConfiguration.move(fromOffsets: .init(integer: index), toOffset: 0)
                    appCommand = WidgetReloadCommand(kind: XWidgetKind.large.rawValue)
                }
            default:
                break
            }
        case .deleteWidget(let widget, let family):
            switch family {
            case .systemSmall:
                if let index = appState.widget.smallWidgetConfiguration.firstIndex( where: { $0.idForSave == widget.idForSave } ) {
                    appState.widget.smallWidgetConfiguration.remove(at: index)
                }
            case .systemMedium:
                if let index = appState.widget.mediumWidgetConfiguration.firstIndex( where: { $0.idForSave == widget.idForSave } ) {
                    appState.widget.mediumWidgetConfiguration.remove(at: index)
                }
            case .systemLarge:
                if let index = appState.widget.largeWidgetConfiguration.firstIndex( where: { $0.idForSave == widget.idForSave } ) {
                    appState.widget.largeWidgetConfiguration.remove(at: index)
                }
            case .systemExtraLarge:
                break
            @unknown default:
                break
            }
        case .reloadWidget(let kind):
            appCommand = WidgetReloadCommand(kind: kind)
        case .setWidgetPostionImageDict(let dict, let colorScheme):
            switch colorScheme {
            case .light:
                appState.widget.widgetTransparentConfiguration.lightWidgetPostionImageURLDict = dict
            case .dark:
                appState.widget.widgetTransparentConfiguration.darkWidgetPostionImageURLDict = dict
            @unknown default:
                break
//                fatalError()
            }
        case .setWidgetTransparentBackground(let imageURL, let colorScheme):
            switch colorScheme {
            case .light:
                appState.widget.widgetTransparentConfiguration.lightImageURL = imageURL
            case .dark:
                appState.widget.widgetTransparentConfiguration.darkImageUrl = imageURL
            @unknown default:
                break
//                fatalError()
            }
            
            if let image = imageURL.image {
                appCommand = WidgetPostionImageMakeCommand(image: image, colorScheme: colorScheme)
            }
        }
        
        return (XWAppState, appCommand)
    }
}

extension Store {
    func setWidgetThumbnail(configuration: inout XWWidgetEntry, family: WidgetFamily) {
        guard let thumbnail = XWAnyWidgeView(entry: configuration, family: family)
            .modifier(WidgetPreviewModifier(family: family))
            .snapshot()?.resize(family.thumbnailSize) else {
            return
        }
        configuration.intentThumbnailURL = try? FileManager.save(image: thumbnail)
    }
}
