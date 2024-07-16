//
//  SceneDelegate.swift
//  Marvel
//
//  Created by Ahmed Yamany on 16/07/2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        let commands: [SceneDelegateCommand] = [
            MarvelCoordinatorCommand(scene: scene)
        ]
        
        commands.forEach { $0.execute() }
    }
}
