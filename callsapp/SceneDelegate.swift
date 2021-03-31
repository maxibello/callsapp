//
//  SceneDelegate.swift
//  callsapp
//
//  Created by Maxim Kuznetsov on 30.03.2021.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.windowScene = windowScene
        
        let missedCallsVC = MissedCallsViewController()
        window?.rootViewController = UINavigationController(rootViewController: missedCallsVC)
        window?.makeKeyAndVisible()
    }
}

