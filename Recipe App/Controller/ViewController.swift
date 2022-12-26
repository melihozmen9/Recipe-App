//
//  ViewController.swift
//  Recipe App
//
//  Created by Kullanici on 25.12.2022.
//

import UIKit

class ViewController: UIViewController,UITextFieldDelegate,ModelManagerDelegate {
   @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var explanationLabel: UILabel!
    @IBOutlet weak var foodImage: UIImageView!
    var modelManager = ModelManager()
    var explanation = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        searchTextField.delegate = self
        modelManager.delegate = self
        
    }
    @IBAction func searchPressed(_ sender: Any) {
        searchTextField.endEditing(true)
        print(searchTextField.text!)
        
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.endEditing(true)
        return true
    }

    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            return true
        } else {
            textField.placeholder = "Type something here."
           return false
        }
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
       
        if let name = searchTextField.text {
            modelManager.getName(name: name)
        }
        
        searchTextField.text = ""
    }
    func getInfo(info: Model) {
        DispatchQueue.main.async {
            self.nameLabel.text = info.foodName
            self.explanationLabel.text = info.explanation
            self.foodImage.loadFrom(URLAddress: info.foodImage)
            self.explanation = info.explanation
            print(self.explanation)
        }
    }
    func didFailWithError(error: Error) {
        print(error)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "secondVC" {
            let vcDestination = segue.destination as! SecondViewController
            vcDestination.explanation = explanation
        }
    }
    @IBAction func ingredientsPressed(_ sender: UIButton) {
        self.performSegue(withIdentifier: "secondVC", sender: self)
    }
    
}
extension UIImageView {
    func loadFrom(URLAddress: String) {
        guard let url = URL(string: URLAddress) else {
            return
        }
        
        DispatchQueue.main.async { [weak self] in
            if let imageData = try? Data(contentsOf: url) {
                if let loadedImage = UIImage(data: imageData) {
                        self?.image = loadedImage
                }
            }
        }
    }
}
