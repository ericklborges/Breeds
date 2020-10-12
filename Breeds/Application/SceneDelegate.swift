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
        startAtBreedsCollection(on: scene)
        self.scene(scene, openURLContexts: connectionOptions.urlContexts)
    }
    
    // breeds://detail?breedImageId=JuanFra
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        guard
            let url = URLContexts.first?.url,
            let components = URLComponents(url: url, resolvingAgainstBaseURL: true),
            let queryItems = components.queryItems
        else { return }
        
        let parameters = queryItems.reduce(into: [String: String]()) { $0[$1.name] = $1.value }
        deeplinkToDetail(on: scene, with: parameters)
    }
}

// MARK: - Navigation
extension SceneDelegate {
    private func startAtBreedsCollection(on scene: UIScene) {
        guard let windowScene = scene as? UIWindowScene else { return }
        window = UIWindow(windowScene: windowScene)

        let controller = BreedsCollectionViewController()
        let navigation = UINavigationController(rootViewController: controller)
        
        window?.rootViewController = navigation
        window?.backgroundColor = BackgroundColor.main
        window?.makeKeyAndVisible()
    }
    
    private func deeplinkToDetail(on scene: UIScene, with parameters: [String: String]) {
        guard
            let breedImageId = parameters["breedImageId"],
            let navigation = window?.rootViewController as? UINavigationController,
            let breedsCollection = navigation.viewControllers.first as? BreedsCollectionViewController
        else { return }
        
        navigation.popToRootViewController(animated: false)
        breedsCollection.showDetailWith(breedImageId: breedImageId)
    }
}
