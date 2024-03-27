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
}

extension ServicesInformationInteractor: ServicesInformationInteractorInput {
    func fetchBody() {
        let jsonURLString = "https://publicstorage.hb.bizmrg.com/sirius/result.json"
        guard let url = URL(string: jsonURLString) else {
            output?.didFailFetchBody()
            return
        }
       
       URLSession.shared.dataTask(with: url) { [weak self] data, _, _ in
           guard let data = data else {
               self?.output?.didFailFetchBody()
               return
           }
           do {
               let apiResponse = try JSONDecoder().decode(ApiResponse.self, from: data)
               self?.output?.didFetchBody(services: apiResponse.body.services)
           } catch {
               self?.output?.didFailFetchBody()
           }
       }.resume()
   }
    
    func fetchImage(urlString: String) {
        guard let url = URL(string: urlString) else {
            output?.didFailFetchImage(for: urlString, error: NSError(domain: "Invalid URL", code: -1, userInfo: nil))
            return
        }
        
        URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            if let error = error {
                self?.output?.didFailFetchImage(for: urlString, error: error)
                return
            }
            guard let data = data, let image = UIImage(data: data) else {
                self?.output?.didFailFetchImage(for: urlString, error: NSError(domain: "Data or image invalid", code: -2, userInfo: nil))
                return
            }
            self?.output?.didFetchImage(image, for: urlString)
        }.resume()
    }
}
