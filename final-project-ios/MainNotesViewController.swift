//
//  MainNotesViewController.swift
//  final-project-ios
//
//  Created by Admin on 28/6/21.
//

import UIKit
import CoreData


class MainNotesViewController: UIViewController     {
   /*
    
   
  
    var notes: [NSManagedObject] = []
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        if let usersDatabase = MainNotesProxy.getMainNotes(delegate: appDelegate) {
            self.notes = usersDatabase
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    

    
    
    
    
    

    
    
    
    @IBAction func addMainNote5(_ sender: Any) {
        let alert = UIAlertController(title: "New Note", message: "Add Note", preferredStyle: .alert)
        
        let saveAction = UIAlertAction(title: "Save", style: .default) { action in
            guard let textField = alert.textFields?.first, let note = textField.text else {
                return
            }
            
            self.saveMainNote(note: note)
            self.tableView.reloadData()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addTextField()
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        self.present(alert, animated: true)
    }
    
    func saveMainNote(note: String) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let note = MainNotesProxy.saveMainNote(note: note, delegate: appDelegate)
        
        if  note != nil {
            self.notes.append(note!)
        }
    }
    
}

extension MainNotesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let note = notes[indexPath.row]
        
        cell.textLabel?.text = note.value(forKeyPath: "note") as? String
        
        return cell
    }
    
    */
    
}
