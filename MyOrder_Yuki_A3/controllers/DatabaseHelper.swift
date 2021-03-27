//
//  DatabaseHelper.swift
//  MyOrder_Yuki_A3
//  Student# : 141082180
//  Date : Mar 27.2021
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
    func insertOrder(newMyOrder: Order){
        
        do{
            //try insert new record
            let orderTobeAdded = NSEntityDescription.insertNewObject(forEntityName: ENTITY_NAME, into: self.moc) as! MyOrder
            orderTobeAdded.type = newMyOrder.type
            orderTobeAdded.size = newMyOrder.size
            orderTobeAdded.quantity = newMyOrder.quantity
            orderTobeAdded.id = UUID()
            orderTobeAdded.date = Date()
            
            if self.moc.hasChanges{
                try self.moc.save()
                print(#function, "Data inserted successfully")
            }
            
        }catch let error as NSError{
            print(#function,"Could not save the data \(error)")
        }
    }
    //search
    func searchOrder(orderID : UUID) -> MyOrder?{
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: ENTITY_NAME)
        let predicateID = NSPredicate(format: "id == %@", orderID as CVarArg)
        fetchRequest.predicate = predicateID
        
        do{
            let result = try self.moc.fetch(fetchRequest)
            
            if result.count > 0{
                return result.first as? MyOrder
            }
            
        }catch let error as NSError{
            print("Unable to search order \(error)")
        }
        
        return nil
    }
    //update
    func updateOrder(updatedOrder: MyOrder){
        let searchResult = self.searchOrder(orderID: updatedOrder.id! as UUID)
        
        if(searchResult != nil){
            do{
                let orderToUpdate = searchResult!
                orderToUpdate.quantity = updatedOrder.quantity
                
                try self.moc.save()
                print(#function, "Order updated successfully")
                
            }catch let error as NSError{
                print(#function, "Unable to search order \(error)")
            }
        }
    }
    
    //delete
    func deleteOrder(orderID : UUID){
        let searchResult = self.searchOrder(orderID: orderID)
        
        if(searchResult != nil){
        //matching record found
            do{
                self.moc.delete(searchResult!)
               // try self.moc.save()
                
                let delegate = UIApplication.shared.delegate as! AppDelegate
                delegate.saveContext()
                
                print(#function, "Order deleted successfully")
            
               }catch let error as NSError{
                    print("Unable to delete order \(error)")
           
            }
        }
    }
    
    
    //retrieve all orders
    func getAllOrders() -> [MyOrder]?{
        let fetchRequest = NSFetchRequest<MyOrder>(entityName: ENTITY_NAME)
        fetchRequest.sortDescriptors = [NSSortDescriptor.init(key: "date", ascending: false )]
        
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
    
