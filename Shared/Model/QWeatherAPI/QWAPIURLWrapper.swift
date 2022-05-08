//
//  QWAPIURLWrapper.swift
//  
//
//  Created by teenloong on 2022/4/6.
//  Copyright © 2022 com.teenloong. All rights reserved.
//

import Foundation

public struct QWAPIURLWrapper {
    var url: URL?
    var urlComponents: URLComponents?
    
    var urlString: String { urlComponents?.url?.absoluteString ?? "" }
    
    public init(urlString: String, key: String) {
        self.url = URL(string: urlString)
        var urlComponents = URLComponents(string: urlString)
        if urlComponents?.queryItems == nil {
            urlComponents?.queryItems = [URLQueryItem(name: "key", value: key)]
        } else {
            urlComponents?.queryItems?.append(URLQueryItem(name: "key", value: key))
        }
        self.urlComponents = urlComponents
    }
}
