//
//  XWUserStoregeHelper.swift
//  XWidget
//
//  Created by teenloong on 2022/3/31.
//  Copyright © 2022 com.teenloong.com. All rights reserved.
//

import Foundation

import Foundation
#if canImport(Combine)
import Combine
#endif
#if canImport(RxRelay)
import RxRelay
#endif

extension UserDefaults {
    public static let group: UserDefaults = UserDefaults(suiteName: "group.com.teenloong.XWidget")!
}

enum UserStorgeKey: String {
    case isInit
    case isFirstLaunch
    
    //Widget
    case widgetTransparentConfiguration
    case smallWidgetConfiguration
    case mediumWidgetConfiguration
    case largeWidgetConfiguration
}

@available(iOS 13.0, *)
@propertyWrapper
struct CombineUserStorge<T: Codable> {
    private let container: UserDefaults
    private let key: String
    private let defaultValue: T
#if canImport(Combine)
    public var projectedValue: CurrentValueSubject<T, Never>
#endif
    public var wrappedValue: T {
        get {
            guard let data = container.data(forKey: key) else { return defaultValue }
            return (try? JSONDecoder().decode(T.self, from: data)) ?? defaultValue
        }
        set {
            container.set(try? JSONEncoder().encode(newValue) , forKey: key)
            container.synchronize()
#if canImport(Combine)
            projectedValue.send(newValue)
#endif
        }
    }
    
    init(wrappedValue: T, key: UserStorgeKey, container: UserDefaults) {
        self.container = container
        self.key = key.rawValue
        self.defaultValue = wrappedValue
#if canImport(Combine)
        var savedValue: T = wrappedValue
        if let data = container.data(forKey: key.rawValue) {
            savedValue = (try? JSONDecoder().decode(T.self, from: data)) ?? wrappedValue
        }
        projectedValue =  .init(savedValue)
#endif
    }
}

@propertyWrapper
struct RxUserStorge<T: Codable> {
    struct Wrapper<T> : Codable where T : Codable {//Ios13以下 JSONEncoder 不支持JSON fragment转Data，需要一个容器兼容
        let wrapped : T
    }
    private let container: UserDefaults
    private let key: String
    private let defaultValue: T
#if canImport(RxRelay)
public var projectedValue: BehaviorRelay<T>
#endif
    public var wrappedValue: T {
        get {
            guard let data = container.data(forKey: key) else { return defaultValue }
            return (try? JSONDecoder().decode(Wrapper<T>.self, from: data))?.wrapped ?? defaultValue
        }
        set {
            container.set(try? JSONEncoder().encode(Wrapper(wrapped: newValue)) , forKey: key)
            container.synchronize()
#if canImport(RxRelay)
            projectedValue.accept(newValue)
#endif
        }
    }

    init(wrappedValue: T, key: UserStorgeKey, container: UserDefaults) {
        self.container = container
        self.key = key.rawValue
        self.defaultValue = wrappedValue
#if canImport(RxRelay)
        var savedValue: T = wrappedValue
        if let data = container.data(forKey: key.rawValue) {
            savedValue = (try? JSONDecoder().decode(Wrapper<T>.self, from: data))?.wrapped ?? wrappedValue
        }
        self.projectedValue = BehaviorRelay(value: savedValue)
#endif
    }
}
