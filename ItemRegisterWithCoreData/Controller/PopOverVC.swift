//
//  PopOverVC.swift
//  ItemRegisterWithCoreData
//
//  Created by Ignacio Arias on 2020-07-15.
//  Copyright © 2020 Ignacio Arias. All rights reserved.
//

import UIKit
import CoreData

//Add to persistence.
class PopOverVC: UIViewController {
    
    @IBOutlet weak var itemName: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Add"
    }
    
    
    @IBAction func saveIntoPersistence(_ sender: Any) {

        // Open an instance of coreDataManager
        let item = Item(context: CoreDataManager.shared.viewContext)
        
        //setting the text of the txtField to a variable
        let someItemName = itemName.text
        
        
        //Setting the model item name to the variable for a new some item name.
        item.name = someItemName
        
        //Save to persistent store
        try? CoreDataManager.shared.viewContext.save()

        dismiss(animated: true, completion: nil)
    }
      
}
