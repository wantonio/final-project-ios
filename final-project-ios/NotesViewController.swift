import UIKit

class NotesViewController: UIViewController, TabRecipePanel {
    var recipe: RecipeInfo?
    
    @IBOutlet weak var notesText: UITextView!
    @IBOutlet weak var photoImage: UIImageView!
}
