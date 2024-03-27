//
//  ServicesInformationPresenter.swift
//  vk_test
//
//  Created by Михаил on 26.03.2024.
//  
//

import UIKit

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
    
    func didSelectService(_ service: Service) {
        guard let url = URL(string: service.link) else {
            view?.showError()
            return
        }

        router.openURL(url)
    }
    
    func loadImage(at indexPath: IndexPath, urlString: String) {
        interactor.fetchImage(urlString: urlString)
    }
    
    func didLoadView() {
        let viewModel = ServicesInformationViewModel()
        view?.configure(with: viewModel)
        
        interactor.fetchBody()
    }
}

extension ServicesInformationPresenter: ServicesInformationInteractorOutput {
    func didFetchImage(_ image: UIImage?, for urlString: String) {
        DispatchQueue.main.async {
            self.view?.updateImage(image, for: urlString)
        }
    }
    
    func didFailFetchImage(for urlString: String, error: Error) {
        view?.showError()
    }
    
    func didFetchBody(services: [Service]) {
        view?.update(with: services)
    }
    
    func didFailFetchBody() {
        view?.showError()
    }
}
