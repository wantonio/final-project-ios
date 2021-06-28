import UIKit
import CoreData

class NotesViewController: UIViewController, TabRecipePanel    {
    var recipe: RecipeInfo?
    
    @IBOutlet var photo: UIImageView?
    @IBOutlet var test: UILabel!
    
    var anotaciones: [NSManagedObject] = []
    
    
   
    
    @IBAction func addNote(_ sender: Any) {
        let alert = UIAlertController(title: "New Note", message: "Add Note", preferredStyle: .alert)
        let saveAction = UIAlertAction(title: "Save", style: .default) { action in
            guard let textField = alert.textFields?.first, let anotacion = textField.text else {
                return
            }
            self.saveNote(anotacion: anotacion)
            self.test.reloadInputViews()        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addTextField()
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        self.present(alert, animated: true)
        
    }
    

    //guardar anotacion
    func saveNote(anotacion: String) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let anotacion = NoteProxy.saveNote(anotacion: anotacion, delegate: appDelegate)
        if  anotacion != nil {
            self.anotaciones.append(anotacion!)
        }
        
        self.test?.text = anotacion?.value(forKeyPath: "anotacion") as? String
        
        
    }//fin saveAnotacion
    
    
    
    @IBAction func addImage() {
    
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        // picker.sourceType = .camera //aqui se le pide a la camara
        picker.sourceType = .savedPhotosAlbum
        present(picker, animated: true)
        }
    
    
    class DataBaseHelper {
    static let shareInstance = DataBaseHelper()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    func saveImage(data: Data) {
    let imageInstance = Anotaciones(context: context)
        imageInstance.img = data
    do {
    try context.save()
    print("Image is saved")
    } catch {
    print(error.localizedDescription)
          }
       }
    }
    
    
    @IBAction func saveImage(_ sender: UIButton) {
        
        if let imageData = photo?.image?.pngData() {
        DataBaseHelper.shareInstance.saveImage(data: imageData)
           }
        
    }
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first ?? "Not Found")
    return true
    }
    

    
    
    
   
}



    //entension para la foto/imagen
    extension NotesViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            picker.dismiss(animated: true, completion: nil)
        }
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let userPickedImage = info[.editedImage] as? UIImage else { return }
        photo?.image = userPickedImage
        picker.dismiss(animated: true)
        }
    }// fin UIPicker

