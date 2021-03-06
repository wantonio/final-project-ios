import UIKit
import JSONLoader

class DetailViewController: UIViewController {
    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var recipeTabs: UITabBar!
    @IBOutlet weak var infoTabPanel: UIView!
    @IBOutlet weak var instructionTabPanel: UIView!
    @IBOutlet weak var ingridientsTabPanel: UIView!
    @IBOutlet weak var noteTabPanel: UIView!
    @IBOutlet weak var loadingImage: UIImageView!
    
    var delegate: RecipeNotedListDelegate?
    
    var recipeId: Int?
    var client:Client?
    let session = URLSession.shared
    
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
        
        do {
           try loadingImage.setGifImage(UIImage(gifName: "loading.gif"), loopCount: -1)
        }catch {
            print(error)
        }
        
        tabBarController?.tabBar.isHidden = true
        recipeTabs.selectedItem = recipeTabs.items?[0]
        loadRecipe()
   }
    
    func loadRecipe() {
        toggleLoading(show: true)
                
        guard let id = recipeId else {
            return
        }
        
        client = Client(session: session)
        client?.getRecipe(id: id, complete: { result in
            switch result{
            
            case .success(let recipe):
                self.recipe = recipe
                
                if let imageStr = recipe.image {
                    let url = URL(string: imageStr)
                    self.recipeImage.kf.setImage(with: url)
                }
                
                self.loadTabsPanel()
                    
            case .failure(let error):
                print(error)
            }
            
            self.toggleLoading(show: false)
        })
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if var destination = segue.destination as? TabRecipePanel {
            destination.recipe = recipe
            destination.delegate = delegate
        }
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        switch identifier {
        case "InfoViewController", "InstructionsViewController", "IngridientsViewController", "NoteViewController":
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
        performSegue(withIdentifier: "NoteViewController", sender: self)
    }
    
    func toggleLoading(show: Bool) {
        recipeImage.isHidden = show
        recipeTabs.isHidden = show
        loadingImage.isHidden = !show
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
            showTabPanel(tabPanel: noteTabPanel)
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
            tabPanel.alpha = 0.0
            tabPanel.isHidden = false
            self.currentTabPanel = tabPanel
            
            UIView.animate(withDuration: 0.4, delay: 0.0, options: .curveEaseOut, animations: {
                tabPanel.alpha = 1.0
            }, completion: nil)
        })
    }
}
