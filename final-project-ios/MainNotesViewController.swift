import UIKit

class NoteTableViewCell: UITableViewCell {
    @IBOutlet weak var recipeTitle: UILabel!
    @IBOutlet weak var noteText: UILabel!
    @IBOutlet weak var updatedDate: UILabel!
    @IBOutlet weak var imageViewCell: UIImageView!
}


class MainNotesViewController: UIViewController{
    
    @IBOutlet weak var nothingFoundText: UILabel!
    @IBOutlet weak var loadingImage: UIImageView!
    @IBOutlet weak var recipesTable: UITableView!
    
    var recipesNoted: [RecipeEntity] = [] {
        didSet {
            self.recipesTable.reloadData()
            
            self.toggleNothingFound(show: self.recipesNoted.count == 0)
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        toggleLoading(show: true)
        
        if let recipes = RecipeProxy.getAlltRecipes(delegate: appDelegate) {
            self.recipesNoted = recipes
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        do {
           try loadingImage.setGifImage(UIImage(gifName: "loading.gif"), loopCount: -1)
        }catch {
            print(error)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let index = self.recipesTable.indexPathForSelectedRow {
            let destination = segue.destination as! DetailViewController
            
            let recipe = recipesNoted[index.row]
            destination.recipeId = Int(recipe.id)
            destination.delegate = self
        }
    }
    
    func toggleNothingFound(show: Bool) {
        recipesTable.isHidden = show
        nothingFoundText.isHidden = !show
        loadingImage.isHidden = true
    }
    
    func toggleLoading(show: Bool) {
        recipesTable.isHidden = show
        nothingFoundText.isHidden = true
        loadingImage.isHidden = !show
    }
}

extension MainNotesViewController:UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipesNoted.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = recipesTable.dequeueReusableCell(withIdentifier: "RecipeCell", for: indexPath)as! NoteTableViewCell
        
        let recipesData = recipesNoted[indexPath.row]
        
        if let imageStr = recipesData.image {
            let url = URL(string: imageStr)
            cell.imageViewCell.kf.setImage(with: url)
        }
        
        cell.recipeTitle.text = recipesData.title!
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        let date = dateFormatter.string(from: recipesData.updatedDate!)
        
        cell.updatedDate.text = date
        cell.noteText.text = recipesData.note
        
        return cell
    }
}

extension MainNotesViewController: RecipeNotedListDelegate {
    func addRecipeNoted(recipe: RecipeEntity) {
        recipesNoted.insert(recipe, at: 0)
    }
    
    func updateRecipeNoted(recipe: RecipeEntity) {
        if let index = self.recipesTable.indexPathForSelectedRow {
            recipesNoted[index.row] = recipe
        }
    }
    
    func removeRecipeNoted() {
        if let index = self.recipesTable.indexPathForSelectedRow {
            recipesNoted.remove(at: index.row)
        }
    }
}
