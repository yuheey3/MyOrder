//
//  Order.swift
//  YukiWaka_MyOrder
//  Created by Yuki Waka on 2021-02-18.
//  Student# : 141082180
//  Date : Feb 19.2021

import Foundation

struct Order{
    var type : String
    var size : String
    var quantity : String
    var orderList = Array<Order>()
    
    init(){
        self.type = ""
        self.size = ""
        self.quantity = ""
    }
    
    init(type : String, size : String, quantity : String){
        self.type = type
        self.size = size
        self.quantity = quantity
    }
}

        


