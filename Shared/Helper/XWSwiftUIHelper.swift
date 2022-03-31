//
//  XWSwiftUIHelper.swift
//  XWidget
//
//  Created by teenloong on 2022/3/31.
//  Copyright © 2022 com.teenloong.com. All rights reserved.
//

import SwiftUI

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
extension View {
    //Conditional modifier https://designcode.io/swiftui-handbook-conditional-modifier
    @ViewBuilder func `if`<Content: View>(_ condition: Bool, transform: (Self) -> Content) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
}

#if canImport(UIKit)
//Authorization Alert
@available(iOS 13.0, tvOS 13.0, *)
@available(iOSApplicationExtension, unavailable)
extension Alert {
    public static func systemAuthorization() {
        guard let url = URL(string: UIApplication.openSettingsURLString), UIApplication.shared.canOpenURL(url) else { return }
        UIApplication.shared.open(url)
    }
    
    public static let locationAuthorization: Alert = Alert(title: Text("Location Permissions"), message: Text("Location Authorization Desc"), primaryButton: .cancel(Text("Cancel")), secondaryButton: .default(Text("Go to Authorization"), action: { systemAuthorization() }))
    public static let photoLibraryAuthorization: Alert = Alert(title: Text("PhotoLibrary Permissions"), message: Text("PhotoLibrary Authorization Desc"), primaryButton: .cancel(Text("Cancel")), secondaryButton: .default(Text("Go to Authorization"), action: { systemAuthorization() }))
    public static let cameraAuthorization: Alert = Alert(title: Text("Camera Permissions"), message: Text("Camera Authorization Desc"), primaryButton: .cancel(Text("Cancel")), secondaryButton: .default(Text("Go to Authorization"), action: { systemAuthorization() }))
}

//SwiftUI 隐藏导航栏后返回手势失效问题
//https://stackoverflow.com/questions/59921239/hide-navigation-bar-without-losing-swipe-back-gesture-in-swiftui
extension UINavigationController: UIGestureRecognizerDelegate {
    override open func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = self
    }

    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return viewControllers.count > 1
    }
}

@available(iOS 13.0, tvOS 13.0, *)
@available(iOSApplicationExtension, unavailable)
extension View {
    //StackNavigationViewStyle
    public func popToRootView() {
        func findNavigationController(viewController: UIViewController?) -> UINavigationController? {
            guard let viewController = viewController else {
                return nil
            }

            if let navigationController = viewController as? UINavigationController {
                return navigationController
            }

            for childViewController in viewController.children {
                return findNavigationController(viewController: childViewController)
            }

            return nil
        }
        findNavigationController(viewController: UIApplication.shared.windows.filter { $0.isKeyWindow }.first?.rootViewController)?
            .popToRootViewController(animated: true)
    }
}

@available(iOS 13.0, tvOS 13.0, *)
@available(iOSApplicationExtension, unavailable)
extension View {
    public func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif

