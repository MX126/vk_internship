//
//  ServicesInformationViewModel.swift
//  vk_test
//
//  Created by Михаил on 26.03.2024.
//

import UIKit
 
struct ServicesInformationViewModel {
    let title: NSAttributedString
    
    init() {
        self.title = NSAttributedString(string: "Сервисы", attributes: Styles.titleAttributes)
    }
}

private extension ServicesInformationViewModel {
    struct Styles {
        static let titleAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.gray,
            .font: UIFont.systemFont(ofSize: 20)
        ]
    }
}
