//
//  QWSearchCityAction.swift
//  XWidget
//
//  Created by teenloong on 2022/4/18.
//  Copyright © 2022 com.teenloong.com. All rights reserved.
//

import Foundation

public struct QWSearchCityAction: QWAPIAction {
    public struct QWSearchCityParameters: Codable {
        public var location: String     //需要查询地区的名称，支持文字、以英文逗号分隔的经度,纬度坐标（十进制，最多支持小数点后两位）、LocationID或Adcode（仅限中国城市）。例如 location=北京 或 location=116.41,39.92
        public var adm: String?         //城市的上级行政区划，默认不限定行政区划。 可设定只在某个行政区划范围内进行搜索，用于排除重名城市或对结果进行过滤。例如 adm=beijing
        public var range: String?       //搜索范围，可设定只在某个国家范围内进行搜索，国家名称需使用ISO 3166 所定义的国家代码
        public var number: Int?         //返回结果的数量，取值范围1-20，默认返回10个结果
        public var lang: String?        //多语言设置，默认中文，当数据不匹配你设置的语言时，将返回英文或其本地语言结果。
        public init(location: String, adm: String?, range: String, number: Int?, lang: String?) {
            self.location = location
            self.adm = adm
            self.range = range
            self.number = number
            self.lang = lang
        }
    }
    public typealias Parameters = QWSearchCityParameters
    public typealias Response = QWTopCititesResponse
    
    public var host: String { geoHost }
    public var uri: String { "/v2/city/lookup" }
    public var parameters: Parameters?
    public var responseType = Response.self

    public init() { }
}


public struct QWSearchCityResponse: QWResponse {
    public struct Location: Codable {
        public var name: String         //地区/城市名称
        public var id: String           //地区/城市ID
        public var lat: String          //地区/城市纬度
        public var lon: String          //地区/城市经度
        public var adm2: String         //地区/城市的上级行政区划名称
        public var adm1: String         //地区/城市所属一级行政区域
        public var country: String      //地区/城市所属国家名称
        public var tz: String           //地区/城市所在时区
        public var utcOffset: String    //地区/城市目前与UTC时间偏移的小时数，参考详细说明
        public var isDst: String        //地区/城市是否当前处于夏令时 1 表示当前处于夏令时 0 表示当前不是夏令时
        public var type: String         //地区/城市的属性
        public var rank: String         //地区评分
        public var fxLink: String       //该地区的天气预报网页链接，便于嵌入你的网站或应用
    }
    public var code: String
    public var location: [Location]
    public var refer: QWRefer
}
