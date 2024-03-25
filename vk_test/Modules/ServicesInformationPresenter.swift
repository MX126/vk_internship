//
//  ServicesInformationPresenter.swift
//  vk_test
//
//  Created by Михаил on 26.03.2024.
//  
//

import Foundation

final class ServicesInformationPresenter {
    weak var view: ServicesInformationViewInput?
    weak var moduleOutput: ServicesInformationModuleOutput?
    
    private let router: ServicesInformationRouterInput
    private let interactor: ServicesInformationInteractorInput
    
    init(router: ServicesInformationRouterInput, interactor: ServicesInformationInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension ServicesInformationPresenter: ServicesInformationModuleInput {
}

extension ServicesInformationPresenter: ServicesInformationViewOutput {
}

extension ServicesInformationPresenter: ServicesInformationInteractorOutput {
}
