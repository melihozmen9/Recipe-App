//
//  MainViewController.swift
//  Recipe App
//
//  Created by Kullanici on 1.02.2023.
//

import UIKit
import CLTypingLabel
import SnapKit
class MainViewController: UIViewController {
        
    private let categoriesButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(red: 0.99, green: 0.26, blue: 0.48, alpha: 0.50)
        button.setTitle("Categories", for: .normal)
        button.round(cornerRadius: 10, maskToBound: true)
        button.addTarget(self, action: #selector(categoriesPressed), for: .touchUpInside)
        return button
    }()
    
    private let searchButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(red: 0.98, green: 0.50, blue: 0.32, alpha: 0.50)
        button.setTitle("Search", for: .normal)
        button.round(cornerRadius: 10, maskToBound: true)
        button.addTarget(self, action: #selector(searchPressed), for: .touchUpInside)
        return button
    }()

    private let titleLabel = CLTypingLabel()
    
    private var titleSituation = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    private func design() {
        navigationController?.navigationBar.barTintColor = UIColor.gray.withAlphaComponent(0.40)
        view.backgroundColor = UIColor(red: 1.00, green: 0.80, blue: 0.80, alpha: 1.00)
        titleLabel.textColor = .systemPink
        let alertController = UIAlertController(title: "Warning", message: "Recipes may contain allergens. The responsibility lies with the user.", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            UIView.animate(withDuration: 0.5, animations: {
                self.titleLabel.text = "🥙MenuMagic🥙"
                self.titleLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 30)
                self.titleLabel.textColor = .systemRed
            })
        }
        alertController.addAction(okAction)
        present(alertController, animated: true)
    }
    
    private func configure() {
        design()
        view.addSubview(categoriesButton)
        view.addSubview(titleLabel)
        view.addSubview(searchButton)
        
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalTo(view.snp.centerY)
            make.centerX.equalTo(view.snp.centerX)
        }
        
        searchButton.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(view.frame.size.height * 0.1)
            make.left.equalTo(view).offset(view.frame.size.width * 0.3)
            make.right.equalTo(view).offset(-view.frame.size.width * 0.3)
        }
        
        categoriesButton.snp.makeConstraints { make in
            make.top.equalTo(searchButton.snp.bottom).offset(view.frame.size.height * 0.05)
            make.left.equalTo(view).offset(view.frame.size.width * 0.3)
            make.right.equalTo(view).offset(-view.frame.size.width * 0.3)
        }
        
    }
    
    @objc func searchPressed(_ sender: UIButton) {
        let foodController = UINavigationController(rootViewController: FoodController())
        foodController.modalTransitionStyle = .crossDissolve
        foodController.modalPresentationStyle = .fullScreen
        self.present(foodController, animated: true, completion: nil)
    }
    
    @objc func categoriesPressed(_ sender: UIButton) {
        let categoryViewController = UINavigationController(rootViewController: CategoryViewController())
        categoryViewController.modalTransitionStyle = .crossDissolve
        categoryViewController.modalPresentationStyle = .fullScreen
        self.present(categoryViewController, animated: true, completion: nil)
        
    }
}
//let accountViewController = UINavigationController(rootViewController: AccountViewController())
//accountViewController.modalPresentationStyle = .fullScreen
//accountViewController.modalTransitionStyle = .crossDissolve
//self.present(accountViewController, animated: true, completion: nil)
