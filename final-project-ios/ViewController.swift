//
//  ViewController.swift
//  final-project-ios
//
//  Created by Walter Calderon on 21/6/21.
//

import UIKit
import Kingfisher

class RecipeTableViewCell: UITableViewCell {
   
    
    @IBOutlet weak var lblTitleRecipe: UILabel!
    @IBOutlet weak var lblFatRecipe: UILabel!
    @IBOutlet weak var lblCarbsRecipe: UILabel!
    @IBOutlet weak var lblProteinRecipe: UILabel!
    @IBOutlet weak var lblCaloriesRecipe: UILabel!
    @IBOutlet weak var imageViewCell: UIImageView!
}

class ViewController: UIViewController {

    var client:Client?
    let session = URLSession.shared
    var queryInfo: SearchQueryParam?
    @IBOutlet weak var tableViewRecipes: UITableView!
    @IBOutlet weak var textFieldSearch: UITextField!
    
    var lRecipes:[RecipeInfo]?{
        didSet{
            self.tableViewRecipes.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        queryInfo = SearchQueryParam(number: 50)
        lRecipes = [RecipeInfo]()
        client = Client(session: session)
        client?.search(queryParams: queryInfo!, complete: { result in
            switch result{
            
            case .success(let dataSearch):
                
                for datos in dataSearch.results{
                    
                    self.lRecipes?.append(RecipeInfo(id: datos.id, title: datos.title, image: datos.image, imageType: datos.imageType, nutrition: datos.nutrition, summary: datos.summary, diets: datos.diets, analyzedInstructions: datos.analyzedInstructions, extendedIngredients: datos.extendedIngredients))
                    
                }
                
                print(dataSearch)
                    
            case .failure(let error):
                print(error)
            }
        })
        
            
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
        let nutrition: Nutrition = recipesData!.nutrition
        let nutritionData: [Nutrients] = nutrition.nutrients
        
        
        var _fatQty: Float = 0.0
        var _carbsQty: Float = 0.0
        var _protQty: Float = 0.0
        var _calQty: Float = 0.0
        
        for dataNutrition in nutritionData {
            
            switch dataNutrition.title {
            
            case "Calories":
                _calQty = dataNutrition.amount
                
            case "Protein":
                _protQty = dataNutrition.amount
                
            case "Fat":
                _fatQty = dataNutrition.amount
                
            case "Carbohydrates":
                _carbsQty = dataNutrition.amount
            
            default:
                    print("Error")
            }
        }
        
        let url = URL(string: recipesData!.image)
        cell.imageViewCell.kf.setImage(with: url)
        cell.lblTitleRecipe?.text = recipesData?.title
        cell.lblFatRecipe?.text =  "Fat: " + String(format: "%.2f", _fatQty)
        cell.lblCarbsRecipe?.text = "Carbs: " + String(format: "%.2f", _fatQty)
        cell.lblProteinRecipe?.text = "Prot: " + String(format: "%.2f", _protQty)
        cell.lblCaloriesRecipe?.text = "Cal: " + String(format: "%.2f", _calQty)
        
        
        return cell
    }
}
