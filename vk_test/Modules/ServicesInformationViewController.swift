//
//  ServicesInformationViewController.swift
//  vk_test
//
//  Created by Михаил on 26.03.2024.
//  
//

import UIKit

final class ServicesInformationViewController: UIViewController {
    private let output: ServicesInformationViewOutput

    init(output: ServicesInformationViewOutput) {
        self.output = output

        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
}

extension ServicesInformationViewController: ServicesInformationViewInput {
}
