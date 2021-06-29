import UIKit
import CoreData

class NoteViewController: UIViewController, TabRecipePanel {
    var delegate: RecipeNotedListDelegate?
    
    @IBOutlet weak var recipePhoto: UIImageView!
    @IBOutlet weak var noteText: UITextView!
    var recipe: RecipeInfo?
    var recipeFound: Bool = false
    var recipePhotoUrl: URL?
    
    lazy var appDelegate: AppDelegate? = {
        return UIApplication.shared.delegate as? AppDelegate
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let recipe = recipe, let appDelegate = appDelegate else {
            return
        }
        
        guard let recipeSaved = RecipeProxy.getRecipe(id: recipe.id, delegate: appDelegate)?.toStruct() else {
            return
        }
        
        if let photoUrl = recipeSaved.photo {
            recipePhotoUrl = photoUrl
            let image = UIImage(contentsOfFile: photoUrl.path)
            recipePhoto.image = image
        }
        
        recipeFound = true
                
        noteText.text = recipeSaved.note
    }
    @IBAction func addImageTap(_ sender: Any) {
        addPicture()
    }
    
    @IBAction func deleteTap(_ sender: Any) {
        if (!recipeFound) {
            return
        }
        
        guard let recipe = recipe, let appDelegate = appDelegate else {
            return
        }
        
        if RecipeProxy.deleteRecipe(id: recipe.id, delegate: appDelegate) {
            self.showToast(message: "Note deleted", font: .systemFont(ofSize: 12.0))
            noteText.text = ""
            recipePhoto.image = UIImage(named: "food_placeholder.jpeg")
            recipeFound = false
            delegate?.removeRecipeNoted()
        } else {
            self.showToast(message: "An error ocurred", font: .systemFont(ofSize: 12.0))
        }
    }
    
    @IBAction func saveTap(_ sender: Any) {
        guard let recipe = recipe, let appDelegate = appDelegate else {
            return
        }
        
        let note = noteText.text!
        
        if (note == "") {
            self.showToast(message: "Note field is required", font: .systemFont(ofSize: 12.0))
            return
        }
        
        let updatedRecipe = RecipePersisted(id: recipe.id, title: recipe.title, image: recipe.image, note: note, photo: recipePhotoUrl, updatedDate: Date())
        
        if (recipeFound) {
            if let updatedRecipe = RecipeProxy.updateRecipe(updatedRecipe: updatedRecipe, delegate: appDelegate) {
                self.showToast(message: "Note updated", font: .systemFont(ofSize: 12.0))
                delegate?.updateRecipeNoted(recipe: updatedRecipe)
            } else {
                self.showToast(message: "An error ocurred", font: .systemFont(ofSize: 12.0))
            }
        } else {
            if let addedRecipe = RecipeProxy.saveRecipe(recipe: updatedRecipe, delegate: appDelegate) {
                self.showToast(message: "Note added", font: .systemFont(ofSize: 12.0))
                recipeFound = true
                delegate?.addRecipeNoted(recipe: addedRecipe)
            } else {
                self.showToast(message: "An error ocurred", font: .systemFont(ofSize: 12.0))
            }
        }
    }
}
    
extension NoteViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @objc func addPicture() {
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.delegate = self
        present(picker, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else { return }

        let imageName = UUID().uuidString
        let imagePath = getDocumentsDirectory().appendingPathComponent(imageName)
        
        if let jpegData = image.jpegData(compressionQuality: 0.8) {
            try? jpegData.write(to: imagePath)
            recipePhoto.image = image
        }
        
        recipePhoto.image = image
        self.recipePhotoUrl = imagePath

        dismiss(animated: true)
    }

    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}
