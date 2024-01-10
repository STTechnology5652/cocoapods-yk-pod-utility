//
//  AppDelegate.swift
//  YKRPC_POD_NAME_Example
//
//  Created by YKRPC_AUTHOR_NAME on YKRPC_CREATE_DATE.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let win = UIWindow.init(frame: UIScreen.main.bounds)
        win.backgroundColor = UIColor.white
        self.window = win
        
        
        let tab = UITabBarController()
        var arr: [UIViewController] = [UIViewController]()
        do{
            let nav = UINavigationController.init(rootViewController: ViewController())
            arr.append(nav)
        }
        
        tab.viewControllers = arr
        win.rootViewController = tab
        win.makeKeyAndVisible()
        return true
    }
}

