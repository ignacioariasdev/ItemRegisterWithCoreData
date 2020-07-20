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
    
    @IBOutlet weak var itemName: UITextField!
    
    var coreDataManager: CoreDataManager!
    
    //The item object being presented
    var items: [Item] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Add"
    }
    
    
    @IBAction func saveIntoPersistence(_ sender: Any) {

        // Open an instance of coreDataManager
        let item = Item(context: coreDataManager.viewContext)
        
        //setting the text of the txtField to a variable
        let someItemName = itemName.text
        
        //Setting the model item name to the variable for a new some item name.
        item.name = someItemName
        
        //Save to persistent store
        try? coreDataManager.viewContext.save()
        
        //Append items to the end, insert items to the init
        items.insert(item, at: 0)
               
        //ViewController.tableView.insertRows(at: [IndexPath(row: 0, section: 0)], with: .fade)
        
        self.dismiss(animated: true, completion: nil)
    }
      
}
