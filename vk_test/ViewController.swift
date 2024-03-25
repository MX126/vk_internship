//
//  ViewController.swift
//  vk_test
//
//  Created by Михаил on 25.03.2024.
//

import UIKit

class ViewController: UIViewController {
    var tableView = UITableView()
    var services: [Service] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        loadServicesData()
        view.backgroundColor = .systemMint
    }
    
    func setupTableView() {
        tableView = UITableView(frame: self.view.bounds, style: .plain)
        tableView.register(ServiceTableViewCell.self, forCellReuseIdentifier: "ServiceCell")
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        view.addSubview(tableView)
        
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func loadServicesData() {
        let jsonURLString = "https://publicstorage.hb.bizmrg.com/sirius/result.json"
        guard let url = URL(string: jsonURLString) else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            if let data = data {
                do {
                    let apiResponse = try JSONDecoder().decode(ApiResponse.self, from: data)
                    self?.services = apiResponse.body.services
                    DispatchQueue.main.async {
                        self?.tableView.reloadData()
                    }
                } catch {
                    print(error)
                }
            }
        }.resume()
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return services.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ServiceCell", for: indexPath) as? ServiceTableViewCell else {
            fatalError("The dequeued cell is not an instance of ServiceTableViewCell.")
        }
        
        guard let image = UIImage(named: "temp") else {
            fatalError("can not load image")
        }
        
        let service = services[indexPath.row]
        if let imageURL = URL(string: service.iconURL) {
                URLSession.shared.dataTask(with: imageURL) { data, _, error in
                    if let error = error {
                        print("Error downloading image: \(error)")
                        return
                    }
                    
                    if let data = data, let image = UIImage(data: data) {
                        DispatchQueue.main.async {
                            cell.configure(with: service.name, and: service.description, and: image)
                        }
                    } else {
                        print("Invalid image data")
                    }
                }.resume()
            } else {
                print("Invalid image URL")
            }
        
        cell.configure(with: "dddd", and: "Самые популярные аоаоаоа аоаоао аоаооа вв", and: image)
       
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
