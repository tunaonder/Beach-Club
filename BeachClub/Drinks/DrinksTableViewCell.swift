//
//  DrinksTableViewCell.swift
//  BeachClub
//
//  Created by Tuna Onder on 12/6/15.
//  Copyright © 2015 Tuna Onder. All rights reserved.
//

import UIKit

class DrinksTableViewCell: UITableViewCell {

    @IBOutlet var drinkImageView: UIImageView!
    
    @IBOutlet var productNameLabel: UILabel!
    @IBOutlet var productIngredientLabel: UILabel!
    @IBOutlet var productPriceLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
