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
            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: toString(DataBaseObject.self))
            fetchRequest.returnsObjectsAsFaults = false

            do {
                let result = try managedContext.fetch(fetchRequest)
                
                for data in result  {
//                    let name = data.value(forKey: "name") as? String
//                    let order = data.value(forKey: "order") as? Int
//                    let baseExperience = data.value(forKey: "baseExperience") as? Int
//                    let weight = data.value(forKey: "weight") as? Int
//                    let height = data.value(forKey: "height") as? Int
                    
                    print("TEST User Name is : \(data)")
                    
//                    let a = data as? DataBaseObject
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
            let entity = NSEntityDescription.entity(forEntityName: toString(DataBaseObject.self), in: managedContext)!
            let pokemon = NSManagedObject(entity: entity, insertInto: managedContext)
            
            let model = object as? PokemonDetailModel
            
//            pokemon.setValue(model?.name, forKeyPath: "name")
//            pokemon.setValue(model?.order, forKeyPath: "order")
//            pokemon.setValue(model?.baseExperience, forKeyPath: "baseExperience")
//            pokemon.setValue(model?.weight, forKeyPath: "weight")
//            pokemon.setValue(model?.height, forKeyPath: "height")
            
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
