//
//  XWWidgetTransparentConfiguration.swift
//  XWidget
//
//  Created by teenloong on 2022/3/31.
//  Copyright © 2022 com.teenloong.com. All rights reserved.
//

import SwiftUI

struct XWWidgetTransparentConfiguration: Codable {
    var lightImageURL: URL?
    var darkImageUrl: URL?
    
    var lightWidgetPostionImageURLDict: [WidgetPosition : URL] = [:]
    var darkWidgetPostionImageURLDict: [WidgetPosition : URL] = [:]
    
    var lightImage: UIImage? {
        guard let path = lightImageURL?.path else {
            return nil
        }
        return UIImage(contentsOfFile: path)
    }
    
    var darkImage: UIImage? {
        guard let path = darkImageUrl?.path else {
            return nil
        }
        return UIImage(contentsOfFile: path)
    }
    
    var isEmpty: Bool {
        lightImageURL == nil
    }
    
    func image(colorScheme: ColorScheme) -> UIImage? {
        switch colorScheme {
        case .light:
            return lightImage
        case .dark:
            return darkImage
        @unknown default:
            return nil
        }
    }
    
    func image(position: WidgetPosition, colorScheme: ColorScheme) -> UIImage? {
        switch colorScheme {
        case .light:
            guard let lightPositionImageURL = lightWidgetPostionImageURLDict[position], let lightPositionImage = UIImage(contentsOfFile: lightPositionImageURL.path) else {
                return nil
            }
            return lightPositionImage
        case .dark:
            guard let darkPositionImageURL = darkWidgetPostionImageURLDict[position], let darkPositionImage = UIImage(contentsOfFile: darkPositionImageURL.path) else {
                return nil
            }
            return darkPositionImage
        default:
            return nil
        }
    }
}
