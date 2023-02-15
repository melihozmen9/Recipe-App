//
//  SubTableViewController.swift
//  Recipe App
//
//  Created by Kullanici on 1.02.2023.
//

import UIKit

class SubTableViewController: UITableViewController {

    @IBOutlet var subFoodTableView: UITableView!
    
    var category : String = ""
    var subData = [SubMealData]()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 1.00, green: 0.80, blue: 0.80, alpha: 1.00)
        subFoodTableView.backgroundColor = UIColor(red: 1.00, green: 0.80, blue: 0.80, alpha: 1.00)
        fetchSubData(URL: "https://www.themealdb.com/api/json/v1/1/filter.php?c=\(category)") { result in
            self.subData = result.meals
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    @IBAction func backButtonPressed(_ sender: UIBarButtonItem) {
        
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

    // MARK: - Table view data source

 

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return subData.count
    }

   

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SubCategoryCell", for: indexPath) as! SubTableViewCell
        cell.subCategoryLabel.text = subData[indexPath.row].strMeal
        cell.subCategoryImage.downloaded(from: subData[indexPath.row].strMealThumb, contentMode: .scaleToFill)
        cell.backgroundColor = UIColor(red: 0.94, green: 0.58, blue: 0.17, alpha: 0.30)
        return cell
    }
//MARK:- TableViewDelegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "GoToDetail", sender: self)
       
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "GoToDetail" {
            let destinationVC = segue.destination as! FoodController
            if let indexPath = tableView.indexPathForSelectedRow {
                if subData[indexPath.row].strMeal.contains(" "){
                    let replaced = subData[indexPath.row].strMeal.replacingOccurrences(of: " ", with: "_")
                    destinationVC.segueName = replaced
                   }else{
                    destinationVC.segueName = subData[indexPath.row].strMeal
                   }
               
            destinationVC.segueAction = true
        }
        }
    }
}
