//
//  XWURLHelper.swift
//  XWidget
//
//  Created by teenloong on 2022/5/9.
//  Copyright © 2022 com.teenloong.com. All rights reserved.
//

import Foundation

extension URL {
    var image: CrossImage? { CrossImage(contentsOfFile: path) }
}

extension URL {
    var queryItems: [URLQueryItem]? { URLComponents(url: self, resolvingAgainstBaseURL: false)?.queryItems }
    
    var queryDictionary: [String: String] {
        var dict = [String: String]()
        queryItems?.forEach { item in
            dict[item.name] = item.value
        }
        return dict
    }
}
