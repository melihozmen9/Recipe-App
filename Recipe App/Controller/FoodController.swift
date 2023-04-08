//
//  ViewController.swift
//  Recipe App
//
//  Created by Kullanici on 25.12.2022.
//

import UIKit
import SnapKit

class FoodController: UIViewController, UITextFieldDelegate, ModelManagerDelegate {
    
    private let searchTextField: UITextField = {
        let textField = UITextField()
        textField.round(cornerRadius: 10.0, maskToBound: true)
        textField.placeholder = "Are you hungry?"
        textField.backgroundColor = .white
        return textField
    }()
    
    private let searchButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        button.addTarget(self, action: #selector(searchPressed), for: .touchUpInside)
        return button
    }()
    
    private let foodImage: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "foodBackground"))
        imageView.round(cornerRadius: 10.0, maskToBound: true)
        return imageView
    }()
    
    private let subView: UIView = {
        let view = UIView()
        view.round(cornerRadius: 10.0, maskToBound: true)
        view.backgroundColor = .blue
        return view
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Name"
        label.round(cornerRadius: 10.0, maskToBound: true)
        label.backgroundColor = UIColor(red: 1.00, green: 0.92, blue: 0.65, alpha: 1.00)
        label.textAlignment = .center
        label.sizeToFit()
        return label
    }()
    
    private let ingredientsLabel: UILabel = {
        let label = UILabel()
        label.text = "Ingredients"
        label.round(cornerRadius: 10.0, maskToBound: true)
        label.backgroundColor = UIColor(red: 0.49, green: 1.00, blue: 0.96, alpha: 1.00)
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        label.sizeToFit()
        label.textAlignment = .center
        return label
    }()
    
    private let categoryButton: UIButton = {
        let button = UIButton()
        button.setTitle("Category", for: .normal)
        button.round(cornerRadius: 10.0, maskToBound: true)
        button.backgroundColor = UIColor(red: 0.51, green: 0.93, blue: 0.93, alpha: 1.00)
        button.addTarget(self, action: #selector(categoryPressed), for: .touchUpInside)
        return button
    }()
    
    private let instructionsButton: UIButton = {
        let button = UIButton()
        button.setTitle("Instructions", for: .normal)
        button.round(cornerRadius: 10.0, maskToBound: true)
        button.backgroundColor = UIColor(red: 1.00, green: 0.69, blue: 0.25, alpha: 0.50)
        button.addTarget(self, action: #selector(instructionsPressed), for: .touchUpInside)
        return button
    }()
    
    private let videoButton: UIButton = {
        let button = UIButton()
        button.round(cornerRadius: 10.0, maskToBound: true)
        button.setImage(UIImage(systemName: "video.circle.fill"), for: .normal)
        button.addTarget(self, action: #selector(videoPressed), for: .touchUpInside)
        button.tintColor = .red
        return button
    }()

    var segueAction = false
    var modelManager = ModelManager()
    var explanation = ""
    var segueName = ""
    var videoLink = ""
    var foodImageUrl = ""
    
    
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
        configure()
        searchTextField.delegate = self
        modelManager.delegate = self


        if segueAction == true {
            modelManager.segueName(name: segueName)
        }
    }
    
    func design() {
        title = "Food Details"
        navigationItem.leftBarButtonItem = backButton
        navigationItem.rightBarButtonItem = resourcesButton
        view.backgroundColor = UIColor(red: 1.00, green: 0.80, blue: 0.80, alpha: 1.00)
    }
    
    func configure() {
        design()
        
        view.addSubview(subView)
        view.addSubview(searchButton)
        view.addSubview(searchTextField)
        view.addSubview(foodImage)
        view.addSubview(ingredientsLabel)
        view.addSubview(instructionsButton)
        subView.addSubview(categoryButton)
        subView.addSubview(videoButton)
        subView.addSubview(nameLabel)
        
        
        searchTextField.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(view.frame.size.height * 0.02)
            make.left.equalTo(view).offset(view.frame.size.width * 0.1)
            make.height.equalTo(view.snp.height).multipliedBy(0.05)
        }
        searchButton.snp.makeConstraints { make in
            make.centerY.equalTo(searchTextField.snp.centerY)
            make.left.equalTo(searchTextField.snp.right).offset(view.frame.size.width * 0.02)
            make.right.equalTo(view).offset(-view.frame.size.width * 0.1)
            make.width.height.equalTo(view.snp.width).multipliedBy(0.1)
        }
        foodImage.snp.makeConstraints { make in
            make.top.equalTo(searchTextField.snp.bottom).offset(view.frame.size.height * 0.02)
            make.left.equalTo(view).offset(view.frame.size.width * 0.1)
            make.height.equalTo(view.snp.height).multipliedBy(0.3)
            make.right.equalTo(view).offset(-view.frame.size.width * 0.1)
        }
        subView.snp.makeConstraints { make in
            make.top.equalTo(foodImage.snp.bottom).offset(view.frame.size.height * 0.02)
            make.left.equalTo(view).offset(view.frame.size.width * 0.1)
            make.height.equalTo(view.snp.height).multipliedBy(0.1)
            make.right.equalTo(view).offset(-view.frame.size.width * 0.1)
        }
        ingredientsLabel.snp.makeConstraints { make in
            make.top.equalTo(subView.snp.bottom).offset(view.frame.size.height * 0.02)
            make.left.equalTo(view).offset(view.frame.size.width * 0.1)
            make.height.lessThanOrEqualTo(view.snp.height).multipliedBy(0.25)
            make.right.equalTo(view).offset(-view.frame.size.width * 0.1)
        }
        instructionsButton.snp.makeConstraints { make in
//            make.top.equalTo(ingredientsLabel.snp.bottom).offset(view.frame.size.height * 0.02)
            make.left.equalTo(view).offset(view.frame.size.width * 0.1)
            make.height.equalTo(view.snp.height).multipliedBy(0.05)
            make.right.equalTo(view).offset(-view.frame.size.width * 0.1)
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-view.frame.size.height * 0.02)

        }
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(subView.snp.top).offset(5)
            make.left.equalTo(subView.snp.left).offset(7)
            make.right.equalTo(subView.snp.right).offset(-7)
            //make.height.equalTo(subView.snp.height).multipliedBy(0.40)
        }
        categoryButton.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(5)
            make.left.equalTo(nameLabel)
            make.bottom.equalTo(subView.snp.bottom).offset(-5)
        }
        videoButton.snp.makeConstraints { make in
            make.centerY.equalTo(categoryButton)
            make.right.equalTo(nameLabel)
            make.left.equalTo(categoryButton.snp.right).offset(5)
            make.width.height.equalTo(subView.snp.width).multipliedBy(0.1)
        }
        
    }


    //MARK:- SearchFood
    @objc func searchPressed(_ sender: Any) {
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
            let ingreString = " \(info.meals[0].strMeasure1 ?? "")\(info.meals[0].strIngredient1 ?? "")\n \(info.meals[0].strMeasure2 ?? "")\(info.meals[0].strIngredient2 ?? "")\n \(info.meals[0].strMeasure3 ?? "") \(info.meals[0].strIngredient3 ?? "")\n \(info.meals[0].strMeasure4 ?? "") \(info.meals[0].strIngredient4 ?? "")\n \(info.meals[0].strMeasure5 ?? "") \(info.meals[0].strIngredient5 ?? "")\n \(info.meals[0].strMeasure6 ?? "") \(info.meals[0].strIngredient6 ?? "")\n \(info.meals[0].strMeasure7 ?? "") \(info.meals[0].strIngredient7 ?? "")\n \(info.meals[0].strMeasure8 ?? "") \(info.meals[0].strIngredient8 ?? "")\n \(info.meals[0].strMeasure9 ?? "") \(info.meals[0].strIngredient9 ?? "")\n \(info.meals[0].strMeasure10 ?? "") \(info.meals[0].strIngredient10 ?? "")\n \(info.meals[0].strMeasure11 ?? "") \(info.meals[0].strIngredient11 ?? "")\n \(info.meals[0].strMeasure12 ?? "") \(info.meals[0].strIngredient12 ?? "")\n \(info.meals[0].strMeasure13 ?? "") \(info.meals[0].strIngredient13 ?? "")\n \(info.meals[0].strMeasure14 ?? "") \(info.meals[0].strIngredient14 ?? "")\n \(info.meals[0].strMeasure15 ?? "") \(info.meals[0].strIngredient15 ?? "")\n \(info.meals[0].strMeasure16 ?? "") \(info.meals[0].strIngredient16 ?? "")\n \(info.meals[0].strMeasure17 ?? "") \(info.meals[0].strIngredient17 ?? "")\n \(info.meals[0].strMeasure18 ?? "") \(info.meals[0].strIngredient18 ?? "")\n \(info.meals[0].strMeasure19 ?? "") \(info.meals[0].strIngredient19 ?? "")\n \(info.meals[0].strMeasure20 ?? "") \(info.meals[0].strIngredient20 ?? "")"
               self.ingredientsLabel.text = ingreString.trimmingCharacters(in: .whitespacesAndNewlines)
            self.foodImageUrl = info.meals[0].strMealThumb
            self.foodImage.loadFrom(URLAddress: self.foodImageUrl)
           self.explanation = info.meals[0].strInstructions
            self.categoryButton.setTitle(info.meals[0].strCategory, for: .normal)
            self.videoLink = info.meals[0].strYoutube

        }
    }
    func didFailWithError(error: Error) {
        print(error)
    }


    
    @objc func instructionsPressed(_ sender: UIButton) {
        let instructionController = UINavigationController(rootViewController: InstructionController())
        instructionController.modalTransitionStyle = .crossDissolve
        instructionController.modalPresentationStyle = .fullScreen
        let instructionVC = instructionController.viewControllers.first as! InstructionController
        instructionVC.explanation = self.explanation
        self.present(instructionController, animated: true, completion: nil)
    }

    @objc func categoryPressed(_ sender: UIButton) {
        let subTableViewController = UINavigationController(rootViewController: SubCategoryViewController())
        subTableViewController.modalTransitionStyle = .crossDissolve
        subTableViewController.modalPresentationStyle = .fullScreen
        let subTableViewVC = subTableViewController.viewControllers.first as! SubCategoryViewController
        subTableViewVC.category = categoryButton.currentTitle!
        self.present(subTableViewController, animated: true, completion: nil)
    }
    @objc func videoPressed(_ sender: UIButton) {
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



