//
//  Step.swift
//  final-project-ios
//
//  Created by Walter Calderon on 23/6/21.
//

import Foundation

struct Step: Codable {
    var number: Int
    var step: String
    var equipment: [Equipment]
}
