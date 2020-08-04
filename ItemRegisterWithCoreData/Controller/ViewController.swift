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
    //    var coreDataManager: CoreDataManager!
    
    //The item object being presented
    var items: [Item] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        coreDataLogic()
    }
    
    
    //Close and reopen to refresh the tableView
    
    public func coreDataLogic() {
        
        //NSManagedContext, this is step 10.
        let fetchRequest: NSFetchRequest<Item> = Item.fetchRequest()
        
        //step 10.1
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: false)
        
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        if let result = try? CoreDataManager.shared.viewContext.fetch(fetchRequest) {
            
            // Array from dataSource fetched with coreData
            items = result
            
            //refresh UI by repopulating the data
            tableView.reloadData()
        }
        
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    
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
        
        cell.textLabel?.text = aItem.name!
        
        return cell
    }
    
    
}

