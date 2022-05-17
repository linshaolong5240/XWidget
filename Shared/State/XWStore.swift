//
//  XWStore.swift
//  XWidget
//
//  Created by teenloong on 2022/3/31.
//  Copyright © 2022 com.teenloong.com. All rights reserved.
//

import SwiftUI
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
        case .saveWidget(var widget, let family):
            func getValidConfiguration(configurations: [XWWidgetEntry], configuration: XWWidgetEntry) -> Int {
                let id = configurations.filter({ item in
                    item.kind == configuration.kind
                }).map(\.orderID).max() ?? 0
                return id + 1
            }
            
            setWidgetThumbnail(widget: &widget, family: family)
            
            switch family {
            case .systemSmall:
                widget.orderID = getValidConfiguration(configurations: appState.widget.smallWidgetConfiguration, configuration: widget)
                appState.widget.smallWidgetConfiguration.insert(widget, at: 0)
            case .systemMedium:
                widget.orderID = getValidConfiguration(configurations: appState.widget.mediumWidgetConfiguration, configuration: widget)
                appState.widget.mediumWidgetConfiguration.insert(widget, at: 0)
            case .systemLarge:
                widget.orderID = getValidConfiguration(configurations: appState.widget.largeWidgetConfiguration, configuration: widget)
                appState.widget.largeWidgetConfiguration.insert(widget, at: 0)
            default:
                break
            }
        case .updateWidget(var widget, let family):
            setWidgetThumbnail(widget: &widget, family: family)
            switch family {
            case .systemSmall:
                if let index = appState.widget.smallWidgetConfiguration.firstIndex( where: { $0.idForSave == widget.idForSave } ) {
                    appState.widget.smallWidgetConfiguration[index] = widget
                    appState.widget.smallWidgetConfiguration.move(fromOffsets: .init(integer: index), toOffset: 0)
                    appCommand = WidgetReloadCommand(kind: XWidgetKind.small.rawValue)
                }
            case .systemMedium:
                if let index = appState.widget.mediumWidgetConfiguration.firstIndex( where: { $0.idForSave == widget.idForSave } ) {
                    appState.widget.mediumWidgetConfiguration[index] = widget
                    appState.widget.mediumWidgetConfiguration.move(fromOffsets: .init(integer: index), toOffset: 0)
                    appCommand = WidgetReloadCommand(kind: XWidgetKind.medium.rawValue)
                }
            case .systemLarge:
                if let index = appState.widget.largeWidgetConfiguration.firstIndex( where: { $0.idForSave == widget.idForSave } ) {
                    appState.widget.largeWidgetConfiguration[index] = widget
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
        case .widgetCheckin(let widgetID, let family):
            switch family {
            case .systemSmall:
                if let index = appState.widget.smallWidgetConfiguration.firstIndex( where: { $0.id == widgetID } ) {
                    if !appState.widget.smallWidgetConfiguration[index].checkInModel.isCompleted {
                        appState.widget.smallWidgetConfiguration[index].checkInModel.checkIn()
                        #if canImport(UIKit)
                        UIApplication.shared.perform(#selector(NSXPCConnection.suspend))
                        #endif
                        appCommand = WidgetReloadCommand()
                    }
                }
            case .systemMedium:
                if let index = appState.widget.mediumWidgetConfiguration.firstIndex( where: { $0.id == widgetID } ) {
                    if !appState.widget.mediumWidgetConfiguration[index].checkInModel.isCompleted {
                        appState.widget.mediumWidgetConfiguration[index].checkInModel.checkIn()
                        #if canImport(UIKit)
                        UIApplication.shared.perform(#selector(NSXPCConnection.suspend))
                        #endif
                        appCommand = WidgetReloadCommand()
                    }
                }
            case .systemLarge, .systemExtraLarge:
                if let index = appState.widget.largeWidgetConfiguration.firstIndex( where: { $0.id == widgetID } ) {
                    if !appState.widget.largeWidgetConfiguration[index].checkInModel.isCompleted {
                        appState.widget.largeWidgetConfiguration[index].checkInModel.checkIn()
                        #if canImport(UIKit)
                        UIApplication.shared.perform(#selector(NSXPCConnection.suspend))
                        #endif
                        appCommand = WidgetReloadCommand()
                    }
                }
            default: break
            }
        }
        
        return (XWAppState, appCommand)
    }
}

extension Store {
    func setWidgetThumbnail(widget: inout XWWidgetEntry, family: WidgetFamily) {
        guard let thumbnail = XWAnyWidgeView(entry: .constant(widget), family: family)
            .modifier(WidgetPreviewModifier(family: family))
            .snapshot()?.resize(family.thumbnailSize) else {
            return
        }
        widget.intentThumbnailURL = try? FileManager.save(image: thumbnail)
    }
}
