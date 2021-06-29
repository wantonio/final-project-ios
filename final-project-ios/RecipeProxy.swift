//
//  Anota.swift
//  final-project-ios
//
//  Created by Admin on 26/6/21.
//

import Foundation
import CoreData

class RecipeProxy {
    init(){
}
    static func saveRecipe(recipe: RecipePersisted, delegate: AppDelegate) -> RecipeEntity?{
        let manageContext = delegate.persistentContainer.viewContext
        let newRecipe = RecipeEntity(context: manageContext)
        
        newRecipe.assignValues(recipe: recipe)

        do {
            try manageContext.save()
            return newRecipe
        }catch let error as NSError {
            print(error)
        }

        return nil
    }
    
    static func updateRecipe(updatedRecipe: RecipePersisted, delegate: AppDelegate) -> RecipeEntity?{
        guard let recipe = getRecipe(id: updatedRecipe.id, delegate: delegate) else {
            return nil
        }
        
        recipe.assignValues(recipe: updatedRecipe)
        
        let manageContext = delegate.persistentContainer.viewContext

        do {
            try manageContext.save()
            return recipe
        }catch let error as NSError {
            print(error)
        }

        return nil
    }
    
    static func deleteRecipe(id: Int, delegate: AppDelegate) -> Bool {
        guard let recipe = getRecipe(id: id, delegate: delegate) else {
            return false
        }
        
        let manageContext = delegate.persistentContainer.viewContext
        manageContext.delete(recipe)
        
        do {
            try manageContext.save()
            return true
        }catch let error as NSError {
            print(error)
        }

        return false
    }
    
    static func getRecipe(id: Int, delegate: AppDelegate) -> RecipeEntity? {
        let managedContext = delegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "RecipeEntity")
        fetchRequest.predicate = NSPredicate(format: "id = %d", id)
        
        do {
            let recipes = try managedContext.fetch(fetchRequest) as! [RecipeEntity]
            
            return recipes.count > 0 ? recipes[0] : nil
            
        } catch let error as NSError {
            print(error)
        }
        
        return nil
    }
    
    static func getAlltRecipes(delegate: AppDelegate) -> [RecipeEntity]? {
        let managedContext = delegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "RecipeEntity")
        let updatedDateSort = NSSortDescriptor(key: "updatedDate", ascending: false)
        
        fetchRequest.sortDescriptors = [updatedDateSort]
        
        do {
            let recipes = try managedContext.fetch(fetchRequest) as! [RecipeEntity]
            return recipes
            
        } catch let error as NSError {
            print(error)
        }
        
        return nil
    }
    
}
