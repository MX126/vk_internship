//
//  ServicesInformationViewController.swift
//  vk_test
//
//  Created by Михаил on 26.03.2024.
//  
//

import UIKit
import PinLayout

final class ServicesInformationViewController: UIViewController {
    
    // MARK: - private properties
    
    private let output: ServicesInformationViewOutput
    private var services: [Service] = []
    
    private var tableView = UITableView()
    private let titleLabel = UILabel()
    
    // MARK: - Life cycle

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
        setup()
        output.didLoadView()
        
        view.addSubviews(titleLabel, tableView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        layout()
    }
    
    // MARK: - setup
    
    private func setup() {
        view.backgroundColor = .systemBackground
        
        tableView.register(ServiceTableViewCell.self, forCellReuseIdentifier: "ServiceCell")
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        
        tableView.dataSource = self
        tableView.delegate = self
        
        titleLabel.backgroundColor = .clear
    }
    
    // MARK: - layout
    
    private func layout() {
        titleLabel.pin
            .top(Constants.titleLabel.top)
            .hCenter()
            .marginTop(Constants.titleLabel.marginTop)
            .height(Constants.titleLabel.size.height)
            .width(Constants.titleLabel.size.width)
        
        tableView.pin
            .below(of: titleLabel)
            .marginTop(Constants.tableView.marginTop)
            .left(Constants.tableView.left)
            .right(Constants.tableView.right)
            .bottom(Constants.tableView.bottom)
    }
}

// MARK: - ServicesInformationViewInput

extension ServicesInformationViewController: ServicesInformationViewInput {
    func configure(with model: ServicesInformationViewModel) {
        titleLabel.attributedText = model.title
    }
    
    func showError() {
        print("error") // alert manager
    }
    
    func update(with services: [Service]) {
        DispatchQueue.main.async {
            self.services = services
            self.tableView.reloadData()
        }
    }
    
    func updateImage(_ image: UIImage?, for urlString: String) {
        guard let image = image else {
            return
        }
        if let index = services.firstIndex(where: { $0.iconURL == urlString }),
           let cell = tableView.cellForRow(at: IndexPath(row: index, section: 0)) as? ServiceTableViewCell {
            cell.iconImageView.image = image
        }
    }
}

// MARK: - tableView delegate

extension ServicesInformationViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constants.tableView.rowHeight
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let service = services[indexPath.row]
        output.didSelectService(service)
    }
}

// MARK: - tableView dataSource

extension ServicesInformationViewController: UITableViewDataSource {
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
        cell.iconImageView.image = nil
        
        output.loadImage(at: indexPath, urlString: service.iconURL)

        return cell
    }
}

// MARK: - Constants

private extension ServicesInformationViewController {
    struct Constants {
        struct titleLabel {
            static let top: CGFloat = 40
            static let marginTop: CGFloat = 12
            static let size: CGSize = CGSize(width: 100, height: 24)
        }
        
        struct tableView {
            static let marginTop: CGFloat = 12
            static let left: CGFloat = 0
            static let right: CGFloat = 0
            static let bottom: CGFloat = 0
            static let rowHeight: CGFloat = 100
        }
    }
}
