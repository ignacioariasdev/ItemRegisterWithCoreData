//
//  PopOverVC.swift
//  ItemRegisterWithCoreData
//
//  Created by Ignacio Arias on 2020-07-15.
//  Copyright © 2020 Ignacio Arias. All rights reserved.
//

import UIKit


//Add to persistence.
class PopOverVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Add"
        
    }
    
    
    @IBAction func saveIntoPersistence(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }
}
