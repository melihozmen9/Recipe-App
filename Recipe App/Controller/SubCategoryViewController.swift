//
//  SubCategoryViewController.swift
//  Recipe App
//
//  Created by Kullanici on 7.04.2023.
//

import UIKit
import SnapKit

class SubCategoryViewController: UIViewController {
    
     
    private let subFoodTableView: UITableView = {
           let tableView = UITableView()
           tableView.register(SubTableViewCell.self, forCellReuseIdentifier: "SubCategoryCell")
           return tableView
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
    
        var category : String = ""
        var subData = [SubMealData]()
    
        override func viewDidLoad() {
            super.viewDidLoad()
            view.backgroundColor = UIColor(red: 1.00, green: 0.80, blue: 0.80, alpha: 1.00)
            subFoodTableView.backgroundColor = UIColor(red: 1.00, green: 0.80, blue: 0.80, alpha: 1.00)
            fetchSubData(URL: "https://www.themealdb.com/api/json/v1/1/filter.php?c=\(category)") { result in
                self.subData = result.meals
                DispatchQueue.main.async {
                    self.subFoodTableView.reloadData()
                }
            }
            configure()
        }
    
        func design() {
            title = "SubCategory"
            subFoodTableView.register(SubTableViewCell.self, forCellReuseIdentifier: "SubCategoryCell")
            subFoodTableView.dataSource = self
            subFoodTableView.delegate = self
            navigationItem.leftBarButtonItem = backButton
            navigationItem.rightBarButtonItem = resourcesButton
        }
    
        func configure() {
            design()
            view.addSubview(subFoodTableView)
    
            subFoodTableView.snp.makeConstraints { make in
                make.top.left.right.bottom.equalTo(view.safeAreaLayoutGuide)
            }
        }
    }
    

    func fetchSubData(URL url:String, completion:@escaping (SubCategoryModel) -> Void){
        let url = URL(string: url)
        let session = URLSession.shared
        let dataTask = session.dataTask(with: url!) { data, response, error in
            do{
                let parsingData = try JSONDecoder().decode(SubCategoryModel.self, from: data!)
                completion(parsingData)
            } catch {
                print("parsingError")
            }
        }
        dataTask.resume()
    }
   

//MARK:- DataSource
extension SubCategoryViewController : UITableViewDataSource {
   
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return subData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SubCategoryCell", for: indexPath) as! SubTableViewCell
        cell.subCategoryLabel.text = subData[indexPath.row].strMeal
        cell.subCategoryImage.downloaded(from: subData[indexPath.row].strMealThumb, contentMode: .scaleToFill)
        cell.backgroundColor = UIColor(red: 0.94, green: 0.58, blue: 0.17, alpha: 0.30)
        return cell
    }

}
//MARK:- Delegate
extension SubCategoryViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let foodController = UINavigationController(rootViewController: FoodController())
        foodController.modalTransitionStyle = .crossDissolve
        foodController.modalPresentationStyle = .fullScreen
        let foodControllerVC = foodController.viewControllers.first as! FoodController
        if let indexPath = subFoodTableView.indexPathForSelectedRow {
            
            if subData[indexPath.row].strMeal.contains(" "){
                let replaced = subData[indexPath.row].strMeal.replacingOccurrences(of: " ", with: "_")
                foodControllerVC.segueName = replaced
            }else{
                foodControllerVC.segueName = subData[indexPath.row].strMeal
            }
            foodControllerVC.segueAction = true
        }
        self.present(foodController, animated: true, completion: nil)
    }
}

