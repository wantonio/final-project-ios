import UIKit
import JSONLoader

class DetailViewController: UIViewController {
    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var recipeTabs: UITabBar!
    @IBOutlet weak var infoTabPanel: UIView!
    @IBOutlet weak var instructionTabPanel: UIView!
    @IBOutlet weak var ingridientsTabPanel: UIView!
    @IBOutlet weak var notesTabPanel: UIView!
    
    lazy var currentTabPanel: UIView = {
        return infoTabPanel
    }()
    
    var recipe: RecipeInfo?
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tabBarController?.tabBar.isHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBarController?.tabBar.isHidden = true

        do {
            recipe = try loadFromBundle("recipe")
            
            let url = URL(string: recipe!.image)
            recipeImage.kf.setImage(with: url)
            
            recipeTabs.selectedItem = recipeTabs.items?[0]
        
            loadTabsPanel()
        } catch let err {
            print(err.localizedDescription)
        }
   }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if var destination = segue.destination as? TabRecipePanel {
            destination.recipe = recipe
        }
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        switch identifier {
        case "InfoViewController", "InstructionsViewController", "IngridientsViewController", "NotesViewController":
            guard let _ = recipe else {
                return false
            }
        default:
            break
        }
        
        return true
    }
    
    func loadTabsPanel() {
        guard let _ = recipe else {
            return
        }
        
        performSegue(withIdentifier: "InfoViewController", sender: self)
        performSegue(withIdentifier: "InstructionsViewController", sender: self)
        performSegue(withIdentifier: "IngridientsViewController", sender: self)
        performSegue(withIdentifier: "NotesViewController", sender: self)
    }
}

extension DetailViewController: UITabBarDelegate {
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        
        guard let tab = item.title else {
            return
        }
        
        switch tab {
        case "Info":
            showTabPanel(tabPanel: infoTabPanel)
        case "Instructions":
            showTabPanel(tabPanel: instructionTabPanel)
        case "Ingridients":
            showTabPanel(tabPanel: ingridientsTabPanel)
        case "Notes":
            showTabPanel(tabPanel: notesTabPanel)
        default:
            return
        }
    }
    
    func showTabPanel(tabPanel: UIView) {
        if (tabPanel == currentTabPanel) {
            return
        }
        
        UIView.animate(withDuration: 0.4, delay: 0.0, options: .curveEaseOut, animations: {
            self.currentTabPanel.alpha = 0.0
        }, completion: {
            _ in
            self.currentTabPanel.isHidden = true
            tabPanel.isHidden = false
            self.currentTabPanel = tabPanel
            
            UIView.animate(withDuration: 0.4, delay: 0.0, options: .curveEaseOut, animations: {
                tabPanel.alpha = 1.0
            }, completion: nil)
        })
    }
}
