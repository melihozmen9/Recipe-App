//
//  ViewController.swift
//  Recipe App
//
//  Created by Kullanici on 25.12.2022.
//

import UIKit

class FoodController: UIViewController,UITextFieldDelegate,ModelManagerDelegate {
    @IBOutlet weak var subView: UIView!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ingredientsLabel: UILabel!
    @IBOutlet weak var foodImage: UIImageView!
    @IBOutlet weak var CategoryButtonLabel: UIButton!
    @IBOutlet weak var instructionsButton: UIButton!
    
    var segueAction = false
    var modelManager = ModelManager()
    var explanation = ""
    var segueName = ""
    var videoLink = ""
    var foodImageUrl = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchTextField.delegate = self
        modelManager.delegate = self
        view.backgroundColor = UIColor(red: 1.00, green: 0.80, blue: 0.80, alpha: 1.00)
        foodImage.round(cornerRadius: 10, maskToBound: true)
        nameLabel.round(cornerRadius: 10, maskToBound: true)
        nameLabel.backgroundColor = UIColor(red: 1.00, green: 0.92, blue: 0.65, alpha: 1.00)
        
        ingredientsLabel.round(cornerRadius: 10, maskToBound: true)
        ingredientsLabel.backgroundColor = UIColor(red: 0.49, green: 1.00, blue: 0.96, alpha: 1.00)
        CategoryButtonLabel.round(cornerRadius: 10, maskToBound: true)
        CategoryButtonLabel.backgroundColor = UIColor(red: 0.51, green: 0.93, blue: 0.93, alpha: 1.00)
        instructionsButton.round(cornerRadius: 10, maskToBound: true)
        instructionsButton.backgroundColor = UIColor(red: 1.00, green: 0.69, blue: 0.25, alpha: 0.50)
        
        if segueAction == true {
            modelManager.segueName(name: segueName)
        }
    }
    
    @IBAction func backButtonPressed(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true)
    }
    //MARK:- SearchFood
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
    //MARK:- get Data
    func getInfo(info: ModelData) {
        DispatchQueue.main.async {
            self.nameLabel.text = info.meals[0].strMeal
            self.ingredientsLabel.text = " \(info.meals[0].strMeasure1 ?? "")\(info.meals[0].strIngredient1 ?? "")\n \(info.meals[0].strMeasure2 ?? "")\(info.meals[0].strIngredient2 ?? "")\n \(info.meals[0].strMeasure3 ?? "") \(info.meals[0].strIngredient3 ?? "")\n \(info.meals[0].strMeasure4 ?? "") \(info.meals[0].strIngredient4 ?? "")\n \(info.meals[0].strMeasure5 ?? "") \(info.meals[0].strIngredient5 ?? "")\n \(info.meals[0].strMeasure6 ?? "") \(info.meals[0].strIngredient6 ?? "")\n \(info.meals[0].strMeasure7 ?? "") \(info.meals[0].strIngredient7 ?? "")\n \(info.meals[0].strMeasure8 ?? "") \(info.meals[0].strIngredient8 ?? "")\n \(info.meals[0].strMeasure9 ?? "") \(info.meals[0].strIngredient9 ?? "")\n \(info.meals[0].strMeasure10 ?? "") \(info.meals[0].strIngredient10 ?? "")\n \(info.meals[0].strMeasure11 ?? "") \(info.meals[0].strIngredient11 ?? "")\n \(info.meals[0].strMeasure12 ?? "") \(info.meals[0].strIngredient12 ?? "")\n \(info.meals[0].strMeasure13 ?? "") \(info.meals[0].strIngredient13 ?? "")\n \(info.meals[0].strMeasure14 ?? "") \(info.meals[0].strIngredient14 ?? "")\n \(info.meals[0].strMeasure15 ?? "") \(info.meals[0].strIngredient15 ?? "")\n \(info.meals[0].strMeasure16 ?? "") \(info.meals[0].strIngredient16 ?? "")\n \(info.meals[0].strMeasure17 ?? "") \(info.meals[0].strIngredient17 ?? "")\n \(info.meals[0].strMeasure18 ?? "") \(info.meals[0].strIngredient18 ?? "")\n \(info.meals[0].strMeasure19 ?? "") \(info.meals[0].strIngredient19 ?? "")\n \(info.meals[0].strMeasure20 ?? "") \(info.meals[0].strIngredient20 ?? "")"
            self.foodImageUrl = info.meals[0].strMealThumb
            self.foodImage.loadFrom(URLAddress: self.foodImageUrl)
           self.explanation = info.meals[0].strInstructions
            self.CategoryButtonLabel.setTitle(info.meals[0].strCategory, for: .normal)
            self.videoLink = info.meals[0].strYoutube
        
        }
    }
    func didFailWithError(error: Error) {
        print(error)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "secondVC" {
            let vcDestination = segue.destination as! InstructionController
            vcDestination.explanation = self.explanation
        }
        if segue.identifier == "GoToCategory" {
            let vcDestination = segue.destination as! SubTableViewController
            vcDestination.category = CategoryButtonLabel.currentTitle!
        }
      
        
    }
    @IBAction func instructionsPressed(_ sender: UIButton) {
        self.performSegue(withIdentifier: "secondVC", sender: self)
    }
    
    
    @IBAction func categoryPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "GoToCategory", sender: self)
    }
    @IBAction func videoPressed(_ sender: UIButton) {
        if let yourURL = URL(string: videoLink) {
       UIApplication.shared.open(yourURL, options: [:], completionHandler: nil)
    }
    }

  
    
    
}
//MARK:- ImageView Extension
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
extension UIView {
    func round (cornerRadius: CGFloat, maskToBound : Bool){
        self.layer.masksToBounds = maskToBound
        self.layer.cornerRadius = cornerRadius
        
    }
}

