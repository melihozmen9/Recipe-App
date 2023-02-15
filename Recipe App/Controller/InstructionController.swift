//
//  SecondViewController.swift
//  Recipe App
//
//  Created by Kullanici on 25.12.2022.
//

import UIKit

class InstructionController: UIViewController {
    var explanation : String?
    @IBOutlet weak var ingredientsLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ingredientsLabel.text = explanation
        ingredientsLabel.round(cornerRadius: 10, maskToBound: true)
      
    }
    
    @IBAction func backButtonPressed(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true)
    }
    
    

}
