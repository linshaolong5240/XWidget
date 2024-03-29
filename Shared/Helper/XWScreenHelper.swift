//
//  XWScreenHelper.swift
//  XWidget
//
//  Created by teenloong on 2022/3/31.
//  Copyright © 2022 com.teenloong.com. All rights reserved.
//

import Foundation
import SwiftUI

extension CrossScreen {
    public static var screenType: XWScreenType { screenInfo.type }
    public static var screenInfo: XWScreenInfo {
        #if os(iOS)
        return XWScreenInfo(size: main.bounds.size)
        #endif
        #if os(macOS)
        return XWScreenInfo(size: main?.frame.size ?? .zero)
        #endif
    }
}

public enum XWScreenType {
    case iPhone_428_926//iPhone 13 Pro Max
    case iPhone_414_896//iPhone 11 Pro Max
    case iPhone_414_736//iPhone 8 Plus
    case iPhone_390_844//iPhone 13 Pro iPhone 13
    case iPhone_375_812//Phone 11 Pro
    case iPhone_375_667//iPhone 8
    case iPhone_360_780_375_812_mini//for iPhone mini
    case iPhone_320_568
    case unknown
}

public struct XWScreenInfo {
    var type: XWScreenType
    var size: CGSize
    
    #if os(iOS)
    //Fixed iPhone mini
    static var isMini: Bool {
        UIScreen.main.nativeBounds.size.equalTo(CGSize(width: 1080, height: 2340))
    }
    #endif
    
    init(size: CGSize) {
        switch size {
        case CGSize(width: 428, height: 926):
            self.type = .iPhone_428_926
            self.size = CGSize(width: 428, height: 926)
        case CGSize(width: 414, height: 896):
            self.type = .iPhone_414_896
            self.size = CGSize(width: 414, height: 896)
        case CGSize(width: 414, height: 736):
            self.type = .iPhone_414_736
            self.size = CGSize(width: 414, height: 736)
        case CGSize(width: 390, height: 844):
            self.type = .iPhone_390_844
            self.size = CGSize(width: 390, height: 844)
        case CGSize(width: 375, height: 812):
            #if os(iOS)
            if XWScreenInfo.isMini {
                self.type = .iPhone_360_780_375_812_mini
                self.size = CGSize(width: 360, height: 780)
            } else {
                self.type = .iPhone_375_812
                self.size = CGSize(width: 375, height: 812)
            }
            #else
            self.type = .iPhone_375_812
            self.size = CGSize(width: 375, height: 812)
            #endif
        case CGSize(width: 375, height: 667):
            self.type = .iPhone_375_667
            self.size = CGSize(width: 375, height: 667)
        case CGSize(width: 360, height: 780):
            self.type = .iPhone_360_780_375_812_mini
            self.size = CGSize(width: 360, height: 780)
        case CGSize(width: 320, height: 568):
            self.type = .iPhone_320_568
            self.size = CGSize(width: 320, height: 568)
        default:
            self.type = .unknown
            self.size = size
        }
    }
}
