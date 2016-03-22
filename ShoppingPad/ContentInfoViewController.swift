//
//  ContentInfoViewController.swift
//  ShoppingPad

//  1)  This class holds information of perticular Content and its participant
//  2)  This class is View of MVVM design pattern For ContentInfo
//  3)  It is main UI class. It has outlet and action
//  4)  It listen to action
//  5)  It hold ContentInfoViewModel state. It reflect the changes
//      in UIView accroding to state of ContentListViewModel
//
//  Created by Vidya Ramamurthy on 21/03/16.
//  Copyright © 2016 BridgeLabz. All rights reserved.
//

import UIKit

class ContentInfoViewController: UIViewController,UITableViewDataSource, UITableViewDelegate
{
    
    // outlet for content Info Image View
    @IBOutlet weak var contentInfoImageView: UIImageView!
    
    //oultet of contentDetailTableView
    @IBOutlet weak var contentDetailTableView: UITableView!
    
    //outlet for participantTable which hold all participant for 
    // perticular content
    @IBOutlet weak var participantTable: UITableView!
    
    // use Utility class function for Round Image
    var util = Util()
    
    
    //create CustomCell Object for Table Cell
    var customCell : CustomCell = CustomCell()
    
    // create object of ContentInfoViewModelHandler
    var mContentInfoViewModelHandler : ContentInfoViewModelHandler!
    
    //create object of ContentInfoViewModelDummy for DummyData
    //var mContentInfoViewModelDummy : ContentInfoViewModelDummy!
    
    //create object of ContentInfoViewModel of ViewModel
    var mContentInfoViewModel : ContentInfoViewModel!

    
    override func viewDidLoad()
    {
         super.viewDidLoad()
        // create ContentImagevIew round shape
        util.roundImage(contentInfoImageView)
        
        // call constructor of ContentInfoViewModelHandler
        mContentInfoViewModelHandler = ContentInfoViewModelHandler()
        
       

        
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // define number of row in section
    func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return 1
    }
    
    // define number of row
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        let numberOfrow : Int!
        if (tableView == contentDetailTableView )
        {
            numberOfrow = 3
        }
        else
        {
            numberOfrow = 3
        }
        return numberOfrow
        
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        // check if table is contentDetailTableView
        if tableView == contentDetailTableView
        {
            // if indexpath is 0 then Media cell
            if indexPath.row == 0
            {
                // construct cell with identifier mediaCell
                customCell = contentDetailTableView.dequeueReusableCellWithIdentifier("mediaCell") as! CustomCell
                
                // set value to allMediaLable
                customCell.allMediaLabel.text = "All Media"
            
                // set value to mediaCountLabel
                customCell.mediaCountLabel.text = "SomeCount"
      
            }
            
            // if indexpath is 1 then Custome Notification Cell
            if indexPath.row == 1
            {
                // construct cell with identifier customNotificationCell
                customCell = contentDetailTableView.dequeueReusableCellWithIdentifier("customNotificationCell") as! CustomCell
                
                // set value to customeNotificationLabel
                customCell.customeNotificationLabel.text = "Custom Notification"
                
                //set cell's accesspryType
                customCell.accessoryType = .DisclosureIndicator
                
            }
            
            // if indexpath is 2 then Mute cell
            if indexPath.row == 2
            {
                 // construct cell with identifier muteCell
                customCell = contentDetailTableView.dequeueReusableCellWithIdentifier("muteCell") as! CustomCell
                
                customCell.muteLabel.text = "Mute"
 
            }
            
            
        }
        
    
       
        // check for participant details table
        if tableView == participantTable
        {
            
            //get ContentInfo dummy data fro each cell
            mContentInfoViewModel =  mContentInfoViewModelHandler!.getContentInfoViewModel(indexPath.row)
            
            print("IndexPAth",indexPath.row)
             // construct cell with identifier participantCell
            customCell = participantTable.dequeueReusableCellWithIdentifier("participantCell") as! CustomCell
            
            // set value of lable participantNameLabel
            customCell.participantNameLabel.text = mContentInfoViewModel.mParticipantName.value
            
            // set value of lable participantNameLabel
            customCell.participantLastActionLabel.text = mContentInfoViewModel.mParticipantAction.value
            
            // set value of lable participantNameLabel
            customCell.participantLastViewDateLabel.text = mContentInfoViewModel.mParticipantLastOpenedDate.value
            
            customCell.participantViewCountLabel.text = mContentInfoViewModel.mParticipantViewCount.value
            
            // create round profile Image of participant
            util.roundImage(customCell.participantProfileImageView)
            
            
        }
        
        return customCell
    }


}
