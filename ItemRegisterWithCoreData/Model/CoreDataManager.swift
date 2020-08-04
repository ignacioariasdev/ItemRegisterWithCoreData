//
//  CoreDataManager.swift
//  ItemRegisterWithCoreData
//
//  Created by Ignacio Arias on 2020-07-17.
//  Copyright © 2020 Ignacio Arias. All rights reserved.
//

import Foundation
import CoreData

class CoreDataManager {
    
    //Singleton
    static let shared = CoreDataManager(modelName: "item")
    
    // MARK: - BASIC Set UP
    let persistentContainer: NSPersistentContainer

    //Gold
    var viewContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }

    //Name of the data model where we are going to save the data
    init(modelName: String) {
        persistentContainer = NSPersistentContainer(name: modelName)
    }

    func load(completion: (() -> Void)? = nil) {
        print("database loaded...")
        persistentContainer.loadPersistentStores { (storeDescription, error) in
            guard error == nil else {
                fatalError(error!.localizedDescription)
            }

            //Kicking autoSave
            self.autoSaveViewContext()
            completion?()
        }
    }
}

// MARK: - AutoSaving, after there are changes. so 30 seconds check for changes.
extension CoreDataManager {
    
    func autoSaveViewContext(interval: TimeInterval = 30) {
        print("AutoSaving...(30segs)")
        guard interval > 0 else {
            print("Cannot set negative autosave interval")
            return
        }

        //Checking for changes otherwise don't save
        if viewContext.hasChanges {
            try? viewContext.save()
        }

        //Check every 30 seconds
        DispatchQueue.main.asyncAfter(deadline: .now() + interval) {
            self.autoSaveViewContext(interval: interval)
        }

    }
}
