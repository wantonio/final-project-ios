import UIKit

class IngridientCell: UICollectionViewCell {
    @IBOutlet weak var amountText: UILabel!
    @IBOutlet weak var ingridientImage: UIImageView!
    @IBOutlet weak var ingridientText: UILabel!
}

class IngridientsViewController: UIViewController, TabRecipePanel {
    @IBOutlet weak var visibleView: UIView!
    @IBOutlet weak var servingText: UILabel!
    var recipe: RecipeInfo?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let recipe = recipe else {
            return
        }
        
        var serving: String = "--"
        
        if let i = recipe.servings {
            serving = String(describing: i)
        }
        
        servingText.text = "Servings: " + serving
    }
}

extension IngridientsViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let rec = recipe, let ingridients = rec.extendedIngredients else {
            return 0
        }
        
        return ingridients.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "IngridientCell", for: indexPath) as! IngridientCell
        
        guard let rec = recipe, let ingridients = rec.extendedIngredients else {
            return cell
        }
        
        let ingridient = ingridients[indexPath.row]
        
        let url = URL(string: "https://spoonacular.com/cdn/ingredients_100x100/\(ingridient.image)")
        cell.ingridientImage.kf.setImage(with: url)
        cell.amountText.text = String(format: "%.2f ", ingridient.amount) + ingridient.unit
        cell.ingridientText.text = ingridient.name
        
        return cell
    }
}

extension IngridientsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150.0, height: 155.0)
    }
}


