//
//  XWAppCommand.swift
//  XWidget
//
//  Created by teenloong on 2022/3/31.
//  Copyright © 2022 com.teenloong.com. All rights reserved.
//

import SwiftUI
import WidgetKit

protocol AppCommand {
    func execute(in store: Store)
}

struct InitActionCommand: AppCommand {
    func execute(in store: Store) {
        
    }
}

struct WidgetPostionImageMakeCommand: AppCommand {
    let image: UIImage
    let colorScheme: ColorScheme
    
    func execute(in store: Store) {
        DispatchQueue.global().async {
            var dict = [WidgetPosition : URL]()
            WidgetPosition.allCases.forEach { item in
                let rectImage = image.cropAtRect(rect: item.rect)
                let url = try? FileManager.save(image: rectImage, name: item.imageSaveName(colorScheme: colorScheme))
                dict[item] = url
            }
            DispatchQueue.main.async {
                store.dispatch(.setWidgetPostionImageDict(dict: dict, colorScheme: colorScheme))
                store.dispatch(.reloadWidget())
            }
        }
    }
}

struct WidgetReloadCommand: AppCommand {
    var kind: String? = nil
    
    func execute(in store: Store) {
        if let k = kind {
            WidgetCenter.shared.reloadTimelines(ofKind: k)
        }else {
            WidgetCenter.shared.reloadAllTimelines()
        }
    }
}
