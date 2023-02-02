//
//  ModelManager.swift
//  Recipe App
//
//  Created by Kullanici on 25.12.2022.
//

import Foundation
import UIKit
protocol ModelManagerDelegate {
    func getInfo(info:ModelData)
    func didFailWithError(error : Error)
}
struct ModelManager {
    var delegate : ModelManagerDelegate?
    var website = "https://www.themealdb.com/api/json/v1/1/search.php?s="
    
   
    func getName(name:String) {
       let urlString = "\(website)\(name)"
        print(urlString)
        //performRequest(urlString: urlString)
        fetchDetail(URL: urlString) { result in
            DispatchQueue.main.async {
                delegate?.getInfo(info: result)
            }
            
        }
    }
    func segueName(name:String){
        let urlString = "\(website)\(name)"
         print(urlString)
        // performRequest(urlString: urlString)
        fetchDetail(URL: urlString) { result in
            DispatchQueue.main.async {
                delegate?.getInfo(info: result)
            }
        }
    }
    
    func fetchDetail(URL url :String,completion:@escaping(ModelData)->Void){
        let url = URL(string: url)
        let session = URLSession.shared
        let dataTask = session.dataTask(with: url!) { data, response, error in
            do {
                let parsingData = try JSONDecoder().decode(ModelData.self, from: data!)
                completion(parsingData)
            } catch {
                print("Error :\(error)")
            }
        }
        dataTask.resume()
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
//    func performRequest(urlString: String){
//        if let url = URL(string: urlString){
//            let session = URLSession(configuration: .default)
//            let task = session.dataTask(with: url) { data, response, error in
//                if error != nil {
//                    delegate?.didFailWithError(error: error!)
//                    return
//                }
//                if let safeData = data {
//                    if let information = parseJSON(info: safeData){
//                        delegate?.getInfo(info: information)
//                    }
//                }
//            }
//            task.resume()
//        }
//    }
//    func parseJSON(info:Data) -> Model?{
//        let decoder = JSONDecoder()
//        do {
//            let decodedData = try decoder.decode(ModelData.self, from: info)
//            let foodName = decodedData.meals[0].strMeal
//            let explanation = decodedData.meals[0].strInstructions
//            let foodImage = decodedData.meals[0].strMealThumb
//            let ingredients1 = decodedData.meals[0].strIngredient1
//            let ingredients2 = decodedData.meals[0].strIngredient2
//            let ingredients3 = decodedData.meals[0].strIngredient3
//            let ingredients4 = decodedData.meals[0].strIngredient4
//            let ingredients5 = decodedData.meals[0].strIngredient5
//            let ingredients6 = decodedData.meals[0].strIngredient6
//            let ingredients7 = decodedData.meals[0].strIngredient7
//            let ingredients8 = decodedData.meals[0].strIngredient8
//        
//            
////            for i in 0...5 {
////                let ingredientsArray : [String] = decodedData.meals.
////            }
////            let ingredients9 = decodedData.meals[0].strIngredient9
////            let ingredients10 = decodedData.meals[0].strIngredient10
////            let ingredients11 = decodedData.meals[0].strIngredient11
////            let ingredients12 = decodedData.meals[0].strIngredient12
////            let ingredients13 = decodedData.meals[0].strIngredient13
////            let ingredients14 = decodedData.meals[0].strIngredient14
////            let ingredients15 = decodedData.meals[0].strIngredient15
////            let measure1 = decodedData.meals[0].strMeasure1
////            let measure2 = decodedData.meals[0].strMeasure2
////            let measure3 = decodedData.meals[0].strMeasure3
////            let measure4 = decodedData.meals[0].strMeasure4
////            let measure5 = decodedData.meals[0].strMeasure5
////            let measure6 = decodedData.meals[0].strMeasure6
////            let measure7 = decodedData.meals[0].strMeasure7
////            let measure8 = decodedData.meals[0].strMeasure8
////            let measure9 = decodedData.meals[0].strMeasure9
////            let measure10 = decodedData.meals[0].strMeasure10
////            let measure11 = decodedData.meals[0].strMeasure11
////            let measure12 = decodedData.meals[0].strMeasure12
////            let measure13 = decodedData.meals[0].strMeasure13
////            let measure14 = decodedData.meals[0].strMeasure14
////            let measure15 = decodedData.meals[0].strMeasure15
//       
//            let information = Model(foodName: foodName, explanation: explanation, foodImage: foodImage, ingredients1: ingredients1, ingredients2: ingredients2, ingredients3: ingredients3, ingredients4: ingredients4, ingredients5: ingredients5, ingredients6: ingredients6, ingredients7: ingredients7,ingredients8: ingredients8)
//            return information
//        } catch  {
//            delegate?.didFailWithError(error: error)
//            return nil
//        }
//    }
}
