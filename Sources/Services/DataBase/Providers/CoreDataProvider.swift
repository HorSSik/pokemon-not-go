//
//  DataBaseProvider.swift
//  Pokemon Not Go
//
//  Created by Dima Omelchenko on 05.11.2020.
//  Copyright © 2020 IDAP. All rights reserved.
//

import UIKit

import CoreData

class CoreDataProvider<Model: NSObject>: DataBaseProviderType {
    
    // MARK: -
    // MARK: Typealies
    
    typealias DataBaseObject = Model
    
    // MARK: -
    // MARK: Public
    
    func read(key: String) -> DataBaseObject? {
        var object: NSManagedObject?
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        
        appDelegate.do { appDelegate in
            let managedContext = appDelegate.persistentContainer.viewContext
            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Pokemon")
            fetchRequest.returnsObjectsAsFaults = false

            do {
                let result = try managedContext.fetch(fetchRequest)
                
                for data in result as! [NSManagedObject] {
                    let name = data.value(forKey: "name") as? String
                    
                    print("TEST User Name is : \(name)")
                }
            } catch let error as NSError {
                print("TEST Could not fetch. \(error), \(error.userInfo)")
            }
        }
        
        return object as? DataBaseObject
    }
    
    func save(object: DataBaseObject) {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate

        appDelegate.do { appDelegate in
            let managedContext = appDelegate.persistentContainer.viewContext
            let entity = NSEntityDescription.entity(forEntityName: "Pokemon", in: managedContext)!
            let pokemon = NSManagedObject(entity: entity, insertInto: managedContext)
            
            let model = object as? PokemonDetailModel
            
            pokemon.setValue(model?.name, forKeyPath: "name")
            
            do {
                try managedContext.save()
                print("TEST SAVE")
                print("\(object)")
            } catch let error as NSError {
                print("TEST Could not save. \(error), \(error.userInfo)")
            }
        }
    }
}
