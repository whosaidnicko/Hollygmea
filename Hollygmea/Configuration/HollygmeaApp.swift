//
//  Hollygmea.swift
//  Training
//

import SwiftUI

@main
struct Hollygmea: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    let isSecondLaunch: Bool = UserDefaults.standard.bool(forKey: "isSecondLaunch")
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                if isSecondLaunch {
                    TabBarView()
                } else {
                    OnboardingView()
                }
            }
            .navigationViewStyle(.stack)
            .environment(\.managedObjectContext, DataController.shared.container.viewContext)
        }
    }
    
    
}
class AppDelegate: NSObject, UIApplicationDelegate {
    static var wuziszbopes = UIInterfaceOrientationMask.portrait {
        didSet {
            if #available(iOS 16.0, *) {
                UIApplication.shared.connectedScenes.forEach { scene in
                    if let windowScene = scene as? UIWindowScene {
                        windowScene.requestGeometryUpdate(.iOS(interfaceOrientations: wuziszbopes))
                    }
                }
                UIViewController.attemptRotationToDeviceOrientation()
            } else {
                if wuziszbopes == .landscape {
                    UIDevice.current.setValue(UIInterfaceOrientation.landscapeRight.rawValue, forKey: "orientation")
                } else {
                    UIDevice.current.setValue(UIInterfaceOrientation.portrait.rawValue, forKey: "orientation")
                }
            }
        }
    }
    
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        return AppDelegate.wuziszbopes
    }
}
