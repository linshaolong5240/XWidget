//
//  QWTopCititesAction.swift
//  
//
//  Created by teenloong on 2022/4/6.
//  Copyright © 2022 com.teenloong. All rights reserved.
//

import Foundation

public struct QWTopCititesAction: QWAPIAction {    
    public typealias Response = QWTopCititesResponse

    public var host: String { geoHost }
    public var uri: String { "/v2/city/top" }
    public var parameters: Parameters?
    public var responseType = Response.self

    public init() { }
}


public struct QWTopCititesResponse: QWResponse {
    public struct TopCityList: Codable {
        var adm1: String        //地区/城市所属一级行政区域
        var adm2: String        //地区/城市的上级行政区划名称
        var country: String     //地区/城市所属国家名称
        var fxLink: String      //该地区的天气预报网页链接，便于嵌入你的网站或应用
        var id: String          //地区/城市ID
        var isDst: String       //地区/城市是否当前处于夏令时 1 表示当前处于夏令时 0 表示当前不是夏令时
        var lat: String         //地区/城市纬度
        var lon: String         //地区/城市经度
        var name: String        //地区/城市名称
        var rank: String        //地区评分
        var type: String        //地区/城市的属性
        var tz: String          //地区/城市所在时区
        var utcOffset: String   //地区/城市目前与UTC时间偏移的小时数
    }
    public var code: String
    public var topCityList: [TopCityList]
    public var refer: QWRefer
}
