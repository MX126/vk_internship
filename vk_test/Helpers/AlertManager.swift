//
//  AlertManager.swift
//  vk_test
//
//  Created by Михаил on 27.03.2024.
//

import UIKit

final class AlertManager {
    
    private static func showBasicAlert(on vc: UIViewController, title: String, message: String?) {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Принять", style: .default, handler: nil))
            vc.present(alert, animated: true)
    }
}

extension AlertManager {
    static func showInvalidUrlAlert(on vc: UIViewController, message: String) {
        self.showBasicAlert(on: vc, title: "Неверный Url", message: message)
    }
    
    static func showInvalidJsonBodyAlert(on vc: UIViewController, message: String) {
        self.showBasicAlert(on: vc, title: "Ошибка в просмотре JSON", message: message)
    }
    
    static func showInvalidAlert(on vc: UIViewController) {
        self.showBasicAlert(on: vc, title: "Неизвестная ошибка", message: "Упс! Кажется что-то пошло не по плану")
    }
    
    static func showInvalidAppUrl(on vc: UIViewController) {
        self.showBasicAlert(on: vc, title: "Невозможно открыть сервис", message: "Неверная ссылка")
    }
}
