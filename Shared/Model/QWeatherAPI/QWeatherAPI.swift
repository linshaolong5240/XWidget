//
//  QWAPIURLWrapper.swift
//
//
//  Created by teenloong on 2022/4/6.
//  Copyright © 2022 com.teenloong. All rights reserved.
//

import Foundation
import Alamofire

fileprivate extension Encodable {
    func asDictionary() -> [String: Any]? {
        return (try? JSONSerialization.jsonObject(with: JSONEncoder().encode(self))) as? [String: Any]
    }
}

fileprivate extension Dictionary {
    var jsonString: String? {
        guard let data = try? JSONSerialization.data(withJSONObject: self, options: []) else {
            return nil
        }
        return String(data: data, encoding: .utf8)
    }
}

fileprivate func DEBUGRequest<Action: QWAPIAction>(action: Action, response: AFDataResponse<Data?>) {
    #if DEBUG
    print("parameters:")
    print(action.parameters?.asDictionary() ?? [String: Any]())
    print("request:")
    if let request = response.request {
        print(request)
    }
    print("HTTPHeader:")
    if let httpHeader = response.request?.allHTTPHeaderFields {
        print(httpHeader)
    }
    print("HTTPBody:")
    if let httpBody = response.request?.httpBody {
        print(String(data: httpBody, encoding: .utf8) ?? "nil")
    }
    print("response data:")
    if let data = response.data {
        print(data)
        print("response data string:")
        print(String(data: data, encoding: .utf8) ?? "nil")

    }
    print("response error:")
    if let error = response.error {
        print(error)
    }
    #endif
}

public class QWeatherAPI {
    private var key: String

    #if DEBUG
    public var debug: Bool = true
    #else
    public var debug: Bool = false
    #endif
    
    public var requestHttpHeader: [String: String] = [String: String]()
    
    public init(key: String) {
        self.key = key
    }
    
    @discardableResult
    public func request<Action: QWAPIAction>(action: Action, completionHandler: @escaping (Result<Action.Response?, Error>) -> Void) -> DataRequest {
        let url = QWAPIURLWrapper(urlString: action.host + action.uri, key: key).urlString
        var httpHeaders: [String: String] = .init()
        if let headers = action.httpHeaders {
            httpHeaders.merge(headers) { current, new in
                new
            }
        }
        
        let request = AF.request(url,
                                 method: action.method,
                                 parameters: action.parameters?.asDictionary(),
                                 encoding: action.method == .get ? URLEncoding.default : JSONEncoding.default,
                                  headers: HTTPHeaders(httpHeaders), requestModifier: { $0.timeoutInterval = action.timeoutInterval })
            .response { response in
                DEBUGRequest(action: action, response: response)
                guard response.error == nil else {
                    completionHandler(.failure(response.error!))
                    return
                }
                guard let data = response.data, !data.isEmpty else {
                    completionHandler(.success(nil))
                    return
                }
                do {
                    let model = try JSONDecoder().decode(action.responseType, from: data)
                    #if false
                    print(model)
                    #endif
                    completionHandler(.success(model))
                } catch let error {
                    completionHandler(.failure(error))
                }
            }
        return request
    }
}
