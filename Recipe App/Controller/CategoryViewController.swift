//
//  CategoryViewController.swift
//  Recipe App
//
//  Created by Kullanici on 1.02.2023.
//

import UIKit
class CategoryViewController: UIViewController {
    var data = [MealData]()
     
    private let categoryTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .white
        tableView.rowHeight = 50
        tableView.register(CategoryTableViewCell.self, forCellReuseIdentifier: "CategoryCell")
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        fetchData(URL: "https://www.themealdb.com/api/json/v1/1/categories.php") { result  in
            self.data = result.categories
            DispatchQueue.main.async {
                self.categoryTableView.reloadData()
            }
        }
    }
    
    func design() {
        categoryTableView.delegate = self
        categoryTableView.dataSource = self
        view.backgroundColor = UIColor(red: 1.00, green: 0.80, blue: 0.80, alpha: 1.00)
        title = "Categories"
        navigationItem.leftBarButtonItem = backButton
        navigationItem.rightBarButtonItem = resourcesButton
    }
    
    func configure() {
        design()
        view.addSubview(categoryTableView)
        
        categoryTableView.snp.makeConstraints { make in
            make.top.left.right.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
    }
    

    func fetchData(URL url:String, completion: @escaping (CategoryModel)-> Void){
        let url = URL(string: url)
        let session = URLSession.shared
        let dataTask = session.dataTask(with: url!) { data, response, error in
            do {
            let parsingData = try JSONDecoder().decode(CategoryModel.self, from: data!)
                completion(parsingData)

            } catch {
                print("parsing Error")
            }
        }
        dataTask.resume()
    }
   
}
//MARK:- DataSource
extension CategoryViewController : UITableViewDataSource {
   
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {


        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for:indexPath) as! CategoryTableViewCell
        cell.categoryLabel.text = data[indexPath.row].strCategory
        cell.categoryImage.downloaded(from: data[indexPath.row].strCategoryThumb, contentMode: .scaleToFill)
        cell.backgroundColor = UIColor(red: 0.15, green: 0.80, blue: 0.97, alpha: 1.00)
        
        return cell
    }
    
    
}
//MARK:- Delegate
extension CategoryViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let subUrl = "https://www.themealdb.com/api/json/v1/1/filter.php?c=\(data[indexPath.row].strCategory)"
        print(subUrl)
        let subTableViewController = UINavigationController(rootViewController: SubCategoryViewController())
        subTableViewController.modalTransitionStyle = .crossDissolve
        subTableViewController.modalPresentationStyle = .fullScreen
        let subTableViewVC = subTableViewController.viewControllers.first as! SubCategoryViewController
        subTableViewVC.category = data[indexPath.row].strCategory
        self.present(subTableViewController, animated: true, completion: nil)
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "GoToSub" {
            let destinationVC = segue.destination as! SubCategoryViewController
            if let indexPath = categoryTableView.indexPathForSelectedRow {
            destinationVC.category = data[indexPath.row].strCategory
            }
        }
    }
}


//MARK:- ImageExtension
extension UIImageView {
    func downloaded(from url: URL, contentMode mode: ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }
    func downloaded(from link: String, contentMode mode: ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}
