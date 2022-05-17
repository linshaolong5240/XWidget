//
//  XWidgetApp.swift
//  Shared
//
//  Created by teenloong on 2022/3/31.
//

import SwiftUI
import WidgetKit

@main
struct XWidgetApp: App {
    @StateObject private var store = Store.shared
//#if canImport(UIKit)
//@UIApplicationDelegateAdaptor(AppDelegate.self) var delegate: AppDelegate
//#endif

    var body: some Scene {
        WindowGroup {
            ContentView()
                .onAppear {
                    store.dispatch(.initAction)
                }
                .onOpenURL { url in
                    //                    guard url.scheme == "MyApp" else { return }
                    print(url) // parse the url to get someAction to determine what the app needs do
                    handleURL(url: url)
                }
                .environmentObject(store)
        }
    }
    
    func handleURL(url: URL) {
        let components = URLComponents(url: url, resolvingAgainstBaseURL: false)

        guard let scheme = components?.scheme, scheme.contains("MyApp") else {
            return
        }
        
//        let queryItems = components?.queryItems
        
        switch url.path {
        case "/CheckIn":
            let query = url.queryDictionary
            guard let id = query["id"], let familyValue = query["family"], let family = WidgetFamily(rawValue: Int(familyValue) ?? 0) else {
#if canImport(UIKit)
UIApplication.shared.perform(#selector(NSXPCConnection.suspend))
#endif
                return
            }
            Store.shared.dispatch(.widgetCheckin(widgetID: id, family: family))
//        case "/DailyMood":
//            let query = url.queryDictionary
//            guard let id = query["id"], let familyValue = query["family"], let family = WidgetFamily(rawValue: Int(familyValue) ?? 0), let indexString = query["index"], let index = Int(indexString) else {
//#if canImport(UIKit)
//UIApplication.shared.perform(#selector(NSXPCConnection.suspend))
//#endif
//                return
//            }
//            Store.shared.dispatch(.updateDailyMoodModel(widgetID: id, family: family, moodIndex: index))
//            Store.shared.dispatch(.reloadWidget())
//#if canImport(UIKit)
//UIApplication.shared.perform(#selector(NSXPCConnection.suspend))
//#endif
            break
        default: break
        }
    }
}

#if canImport(UIKit)
class AppDelegate: NSObject, UIApplicationDelegate, ObservableObject {
    
//    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
//        let sceneConfig = UISceneConfiguration(name: nil, sessionRole: connectingSceneSession.role)
//        sceneConfig.delegateClass = SceneDelegate.self
//        return sceneConfig
//    }

//    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
//        Store.shared.dispatch(.initAction)
//        return true
//    }
    
//    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
//        orientationSupport
//    }
}

//class SceneDelegate: NSObject, UIWindowSceneDelegate {
//    func scene(_ scene: UIScene, continue userActivity: NSUserActivity) {
//
//    }
//
//}
#endif
