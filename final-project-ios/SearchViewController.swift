//
//  SearchViewController.swift
//  final-project-ios
//
//  Created by Andres Azofeifa on 24/6/21.
//

import UIKit

class SearchViewController: UIViewController {

    @IBOutlet weak var popupView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        popupView.layer.cornerRadius = 10
        popupView.layer.masksToBounds = true
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func btnSearchFilters(_ sender: Any) {
        
    }
    
    
    @IBAction func btnCancelFilters(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
