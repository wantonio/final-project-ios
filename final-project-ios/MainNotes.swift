//
//  MainNotes.swift
//  final-project-ios
//
//  Created by Admin on 28/6/21.
//

import Foundation
import CoreData

class MainNotesProxy {
    
    init() {
        
    }
    
    static func saveMainNote(note:String, delegate: AppDelegate) -> NSManagedObject?{
        let manageContext = delegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "MainNotes", in: manageContext)!
        let user = NSManagedObject(entity: entity, insertInto: manageContext)
        user.setValue(note, forKey: "note")
        do {
            try manageContext.save()
            return user
        }catch let error as NSError {
            print(error)
        }
        
        return nil
    }
    
    static func getMainNotes(delegate: AppDelegate) -> [NSManagedObject]? {
        let managedContext = delegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "MainNotes")
        do {
            let users:[NSManagedObject] = try managedContext.fetch(fetchRequest)
            return users
        } catch let error as NSError {
            print(error)
        }
        
        return nil
    }
}
