//
//  ViewController.swift
//  YukiWaka_MyOrder
//  Created by Yuki Waka on 2021-02-18.
//  Student# : 141082180
//  Date : Mar 27.2021

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var pkrType : UIPickerView!
    @IBOutlet var segSize : UISegmentedControl!
    @IBOutlet var quantity : UITextField!
    
    private let dbHelper = DatabaseHelper.getInstance()
 
   
    
    let typeList = ["Espresso","Americano","Latte","Cappuccino","Mocha","Vanilla"]
   // var orderList = Array<Order>()
   // var newOrder = Order()
    var orderList : [MyOrder] = [MyOrder]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = " My Order"
        
        let btnDisplayOrder = UIBarButtonItem(title: "Cart", style: .plain, target: self, action: #selector(performCart))
        
        self.navigationItem.setRightBarButton(btnDisplayOrder, animated: true)
        
        self.pkrType.dataSource = self
        self.pkrType.delegate = self
    
                // Do any additional setup after loading the view.
    }
  
    @objc
    func performCart()
    {
        self.navigationController?.popToRootViewController(animated: true)
        
        self.askConfirmation()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @IBAction func addOrder(){
        
        if(!self.quantity.text!.isEmpty){
            var newOrder = Order()
            newOrder.type = self.typeList[self.pkrType.selectedRow(inComponent: 0)]
            newOrder.size = self.segSize.titleForSegment(at: self.segSize.selectedSegmentIndex)!
            newOrder.quantity = quantity.text!
            
            self.dbHelper.insertOrder(newMyOrder: newOrder)
           
            //orderList.append(newOrder)
//
//            print(#function, "Type : \(newOrder.type) Size : \(newOrder.size) Qty :  \(newOrder.quantity)")
            
            let confirmAlert = UIAlertController(title: "Confirmation", message: "Your order is added!", preferredStyle: .actionSheet)
            
            confirmAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: {_ in
               
            }))
            self.present(confirmAlert,animated: true, completion: nil)
        }
        else{
            let errorAlert = UIAlertController(title: "Error", message: "Please enter the quantity", preferredStyle: .alert)
            errorAlert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
            self.present(errorAlert, animated: true, completion: nil)
        }
        
    }
   
    func askConfirmation(){
        let confirmAlert = UIAlertController(title: "Confirmation", message: "Would you like to see your cart?", preferredStyle: .actionSheet)
        
        confirmAlert.addAction(UIAlertAction(title: "Yes", style: .default, handler: {_ in
            self.goToDisplayScreen()
        }))
        
        confirmAlert.addAction(UIAlertAction(title: "No, I will order more.", style: .cancel, handler: nil))
        self.present(confirmAlert,animated: true, completion: nil)
    }
    
    func goToDisplayScreen(){
        
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let orderVC = storyboard.instantiateViewController(identifier: "OrderVC") as! OrderTableViewController
    
     //   orderVC.orderList = orderList
        self.navigationController?.pushViewController(orderVC, animated: true)
        
    }
    
  
}



extension ViewController : UIPickerViewDelegate, UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.typeList.count
        
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.typeList[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print(#function,"Selected Type : \(self.typeList[row])")
    }
    
    
}
