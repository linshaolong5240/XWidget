//
//  QWAPIAction.swift
//  
//
//  Created by teenloong on 2022/4/6.
//  Copyright © 2022 com.teenloong. All rights reserved.
//

import Foundation
import struct Alamofire.HTTPMethod

public struct QWEmptyParameters: Codable { }

public protocol QWAPIAction {
    associatedtype Parameters: Encodable
    associatedtype Response: Decodable
    var method: HTTPMethod { get }
    var host: String { get }
    var uri: String { get }
    var httpHeaders: [String: String]? { get }
    var timeoutInterval: TimeInterval { get }
    var parameters: Parameters? { get }
    var responseType: Response.Type { get }
}


extension QWAPIAction {
    public var method: HTTPMethod { .get }
    public var httpHeaders: [String: String]? { nil }
    public var timeoutInterval: TimeInterval { 20 }
    public var parameters: QWEmptyParameters? { nil }
}

extension QWAPIAction {
    public var geoHost: String { "https://geoapi.qweather.com" }
    public var weatherHost: String { "https://devapi.qweather.com" }
}
