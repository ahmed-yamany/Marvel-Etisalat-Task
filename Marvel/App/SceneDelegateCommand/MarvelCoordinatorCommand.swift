//
//  MarvelCoordinatorCommand.swift
//  Marvel
//
//  Created by Ahmed Yamany on 16/07/2024.
//

import UIKit

struct MarvelCoordinatorCommand: SceneDelegateCommand {
    let scene: UIScene
    
    func execute() {
        MarvelCoordinator.shared.makeWindow(from: scene)
    }
}
