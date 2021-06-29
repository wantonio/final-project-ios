//
//  RecipeEntity.swift
//  final-project-ios
//
//  Created by Walter Calderon on 28/6/21.
//

import Foundation

extension RecipeEntity {
    func assignValues(recipe: RecipePersisted) {
        self.id = Int32(recipe.id)
        self.title = recipe.title
        self.image = recipe.image
        self.note = recipe.note
        self.photo = recipe.photo
        self.updatedDate = Date()
    }
    
    func toStruct() -> RecipePersisted{
        return RecipePersisted(
            id: Int(self.id),
            title: self.title!,
            image: self.image!,
            note: self.note!,
            photo: self.photo,
            updatedDate: self.updatedDate!
        )
    }
}
