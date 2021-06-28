//
//  Anota.swift
//  final-project-ios
//
//  Created by Admin on 26/6/21.
//

import Foundation
import CoreData

class NoteProxy {
    init(){
}
    
    static func saveNote(anotacion:String, delegate: AppDelegate) -> NSManagedObject?{
        
       let manageContext = delegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Anotaciones", in: manageContext)!
        let user = NSManagedObject(entity: entity, insertInto: manageContext)
        user.setValue(anotacion, forKey: "anotacion")
        do {
            try manageContext.save()
            return user
        }catch let error as NSError {
            print(error)
        }
        
        return nil
    }
    
    static func getNotes(delegate: AppDelegate) -> [NSManagedObject]? {
        let managedContext = delegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Anotaciones")
        do {
            let users:[NSManagedObject] = try managedContext.fetch(fetchRequest)
            return users
        } catch let error as NSError {
            print(error)
        }
        
        return nil
    }
    
    
    
    
    static func saveImage(image:String, delegate: AppDelegate) -> NSManagedObject?{
        
       let manageContext = delegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Anotaciones", in: manageContext)!
        let user = NSManagedObject(entity: entity, insertInto: manageContext)
        user.setValue(image, forKey: "image")
        do {
            try manageContext.save()
            return user
        }catch let error as NSError {
            print(error)
        }
        
        return nil
    }
    
    static func getImage(delegate: AppDelegate) -> [NSManagedObject]? {
        let managedContext = delegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Anotacion")
        do {
            let users:[NSManagedObject] = try managedContext.fetch(fetchRequest)
            return users
        } catch let error as NSError {
            print(error)
        }
        
        return nil
    }
    
    
}
