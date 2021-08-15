//
//  SceneDelegate.swift
//  3205team
//
//  Created by Алексей Муренцев on 10.08.2021.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.windowScene = windowScene
        window?.makeKeyAndVisible()
        
        window?.rootViewController = appCoordinator.startApplication()
        
        showSplash()
    }
    
    func showSplash() {
        let splashView = SplashScreenView()
        splashView.frame = UIScreen.main.bounds
        window?.addSubview(splashView)
        DispatchQueue.main.async() {
            splashView.createAnimation()
            splashView.endAnimation = {
                splashView.removeFromSuperview()
            }
        }
    }
    
}

