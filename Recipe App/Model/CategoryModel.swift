//
//  CategoryModel.swift
//  Recipe App
//
//  Created by Kullanici on 1.02.2023.
//

import Foundation
struct CategoryModel : Codable {
    let categories : [MealData]
}
struct MealData : Codable {
    let strCategory : String
    let strCategoryThumb : String
}
