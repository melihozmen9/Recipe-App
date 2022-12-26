//
//  ModelManager.swift
//  Recipe App
//
//  Created by Kullanici on 25.12.2022.
//

import Foundation
import UIKit
protocol ModelManagerDelegate {
    func getInfo(info:Model)
    func didFailWithError(error : Error)
}
struct ModelManager {
    var delegate : ModelManagerDelegate?
    var website = "https://www.themealdb.com/api/json/v1/1/search.php?s="
   
    func getName(name:String) {
       let urlString = "\(website)\(name)"
        print(urlString)
        performRequest(urlString: urlString)
    }
    func performRequest(urlString: String){
        if let url = URL(string: urlString){
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    delegate?.didFailWithError(error: error!)
                    return
                }
                if let safeData = data {
                    if let information = parseJSON(info: safeData){
                        delegate?.getInfo(info: information)
                    }
                }
            }
            task.resume()
        }
    }
    func parseJSON(info:Data) -> Model?{
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(ModelData.self, from: info)
            let foodName = decodedData.meals[0].strMeal
            let explanation = decodedData.meals[0].strInstructions
            let foodImage = decodedData.meals[0].strMealThumb
            let information = Model(foodName: foodName,explanation: explanation,foodImage: foodImage)
            return information
        } catch  {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
}
