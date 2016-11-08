//
//  EventsTableViewCell.swift
//  BeachClub
//
//  Created by Tuna Onder on 11/21/15.
//  Copyright © 2015 Tuna Onder. All rights reserved.
//

import UIKit

class EventsTableViewCell: UITableViewCell {

    @IBOutlet var eventImageView: UIImageView!
    @IBOutlet var eventDateLabel: UILabel!
    @IBOutlet var eventArtistLabel: UILabel!
    @IBOutlet var eventTimeLabel: UILabel!
    @IBOutlet var eventFeeLabel: UILabel!

    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
