//
//  CustomeCell.swift
//  ShoppingPad
//
//  Purpose : This define Custome cell for tableView
//
//  Created by Vidya Ramamurthy on 06/03/16.
//  Copyright © 2016 BridgeLabz. All rights reserved.
//

import UIKit

class CustomCell: UITableViewCell {
    
    
    // Create outlet
    @IBOutlet weak var contentTitleLabel: UILabel!
    @IBOutlet weak var contentActioLabel: UILabel!
    @IBOutlet weak var contentParticipantLabel: UILabel!
    @IBOutlet weak var contentViewLabel: UILabel!
    @IBOutlet weak var contentLastViewedDate: UILabel!
    @IBOutlet weak var contentImageView: UIImageView!
    
    
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
