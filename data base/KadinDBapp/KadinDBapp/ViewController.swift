//
//  ViewController.swift
//  KadinDBapp
//
//  Created by Kadin Redd on 8/16/20.
//  Copyright © 2020 Kadin Redd. All rights reserved.
//

import UIKit
import Foundation
import CoreData

class ViewController: UIViewController {
   
    var dataManager : NSManagedObjectContext!
    var listArray = [NSManagedObject]()
    
    
    
    @IBAction func saveRecord(_ sender: Any) {
        let newEntity = NSEntityDescription.insertNewObject(forEntityName: "Item", into: dataManager)
        newEntity.setValue(enterDescription.text!, forKey: "about")
        
        do{
            try self.dataManager.save()
            listArray.append(newEntity)
        }catch {
            print("Error Saving Data")
        }
        diplayDataHere.text?.removeAll()
        fetchData()
    }
    
    @IBAction func deleteRecordButton(_ sender: Any) {
        let deleteItem = enterDescription.text!
        for item in listArray {
            if item.value(forKey: "about") as! String == deleteItem {
                dataManager.delete(item)
            }
            do {
                try self.dataManager.save()
                
            }catch {
                print("Error Deleting Data")
            }
            diplayDataHere.text?.removeAll()
            enterDescription.text?.removeAll()
            fetchData()
        }
        
    }

    @IBOutlet weak var enterDescription: UITextField!
  
    @IBOutlet weak var diplayDataHere: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        dataManager = appDelegate.persistentContainer.viewContext
        diplayDataHere.text?.removeAll()
        fetchData()
        
    }

    func fetchData() {
        let  fetchRequest : NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Item")
        do {
            let result = try dataManager.fetch(fetchRequest)
            listArray = result as! [NSManagedObject]
            for item in listArray {
                
                let product = item.value(forKey: "about") as! String
                diplayDataHere.text! += product
            }
        } catch {
            print("Error retrieving data")
        }
    }

    
    
    
    
    
    
    
    
    

}

