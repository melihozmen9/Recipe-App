//
//  SubCategoryModel.swift
//  Recipe App
//
//  Created by Kullanici on 1.02.2023.
//

import Foundation
struct SubCategoryModel : Codable{
    let meals : [SubMealData]
}
struct SubMealData : Codable{
    let strMeal : String
    let strMealThumb : String
    let idMeal : String
}
