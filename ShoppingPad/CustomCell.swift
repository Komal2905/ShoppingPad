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
    @IBOutlet weak var mContentTitleLabel: UILabel!
    @IBOutlet weak var mContentActioLabel: UILabel!
    @IBOutlet weak var mContentParticipantLabel: UILabel!
    @IBOutlet weak var mContentViewLabel: UILabel!
    @IBOutlet weak var mContentLastViewedDate: UILabel!
    @IBOutlet weak var mContentImageView: UIImageView!
    
    
    
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
