//
//  ViewController.swift
//  final-project-ios
//
//  Created by Walter Calderon on 21/6/21.
//

import UIKit
import JSONLoader
import Kingfisher
import CoreData

class RecipeTableViewCell: UITableViewCell {
   
   
    
    @IBOutlet weak var lblTitleRecipe: UILabel!
    @IBOutlet weak var lblFatRecipe: UILabel!
    @IBOutlet weak var lblCarbsRecipe: UILabel!
    @IBOutlet weak var lblProteinRecipe: UILabel!
    @IBOutlet weak var lblCaloriesRecipe: UILabel!
    @IBOutlet weak var imageViewCell: UIImageView!
}

class ViewController: UIViewController {
    
    @IBOutlet var imageView: UIImageView?
    @IBOutlet var button: UIButton?
    
    //boton para agregar foto
       @IBAction func didTapButton(){
            let picker = UIImagePickerController()
        // picker.sourceType = .camera //aqui se le pide a la camara
        picker.sourceType = .savedPhotosAlbum // aqui se le pide a la galeria
        picker.delegate = self
        present(picker, animated: true)
       }// fin didTapButton
    
    
    var anotaciones: [NSManagedObject] = []
    
    // agregar anotacion
    @IBAction func addAnotacion(_ sender: Any) {
        let alert = UIAlertController(title: "Nueva anotacion", message: "Agregue una anotacion a la receta", preferredStyle: .alert)
        let saveAction = UIAlertAction(title: "Guardar", style: .default) { action in
            guard let textField = alert.textFields?.first, let anotacion = textField.text else {
                return
            }
            self.saveAnotacion(anotacion: anotacion)
            //self.tableView.reloadData()
        }
        
        let cancelAction = UIAlertAction(title: "Cancelar", style: .cancel)
        alert.addTextField()
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        self.present(alert, animated: true)
    }// fin addAnotation

    //guardar anotacion
    func saveAnotacion(anotacion: String) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let anotacion = AnotaProxy.saveAnotacion(anotacion: anotacion, delegate: appDelegate)
        if  anotacion != nil {
            self.anotaciones.append(anotacion!)
        }
    }//fin saveAnotacion

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
    
  
    
}



            
//entension para la foto/imagen
extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
            return
        }
        imageView?.image = image
    }
    
}// fin UIPicker


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
        
        let url = URL(string: recipesData!.image)
        cell.imageViewCell.kf.setImage(with: url)
        
        cell.lblTitleRecipe?.text = recipesData?.title
        cell.lblFatRecipe?.text =  "Fat:"
        cell.lblCarbsRecipe?.text = "Carbs:"
        cell.lblProteinRecipe?.text = "Prot:"
        cell.lblCaloriesRecipe?.text = "Cal:"
        
        
        return cell
    }
}
