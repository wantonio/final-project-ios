//
//  SearchViewController.swift
//  final-project-ios
//
//  Created by Andres Azofeifa on 24/6/21.
//

import UIKit


class SearchViewController: UIViewController {

    @IBOutlet weak var popupView: UIView!
    
    @IBOutlet weak var txtQueryField: UITextField!
    @IBOutlet weak var txtQueryFatMinField: UITextField!
    @IBOutlet weak var txtQueryFatMaxField: UITextField!
    @IBOutlet weak var txtQueryCarbsMinField: UITextField!
    @IBOutlet weak var txtQueryCarbsMaxField: UITextField!
    @IBOutlet weak var txtQueryProteinMinField: UITextField!
    @IBOutlet weak var txtQueryProteinMaxField: UITextField!
    @IBOutlet weak var txtQueryCaloriesMinField: UITextField!
    @IBOutlet weak var txtQueryCaloriesMaxField: UITextField!
    var delegate: queryDelegate? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        popupView.layer.cornerRadius = 10
        popupView.layer.masksToBounds = true
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func btnSearchFilters(_ sender: Any) {
        let filterSearch: SearchQueryParam
        filterSearch = SearchQueryParam(query: txtQueryField.text, number: 100,
                                        minFat: Int(txtQueryFatMinField.text!),
                                        minCarbs: Int(txtQueryCarbsMinField.text!),
                                        minProtein: Int(txtQueryProteinMinField.text!),
                                        minCalories: Int(txtQueryCaloriesMinField.text!))
       
        if self.delegate != nil {
            self.delegate?.updateQuerySearch(querySearch: filterSearch)
            dismiss(animated: true, completion: nil)
        }
    }
    
    
    @IBAction func btnCancelFilters(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
