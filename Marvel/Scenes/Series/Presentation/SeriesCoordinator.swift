//
//  SeriesCoordinator.swift
//  Marvel
//
//  Created by Ahmed Yamany on 16/07/2024.
//

import Foundation
import Coordinator

protocol SeriesCoordinatorProtocol: Coordinator {
}

final class SeriesCoordinator: SeriesCoordinatorProtocol {
    let router: Router
    
    init(router: Router) {
        self.router = router
    }
    
    func start() {
        let useCase = SeriesUseCase()
        let viewModel = SeriesViewModel(coordinator: self, useCase: useCase)
        let controller = SeriesViewController(viewModel: viewModel)
        router.setViewController(controller)
    }
}