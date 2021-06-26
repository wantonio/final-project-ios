//
//  RecipeInfo.swift
//  final-project-ios
//
//  Created by Walter Calderon on 23/6/21.
//

import Foundation

struct RecipeInfo: Codable {
    var id: Int
    var title: String
    var image: String
    var imageType: String
    var nutrition: Nutrition
    var summary: String?
    var diets: [String]?
    var analyzedInstructions: [Instructions]?
    var extendedIngredients: [Ingridient]?
}
