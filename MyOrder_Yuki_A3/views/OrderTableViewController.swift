//
//  OrderTableViewController.swift
//  YukiWaka_MyOrder
//
//  Created by Yuki Waka on 2021-02-18.
//  Student# : 141082180
//  Date : Feb 19.2021
//

import UIKit

class OrderTableViewController: UITableViewController {
    
   // var orderList = Array<Order>()
    
    private let dbHelper = DatabaseHelper.getInstance()
    var orderList : [MyOrder] = [MyOrder]()
    
    override func viewDidLoad() {
        
        //fetch all the records and display in tableview
        self.fetchAllOrders()
        
        super.viewDidLoad()
        
        self.tableView.rowHeight = 80
        self.navigationItem.title = "Confirm Order"
        
        self.setUpLongPressGesture()
    
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.orderList.count
        //return 1
    }

   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell_cart", for: indexPath) as! CartCell
    
        // Configure the cell...
        if indexPath.row < orderList.count{
            
            let cartOrder = orderList[indexPath.row]
            cell.lblType.text = cartOrder.type
            cell.lblSize.text = cartOrder.size
            cell.lblQty.text = cartOrder.quantity
            
        }

        return cell
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {

        if (indexPath.row < self.orderList.count){
            //ask for the confirmation first

            self.deleteOrderFromList(indexPath: indexPath)
        }
    }
    
    private func displayCustomAlert(isNewTask : Bool, indexPath: IndexPath?, title: String, message: String){
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        if (indexPath != nil){
            alert.addTextField{(textField: UITextField) in
                textField.text = self.orderList[indexPath!.row].quantity
            }
            
        }
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: {_ in
            if let quantityText = alert.textFields?[0].text{
                
               if (indexPath != nil){
                    self.updateOrderInList(indexPath: indexPath!, quantity: quantityText)
                }
            }
        }))
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
    private func deleteOrderFromList(indexPath: IndexPath){
        //remove order from the list
        self.orderList.remove(at: indexPath.row)
        
        //delete the table row
        self.tableView.deleteRows(at: [indexPath], with: .automatic)
        self.tableView.reloadData()
    }
    
    private func updateOrderInList(indexPath: IndexPath, quantity: String){
        self.orderList[indexPath.row].quantity = quantity
       
        
        self.tableView.reloadRows(at: [indexPath], with: .automatic)
    }
    
    private func setUpLongPressGesture(){
        let longPressGesture: UILongPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress))
        
        longPressGesture.minimumPressDuration = 1.0 //1 second
        
        self.tableView.addGestureRecognizer(longPressGesture)
    }
    
    @objc
    private func handleLongPress(_ gestureRecognizer: UILongPressGestureRecognizer){
        if gestureRecognizer.state == .ended{
            let touchPoint = gestureRecognizer.location(in: self.tableView)
            
            if let indexPath = self.tableView.indexPathForRow(at: touchPoint){
                
                self.displayCustomAlert(isNewTask: false, indexPath: indexPath, title: "Edit quantity of order", message: "Please provide the updated quantity")
            }
        }
    }
        private func fetchAllOrders(){
            if(self.dbHelper.getAllOrders() != nil){
                self.orderList = self.dbHelper.getAllOrders()!
                self.tableView.reloadData()
            }else{
                print(#function, "No data received from dbHelper")
            }
        }
    
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
