//
//  ViewController.swift
//  vk_test
//
//  Created by Михаил on 25.03.2024.
//

import UIKit

class ViewController: UIViewController {
    var tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        view.backgroundColor = .systemMint
    }
    
    func setupTableView() {
        tableView = UITableView(frame: self.view.bounds, style: .plain)
        tableView.register(ServiceTableViewCell.self, forCellReuseIdentifier: "ServiceCell")
        tableView.separatorStyle = .none
        view.addSubview(tableView)
        
        tableView.dataSource = self
        tableView.delegate = self
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ServiceCell", for: indexPath) as? ServiceTableViewCell else {
            fatalError("The dequeued cell is not an instance of ServiceTableViewCell.")
        }
        
        guard let image = UIImage(named: "temp") else {
            fatalError("can not load image")
        }
        
        cell.configure(with: "dddd", and: "Самые популярные аоаоаоа аоаоао аоаооа вв", and: image)
       
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
}
