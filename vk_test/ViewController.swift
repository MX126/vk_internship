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

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    func setupTableView() {
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
            guard let data = data else {
                print(error ?? "Unknown error")
                return
            }
            do {
                let apiResponse = try JSONDecoder().decode(ApiResponse.self, from: data)
                DispatchQueue.main.async {
                    self?.services = apiResponse.body.services
                    self?.tableView.reloadData()
                }
            } catch {
                print(error)
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

        let service = services[indexPath.row]
        cell.nameLabel.text = service.name
        cell.descriptionLabel.text = service.description

        if let imageURL = URL(string: service.iconURL) {
            URLSession.shared.dataTask(with: imageURL) { data, _, error in
                if let error = error {
                    print("Error downloading image: \(error)")
                    return
                }
                if let data = data, let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        if tableView.indexPath(for: cell) == indexPath {
                            cell.iconImageView.image = image
                        }
                    }
                } else {
                    print("Invalid image data")
                }
            }.resume()
        } else {
            print("Invalid image URL")
        }
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            tableView.deselectRow(at: indexPath, animated: true)
        
            let service = services[indexPath.row]
        
            guard let url = URL(string: service.link) else {
                print("Invalid website URL")
                return
            }
            
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                print("Cannot open URL")
            }
        }
        
        func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
            guard let cell = tableView.cellForRow(at: indexPath) as? ServiceTableViewCell else {
                return
            }
            cell.setHighlighted(true, animated: true)
        }
        
        func tableView(_ tableView: UITableView, didUnhighlightRowAt indexPath: IndexPath) {
            guard let cell = tableView.cellForRow(at: indexPath) as? ServiceTableViewCell else {
                return
            }
            cell.setHighlighted(false, animated: true)
        }
}
