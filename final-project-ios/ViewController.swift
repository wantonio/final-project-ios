//
//  ViewController.swift
//  final-project-ios
//
//  Created by Walter Calderon on 21/6/21.
//

import UIKit
import JSONLoader

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        do {
             let search: SearchRes = try loadFromBundle("search")
             print(search.results[0])
            
            let recipe: RecipeInfo = try loadFromBundle("recipe")
            
            if let instructions = recipe.analyzedInstructions {
                print(instructions[0].steps)
            }

        } catch let err {
            print(err.localizedDescription)
        }
    }
}

