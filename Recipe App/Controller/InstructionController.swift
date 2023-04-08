//
//  SecondViewController.swift
//  Recipe App
//
//  Created by Kullanici on 25.12.2022.
//

import UIKit
import SnapKit

class InstructionController: UIViewController {
    var explanation : String?
    
    private let ingredientsLabel: UILabel = {
        let label = UILabel()
        label.round(cornerRadius: 10, maskToBound: true)
        label.backgroundColor = .systemYellow
        label.numberOfLines = 0
        label.sizeToFit()
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
    
    private func createResourcesButton() -> UIBarButtonItem {
        let button = UIBarButtonItem(title: "Info", style: .plain, target: self, action: #selector(resourcesTapped))
        return button
    }
  
    lazy var resourcesButton: UIBarButtonItem = {
        return createResourcesButton()
    }()
    
    @objc private func resourcesTapped() {
        let resourcesViewController = UINavigationController(rootViewController: ResourcesViewController())
        resourcesViewController.modalTransitionStyle = .crossDissolve
        resourcesViewController.modalPresentationStyle = .fullScreen
        self.present(resourcesViewController, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ingredientsLabel.text = explanation
        ingredientsLabel.round(cornerRadius: 10, maskToBound: true)
      configure()
    }
    

    
    func design() {
        title = "Ingredients"
        navigationItem.leftBarButtonItem = backButton
        navigationItem.rightBarButtonItem = resourcesButton
        view.backgroundColor = .white
    }
    
    func configure() {
        design()
        view.addSubview(ingredientsLabel)
        
        ingredientsLabel.snp.makeConstraints { make in
            make.top.left.right.equalTo(view.safeAreaLayoutGuide).inset(10)
        }
    }

}
