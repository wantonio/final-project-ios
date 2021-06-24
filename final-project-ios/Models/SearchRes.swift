//
//  SearchRes.swift
//  final-project-ios
//
//  Created by Walter Calderon on 23/6/21.
//

import Foundation

struct SearchRes: Codable {
    var results: [RecipeInfo]
    var offset: Int
    var number: Int
    var totalResults: Int
}
