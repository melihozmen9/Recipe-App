//
//  MainViewController.swift
//  Recipe App
//
//  Created by Kullanici on 1.02.2023.
//

import UIKit
import CLTypingLabel
class MainViewController: UIViewController {

    @IBOutlet weak var categoriesButton: UIButton!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var titleLabel: CLTypingLabel!
    var titleSituation = true
    override func viewDidLoad() {
        super.viewDidLoad()
        if titleSituation == true {
            titleLabel.text = "🥙Recipe App🥙"
            titleSituation = false
        }
        navigationController?.navigationBar.barTintColor = UIColor.gray.withAlphaComponent(0.40)
        view.backgroundColor = UIColor(red: 1.00, green: 0.80, blue: 0.80, alpha: 1.00)
        categoriesButton.round(cornerRadius: 10, maskToBound: true)
        categoriesButton.backgroundColor = UIColor(red: 0.99, green: 0.26, blue: 0.48, alpha: 0.50)
        searchButton.round(cornerRadius: 10, maskToBound: true)
        searchButton.backgroundColor = UIColor(red: 0.98, green: 0.50, blue: 0.32, alpha: 0.50)
    }
    
    @IBAction func searchPressed(_ sender: UIButton) {
    }
    
    @IBAction func categoriesPressed(_ sender: UIButton) {
    }
    
}
