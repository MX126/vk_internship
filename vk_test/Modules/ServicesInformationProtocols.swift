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
    func showError()
    func update(with services: [Service])
    func configure(with model: ServicesInformationViewModel)
    func updateImage(_ image: UIImage?, for urlString: String)
}

protocol ServicesInformationViewOutput: AnyObject {
    func didLoadView()
    func loadImage(at indexPath: IndexPath, urlString: String)
    func didSelectService(_ service: Service)
}

protocol ServicesInformationInteractorInput: AnyObject {
    func fetchBody()
    func fetchImage(urlString: String)
}

protocol ServicesInformationInteractorOutput: AnyObject {
    func didFetchBody(services: [Service])
    func didFailFetchBody()
    func didFetchImage(_ image: UIImage?, for urlString: String)
    func didFailFetchImage(for urlString: String, error: Error)
}

protocol ServicesInformationRouterInput: AnyObject {
    func openURL(_ url: URL)
}
