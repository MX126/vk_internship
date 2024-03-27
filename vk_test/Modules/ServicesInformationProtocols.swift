//
//  ServicesInformationProtocols.swift
//  vk_test
//
//  Created by Михаил on 26.03.2024.
//  
//

import UIKit

protocol ServicesInformationModuleInput {
    var moduleOutput: ServicesInformationModuleOutput? { get }
}

protocol ServicesInformationModuleOutput: AnyObject {
}

protocol ServicesInformationViewInput: AnyObject {
    func showError(with key: String, message: String)
    func update(with services: [Service])
    func updateImage(_ image: UIImage?, for urlString: String)
    func configure(with model: ServicesInformationViewModel)
}

protocol ServicesInformationViewOutput: AnyObject {
    func didLoadView()
    func didSelectService(_ service: Service)
    func loadImage(at indexPath: IndexPath, urlString: String)
}

protocol ServicesInformationInteractorInput: AnyObject {
    func fetchBody()
    func fetchImage(urlString: String)
}

protocol ServicesInformationInteractorOutput: AnyObject {
    func didFetchBody(services: [Service])
    func didFetchImage(_ image: UIImage?, for urlString: String)
    func didFailFetchBody(with message: String)
    func didFailFetchImage(with message: String)
}

protocol ServicesInformationRouterInput: AnyObject {
    func openURL(_ url: URL)
}
