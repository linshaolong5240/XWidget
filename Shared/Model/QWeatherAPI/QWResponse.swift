//
//  QWResponse.swift
//  
//
//  Created by teenloong on 2022/4/18.
//  Copyright © 2022 com.teenloong. All rights reserved.
//

import Foundation

public protocol QWResponse: Codable {
    var code: String { get }
}

public extension QWResponse {
    var isSuccess: Bool { code == "200" }
}

public struct QWRefer: Codable {
    public var license: [String]    //数据许可或版权声明，可能为空
    public var sources: [String]    //原始数据来源，或数据源说明，可能为空
}
