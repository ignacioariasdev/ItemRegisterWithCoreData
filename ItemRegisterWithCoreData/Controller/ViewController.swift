//
//  ViewController.swift
//  ItemRegisterWithCoreData
//
//  Created by Ignacio Arias on 2020-07-15.
//  Copyright © 2020 Ignacio Arias. All rights reserved.
//

import UIKit
import CoreData


//Fetch from persistence and reflect to the table view
class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    // Instance of Core Data management
    var coreDataManager: CoreDataManager!
    
    //The item object being presented
    var items: [Item] = []

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        coreDataLogic()
//        fetchFromCoreDataToFillTableView()
    }
    
    fileprivate func coreDataLogic() {
           
           //NSManagedContext, this is step 10.
           let fetchRequest: NSFetchRequest<Item> = Item.fetchRequest()
           
           //step 10.1
           let sortDescriptor = NSSortDescriptor(key: "name", ascending: false)
           
           fetchRequest.sortDescriptors = [sortDescriptor]
           
           if let result = try? coreDataManager.viewContext.fetch(fetchRequest) {
               
               // Array from dataSource fetched with coreData
               items = result
            
               //refresh UI by repopulating the data
               tableView.reloadData()
           }
           
           tableView.dataSource = self
           tableView.delegate = self
       }
    
//    func fetchFromCoreDataToFillTableView() {
//        
//        //Accesing the core data manager NSManagedObjectContext
//        let item = Item(context: coreDataManager.viewContext)
//        
//        item.name = name
//        
//        //Append items to the end, insert items to the init
//        items.insert(item, at: 0)
//        
//        tableView.insertRows(at: [IndexPath(row: 0, section: 0)], with: .fade)
//        
//    }
    
    
    // MARK: - Helpers
      var numberOfItems: Int { return items.count }
      
      func item(at indexPath: IndexPath) -> Item {
          return items[indexPath.row]
      }

}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfItems
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let aItem = item(at: indexPath)
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "itemCell", for: indexPath)
        
        cell.detailTextLabel?.text = aItem.name
        
        return cell
    }
    
    
}

