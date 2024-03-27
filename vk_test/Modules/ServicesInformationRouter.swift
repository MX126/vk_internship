//
//  ServicesInformationRouter.swift
//  vk_test
//
//  Created by Михаил on 26.03.2024.
//  
//

import UIKit

final class ServicesInformationRouter {
    weak var viewController: ServicesInformationViewController?
}

extension ServicesInformationRouter: ServicesInformationRouterInput {
    func openURL(_ url: URL) {
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            guard let vc = viewController  else {
                fatalError("No access to viewController")
            }
            DispatchQueue.main.async {
                AlertManager.showInvalidAppUrl(on: vc)
            }
        }
    }
}
