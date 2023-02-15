//
//  CategoryViewController.swift
//  Recipe App
//
//  Created by Kullanici on 1.02.2023.
//

import UIKit
class CategoryViewController: UIViewController {
    var data = [MealData]()
   
    @IBOutlet weak var categoryTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 1.00, green: 0.80, blue: 0.80, alpha: 1.00)
        categoryTableView.backgroundColor = UIColor(red: 1.00, green: 0.80, blue: 0.80, alpha: 1.00)
        fetchData(URL: "https://www.themealdb.com/api/json/v1/1/categories.php") { result  in
            self.data = result.categories
            DispatchQueue.main.async {
                self.categoryTableView.reloadData()
            }
        }
    }
    
    @IBAction func backButtonPressed(_ sender: UIBarButtonItem) {
    
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
        cell.backgroundColor = UIColor(red: 0.94, green: 0.58, blue: 0.17, alpha: 0.30)
        
        return cell
    }
    
    
}
//MARK:- Delegate
extension CategoryViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let subUrl = "https://www.themealdb.com/api/json/v1/1/filter.php?c=\(data[indexPath.row].strCategory)"
        print(subUrl)
        // perform segue ile linki alt kategory table view'a gönder. oradaki onksiyonun url'ine bu suburl eklenecek ve o url calışacak. ardından buradaki işlemllerin aynısını yap. buraya cek veriyi.
        performSegue(withIdentifier: "GoToSub", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "GoToSub" {
            let destinationVC = segue.destination as! SubTableViewController
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
