//
//  ViewController.swift
//  final-project-ios
//
//  Created by Walter Calderon on 21/6/21.
//

import UIKit
import JSONLoader

class RecipeTableViewCell: UITableViewCell {
   
    
    @IBOutlet weak var lblTitleRecipe: UILabel!
    @IBOutlet weak var lblFatRecipe: UILabel!
    @IBOutlet weak var lblCarbsRecipe: UILabel!
    @IBOutlet weak var lblProteinRecipe: UILabel!
    @IBOutlet weak var lblCaloriesRecipe: UILabel!
    @IBOutlet weak var imageViewCell: UIImageView!
}

class ViewController: UIViewController {

    @IBOutlet weak var tableViewRecipes: UITableView!
    @IBOutlet weak var textFieldSearch: UITextField!
    
    var lRecipes:[RecipeInfo]?{
        didSet{
            self.tableViewRecipes.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        lRecipes = [RecipeInfo]()
        do {
             let search: SearchRes = try loadFromBundle("search")
             lRecipes = search.results
            
        } catch let err {
            print(err.localizedDescription)
        }
    }
    
    
    @IBAction func btnSearchRecipe(_ sender: Any) {
        let filterStr = textFieldSearch.text
        lRecipes = lRecipes?.filter { $0.title.contains(filterStr!) }
    }
}
            

extension ViewController:UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let lrecipe = self.lRecipes else {
            return 0
        }
        return lrecipe.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableViewRecipes.dequeueReusableCell(withIdentifier: "RecipeCell", for: indexPath)as! RecipeTableViewCell
        
        let recipesData = lRecipes?[indexPath.row]
        cell.lblTitleRecipe?.text = recipesData?.title
        cell.imageViewCell?.image = UIImage(named: recipesData!.image)
        cell.lblFatRecipe?.text =  "Fat:"
        cell.lblCarbsRecipe?.text = "Carbs:"
        cell.lblProteinRecipe?.text = "Prot:"
        cell.lblCaloriesRecipe?.text = "Cal:"
        
        
        return cell
    }
}

