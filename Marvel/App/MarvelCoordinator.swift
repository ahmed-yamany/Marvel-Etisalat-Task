//
//  MarvelCoordinator.swift
//  Marvel
//
//  Created by Ahmed Yamany on 16/07/2024.
//

import UIKit
import Coordinator

protocol MarvelCoordinatorProtocol: Coordinator {
    func makeWindow(from scene: UIScene)
}

extension LoggingCategories {
    var coordinator: String { "Coordinator" }
}

final class MarvelCoordinator: MarvelCoordinatorProtocol {
    static let shared = MarvelCoordinator()
    
    let router: Router
    var window: UIWindow?

    private init() {
        router = Router(navigationController: .init())
    }
    
    func makeWindow(from scene: UIScene) {
        guard let windowScene = (scene as? UIWindowScene) else {
            Logger.log("Failed to downcast UIScene to UIWindowScen", category: \.coordinator, level: .error)
            return
        }
        
        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = router.navigationController
        window.makeKeyAndVisible()
        self.window = window
        self.start()
    }
    
    func start() {
        SeriesCoordinator(router: router).start()
    }
}
