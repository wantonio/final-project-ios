//
//  NoteListDelegate.swift
//  final-project-ios
//
//  Created by Walter Calderon on 28/6/21.
//

import Foundation

protocol RecipeNotedListDelegate {
    func addRecipeNoted(recipe: RecipeEntity)
    func updateRecipeNoted(recipe: RecipeEntity)
    func removeRecipeNoted()
}
