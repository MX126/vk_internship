//
//  ServicesInformationInteractor.swift
//  vk_test
//
//  Created by Михаил on 26.03.2024.
//  
//

import UIKit

final class ServicesInformationInteractor {
    weak var output: ServicesInformationInteractorOutput?
    
    private func handleError(_ error: Error) -> String {
        return "Ошибка: \(error.localizedDescription)"
    }
    
    private func handleURLError(_ urlString: String) -> String {
        return "Неверный URL: \(urlString)"
    }
    
    private func handleDataError() -> String {
        return "Нет информации о полученных данных."
    }
}

extension ServicesInformationInteractor: ServicesInformationInteractorInput {
    func fetchBody() {
        let jsonURLString = "https://publicstorage.hb.bizmrg.com/sirius/result.json"
        guard let url = URL(string: jsonURLString) else {
            output?.didFailFetchBody(with: handleURLError(jsonURLString))
            return
        }
       
        URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            if let error = error {
                self?.output?.didFailFetchBody(with: self?.handleError(error) ?? "")
                return
            }
           
            guard let data = data else {
                self?.output?.didFailFetchBody(with: self?.handleDataError() ?? "")
                return
            }
           
            do {
                let apiResponse = try JSONDecoder().decode(ApiResponse.self, from: data)
                self?.output?.didFetchBody(services: apiResponse.body.services)
            } catch {
                self?.output?.didFailFetchBody(with: self?.handleError(error) ?? "")
            }
        }.resume()
    }
    
    func fetchImage(urlString: String) {
        guard let url = URL(string: urlString) else {
            output?.didFailFetchImage(with: handleURLError(urlString))
            return
        }
        
        URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            if let error = error {
                self?.output?.didFailFetchImage(with: self?.handleError(error) ?? "")
                return
            }
            guard let data = data, let image = UIImage(data: data) else {
                self?.output?.didFailFetchImage(with: self?.handleDataError() ?? "")
                return
            }
            self?.output?.didFetchImage(image, for: urlString)
        }.resume()
    }
}
