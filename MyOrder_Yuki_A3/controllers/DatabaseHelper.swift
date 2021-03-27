//
//  DatabaseHelper.swift
//  MyOrder_Yuki_A3
//
//  Created by Yuki Waka on 2021-03-26.
//

import Foundation
import CoreData
import UIKit

class DatabaseHelper{
    
    //singleton instance
    private static var shared : DatabaseHelper?
    
    static func getInstance() -> DatabaseHelper{
        
        if shared != nil{
            //instance already exists
            return shared!
        }else{
            //create a new singleton instance
            return DatabaseHelper(context: (UIApplication.shared.delegate as! AppDelegate)
                                    .persistentContainer.viewContext)
        }
    }
    
    private let moc : NSManagedObjectContext
    private let ENTITY_NAME = "MyOrder"
    
    private init (context : NSManagedObjectContext){
        self.moc = context
    }
    //insert
    
    //update
    
    //delete
    
    
    //retrieve all orders
    func getAllOrders() -> [MyOrder]?{
        let fetchRequest = NSFetchRequest<MyOrder>(entityName: ENTITY_NAME)
        fetchRequest.sortDescriptors = [NSSortDescriptor.init(key: "date", ascending: true )]
        
        do{
            //execute the request
            let result = try self.moc.fetch(fetchRequest)
            
            print(#function, "Fetched data : \(result as [MyOrder])")
            
            //return the fetched objects after conversion to MyOrder objects
            return result as [MyOrder]
            
            
        }catch let error as NSError{
            print("Could not fetch data \(error) \(error.code)")
        }
        //no data retrieved
        return nil
    }
}
    
