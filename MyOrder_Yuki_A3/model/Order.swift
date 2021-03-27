//
//  Order.swift
//  YukiWaka_MyOrder
//  Created by Yuki Waka on 2021-02-18.
//  Student# : 141082180
//  Date : Feb 19.2021

import Foundation

struct Order{
   // var id : String = UUID().uuidString
    var type : String
    var size : String
    var quantity : String
 //   var date : Date
    var orderList = Array<Order>()
    
    init(){
  //      self.id = ""
        self.type = ""
        self.size = ""
        self.quantity = ""
 //       self.date = Date()
    }
   
    
    init(type : String, size : String, quantity : String){
        self.type = type
        self.size = size
        self.quantity = quantity
     //   self.date = Date()
    }
}


        


