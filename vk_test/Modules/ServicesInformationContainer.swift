//
//  ServicesInformationContainer.swift
//  vk_test
//
//  Created by Михаил on 26.03.2024.
//  
//

import UIKit

final class ServicesInformationContainer {
    let input: ServicesInformationModuleInput
    let viewController: UIViewController
    private(set) weak var router: ServicesInformationRouterInput!
    
    class func assemble(with context: ServicesInformationContext) -> ServicesInformationContainer {
        let router = ServicesInformationRouter()
        let interactor = ServicesInformationInteractor()
        let presenter = ServicesInformationPresenter(router: router, interactor: interactor)
        let viewController = ServicesInformationViewController(output: presenter)
        
        presenter.view = viewController
        presenter.moduleOutput = context.moduleOutput
        
        interactor.output = presenter
        
        return ServicesInformationContainer(view: viewController, input: presenter, router: router)
    }
    
    private init(view: UIViewController, input: ServicesInformationModuleInput, router: ServicesInformationRouterInput) {
        self.viewController = view
        self.input = input
        self.router = router
    }
}

struct ServicesInformationContext {
    weak var moduleOutput: ServicesInformationModuleOutput?
}
