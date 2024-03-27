//
//  ServicesInformationPresenter.swift
//  vk_test
//
//  Created by Михаил on 26.03.2024.
//  
//

import UIKit

final class ServicesInformationPresenter {
    
    enum errorKey {
        case json
        case url
        
        func stringValue() -> String {
            switch self {
            case .json:
                return "Json body"
            case .url:
                return "Url"
            }
        }
    }
    
    weak var view: ServicesInformationViewInput?
    weak var moduleOutput: ServicesInformationModuleOutput?
    
    private let router: ServicesInformationRouterInput
    private let interactor: ServicesInformationInteractorInput
    
    init(router: ServicesInformationRouterInput, interactor: ServicesInformationInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
    
    private func handleError() -> String {
        return "Невозможно перейти по ссылке"
    }
}

extension ServicesInformationPresenter: ServicesInformationModuleInput {
}

extension ServicesInformationPresenter: ServicesInformationViewOutput {
    
    func didSelectService(_ service: Service) {
        guard let url = URL(string: service.link) else {
            DispatchQueue.main.async {
                self.view?.showError(with: errorKey.url.stringValue(), message: self.handleError())
            }
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
    func didFailFetchImage(with message: String) {
        DispatchQueue.main.async {
            self.view?.showError(with: errorKey.json.stringValue(), message: message)
        }
    }
    
    func didFailFetchBody(with message: String) {
        DispatchQueue.main.async {
            self.view?.showError(with: errorKey.json.stringValue(), message: message)
        }
    }
    
    func didFetchImage(_ image: UIImage?, for urlString: String) {
        DispatchQueue.main.async {
            self.view?.updateImage(image, for: urlString)
        }
    }
    
    func didFetchBody(services: [Service]) {
        view?.update(with: services)
    }
}
