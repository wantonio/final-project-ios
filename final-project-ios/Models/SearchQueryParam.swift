//
//  SearchQueryParam.swift
//  final-project-ios
//
//  Created by Walter Calderon on 23/6/21.
//

import Foundation

struct SearchQueryParam: Codable {
    var query: String?
    var sort: String?
    var number: Int
    var minFat: Int?
    var maxFat: Int?
    var minCarbs: Int?
    var maxCarbs: Int?
    var minProtein: Int?
    var maxProtein: Int?
    var minCalories: Int?
    var maxCalories: Int?
    
    var dictonaryDefault: [String: Any] {
       let params = ["minFat", "minCarbs", "minProtein", "minCalories"]
        let queryParams = self.dictionary
        var newDictioney = [String: Any]().merging(queryParams) {dictionaryOne, _ in dictionaryOne}
        
        params.forEach{
            value in
            if let _ = queryParams[value] {}
            else {
                newDictioney[value] = 0
           }
        }
        
        return newDictioney
    }
}
