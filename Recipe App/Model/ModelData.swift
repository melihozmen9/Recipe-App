//
//  ModelData.swift
//  Recipe App
//
//  Created by Kullanici on 25.12.2022.
//

import Foundation
import UIKit
struct ModelData:Codable {
    var meals : [meals]
}
struct meals : Codable {
    var strMeal : String
    var strInstructions : String
    var strMealThumb : String
}
