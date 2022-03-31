//
//  XWidgetApp.swift
//  Shared
//
//  Created by teenloong on 2022/3/31.
//

import SwiftUI

@main
struct XWidgetApp: App {
    @StateObject private var store = Store.shared
#if canImport(UIKit)
@UIApplicationDelegateAdaptor(AppDelegate.self) var delegate: AppDelegate
#endif

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(store)
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

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        Store.shared.dispatch(.initAction)
        return true
    }
    
//    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
//        orientationSupport
//    }
}

//class SceneDelegate: NSObject, UIWindowSceneDelegate {
//    func scene(_ scene: UIScene, continue userActivity: NSUserActivity) {
//        if userActivity.activityType == NSUserActivity.chargingAnimationActivityType {
//            let vc = ChargingAnimationViewController()
////            vc.modalPresentationStyle = .fullScreen
//            UIApplication.rootViewController?.dismiss(animated: false, completion: nil)
//            UIApplication.rootViewController?.present(vc, animated: false, completion: nil)
//        }
//    }
//
//}
#endif
