//
//  ResourcesViewController.swift
//  Recipe App
//
//  Created by Kullanici on 7.04.2023.
//

import UIKit
import SnapKit

class ResourcesViewController: UIViewController {

    private let resourcesLabel: UILabel = {
        let label = UILabel()
        label.text = "The recipes provided in this application may contain allergens. Responsibility lies with the user.\n https://www.themealdb.com/api.php"
        label.numberOfLines = 0
        label.round(cornerRadius: 10, maskToBound: true)
        label.textAlignment = .center
        label.backgroundColor = .white
        return label
    }()
    
    private func createBackButton() -> UIBarButtonItem {
        let button = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(backButtonTapped))
        return button
    }
    
    lazy var backButton: UIBarButtonItem = {
        return createBackButton()
    }()
    
    @objc private func backButtonTapped() {
     dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    private func design() {
        view.backgroundColor = UIColor(red: 0.97, green: 0.94, blue: 0.73, alpha: 1.00)
        title = "Resources"
        navigationItem.leftBarButtonItem = backButton
    }

    private func configure() {
        design()
        view.addSubview(resourcesLabel)
        resourcesLabel.snp.makeConstraints { make in
            make.top.left.right.equalTo(view.safeAreaLayoutGuide).inset(10)
        }
    }
}
