import UIKit
import Kingfisher

class InfoViewController: UIViewController, TabRecipePanel {
    var recipe: RecipeInfo?
    
    @IBOutlet weak var recipeTitle: UILabel!
    @IBOutlet weak var carbsText: UILabel!
    @IBOutlet weak var caloriesText: UILabel!
    @IBOutlet weak var fatText: UILabel!
    @IBOutlet weak var proteinText: UILabel!
    override func viewDidLoad() {
        setNutrientsView()
    }
    
    func setNutrientsView() {
        guard let recipe = recipe else {
            return
        }
        
        var _fatQty: Float = 0.0
        var _carbsQty: Float = 0.0
        var _protQty: Float = 0.0
        var _calQty: Float = 0.0
        
        var remaining = 4
        
        for dataNutrition in recipe.nutrition.nutrients {
            
            switch dataNutrition.title {
            
            case "Calories":
                _calQty = dataNutrition.amount
                remaining -= 1
                
            case "Protein":
                _protQty = dataNutrition.amount
                remaining -= 1
                
            case "Fat":
                _fatQty = dataNutrition.amount
                remaining -= 1
                
            case "Carbohydrates":
                _carbsQty = dataNutrition.amount
                remaining -= 1
            
            default:
                break
            }
            
            if (remaining == 0) {
                break
            }
        }
        
        recipeTitle?.text = recipe.title
        carbsText?.text =  String(format: "%.2f", _carbsQty)
        caloriesText?.text = String(format: "%.2f", _calQty)
        fatText?.text = String(format: "%.2f", _fatQty)
        proteinText?.text = String(format: "%.2f", _protQty)
    }
}
