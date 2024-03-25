//
//  SceneDelegate.swift
//  vk_test
//
//  Created by Михаил on 25.03.2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else {
            return
        }
        
        setupWindow(with: scene)
        
        let viewController = ViewController()
        window?.rootViewController = viewController
    }
    
    private func setupWindow(with scene: UIScene) {
        guard let windowScene = (scene as? UIWindowScene) else {
            return
        }
        let window = UIWindow(windowScene: windowScene)
        
        self.window = window
        self.window?.makeKeyAndVisible()
    }
}
