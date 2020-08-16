//
//  SceneDelegate.swift
//  Breeds
//
//  Created by erick.lozano.borges on 02/08/20.
//  Copyright © 2020 borges.erick. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = scene as? UIWindowScene else { return }
        window = UIWindow(windowScene: windowScene)

        let controller = BreedsCollectionViewController()
        let navigation = UINavigationController(rootViewController: controller)
        
        window?.rootViewController = navigation
        window?.backgroundColor = BackgroundColor.main        
        window?.makeKeyAndVisible()
    }
}
