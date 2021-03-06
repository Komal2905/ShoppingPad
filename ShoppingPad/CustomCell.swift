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
    
    
    // Create outlet for ContentListVIewController
    @IBOutlet weak var mContentTitleLabel: UILabel!
    
    @IBOutlet weak var mContentActioLabel: UILabel!
    
    @IBOutlet weak var mContentParticipantLabel: UILabel!
    
    @IBOutlet weak var mContentViewLabel: UILabel!
    
    @IBOutlet weak var mContentLastViewedDate: UILabel!
    
    @IBOutlet weak var mContentImageView: UIImageView!
    
    
    
// Outlet of COntentInfoViewController
    // outlet for ContentDetailsTable
    
    @IBOutlet weak var allMediaLabel: UILabel!

    @IBOutlet weak var mediaCountLabel: UILabel!
    
    @IBOutlet weak var customeNotificationLabel: UILabel!
    
    @IBOutlet weak var muteLabel: UILabel!
    
    // Outlet for ParticipantTable which holds details of participant
    
    
    @IBOutlet weak var participantProfileImageView: UIImageView!
    
    @IBOutlet weak var participantNameLabel: UILabel!
    
    
    @IBOutlet weak var participantLastActionLabel: UILabel!
    
    
    @IBOutlet weak var participantLastViewDateLabel: UILabel!
    
    @IBOutlet weak var participantViewCountLabel: UILabel!
    
    @IBOutlet weak var participantShare: UIButton!
    
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
