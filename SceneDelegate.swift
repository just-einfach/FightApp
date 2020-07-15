//
//  SceneDelegate.swift
//  FIGHT!
//
//  Created by   Vlad on 04.05.2020.
//  Copyright © 2020   Vlad. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    var navController = UINavigationController()
    
    
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        let firstViewController = FirstViewController()
        
        
        self.navController = UINavigationController(rootViewController: firstViewController)
        
        
        navController.setNavigationBarHidden(true, animated: true)
        
        self.window?.rootViewController = self.navController
        
        self.window?.makeKeyAndVisible()
        
        
        
        
    }
    
}
