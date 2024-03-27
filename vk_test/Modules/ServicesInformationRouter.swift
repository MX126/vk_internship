//
//  ServicesInformationRouter.swift
//  vk_test
//
//  Created by Михаил on 26.03.2024.
//  
//

import UIKit

final class ServicesInformationRouter {
}

extension ServicesInformationRouter: ServicesInformationRouterInput {
    func openURL(_ url: URL) {
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            print("")
        }
    }
}
