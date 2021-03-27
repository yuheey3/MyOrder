//
//  CartCell.swift
//  YukiWaka_MyOrder
//  Created by Yuki Waka on 2021-02-18.
//  Student# : 141082180
//  Date : Feb 19.2021
//

import UIKit

class CartCell: UITableViewCell {
    @IBOutlet var lblType : UILabel!
    @IBOutlet var lblSize : UILabel!
    @IBOutlet var lblQty : UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}


