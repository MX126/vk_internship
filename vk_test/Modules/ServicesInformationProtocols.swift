//
//  ServicesInformationProtocols.swift
//  vk_test
//
//  Created by Михаил on 26.03.2024.
//  
//

import Foundation

protocol ServicesInformationModuleInput {
    var moduleOutput: ServicesInformationModuleOutput? { get }
}

protocol ServicesInformationModuleOutput: AnyObject {
}

protocol ServicesInformationViewInput: AnyObject {
}

protocol ServicesInformationViewOutput: AnyObject {
}

protocol ServicesInformationInteractorInput: AnyObject {
}

protocol ServicesInformationInteractorOutput: AnyObject {
}

protocol ServicesInformationRouterInput: AnyObject {
}
