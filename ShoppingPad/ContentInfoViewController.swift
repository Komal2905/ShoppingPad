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

class ContentInfoViewController: UIViewController,UITableViewDataSource, UITableViewDelegate,PContentParticipantViewObserver
{
    
    // outlet for content Info Image View
    @IBOutlet weak var contentInfoImageView: UIImageView!
    
    
    @IBOutlet weak var contentTitleLabel: UILabel!
    
    
    //oultet of contentDetailTableView
    @IBOutlet weak var contentDetailTableView: UITableView!
    
    //outlet for participantTable which hold all participant for 
    // perticular content
    @IBOutlet weak var participantTable: UITableView!
    
    // use Utility class function for Round Image
    var util = Util()

    //ContentTitle fromsegue
    var mContentTitle = String()
    
    // ContentId From segue
    var mContentId = Int()
   
    //create CustomCell Object for Table Cell
    var customCell : CustomCell = CustomCell()
    
    // create object of ContentInfoViewModelHandler
    var mContentInfoViewModelHandler : ContentInfoViewModelHandler!
    
    //create object of ContentInfoViewModelDummy for DummyData
    //var mContentInfoViewModelDummy : ContentInfoViewModelDummy!
    
    //create object of ContentInfoViewModel of ViewModel
    var mContentInfoViewModel : ContentParticipantViewModel?

    
    override func viewDidLoad()
    {
         super.viewDidLoad()
        
        // create ContentImagevIew round shape
        util.roundImage(contentInfoImageView)
        
        
        
        // call constructor of ContentInfoViewModelHandler
        mContentInfoViewModelHandler = ContentInfoViewModelHandler(pContentParticipantViewObserver: self)

        
        // Strat Asyc Thread
        let qualityOfServiceClass = QOS_CLASS_BACKGROUND
        let backgroundQueue = dispatch_get_global_queue(qualityOfServiceClass, 0)
        
        dispatch_async(backgroundQueue, {
            print("This is run on the background queue")
            
            ///call ContentInfoViewModelHandler method and pass ContentId
            self.mContentInfoViewModelHandler.populateContentParticipantData(self.mContentId)
            
            // for DB
            self.mContentInfoViewModelHandler.getContentInfo(self.mContentId)
            
            
        })
        
        
        
        
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // This function will fetch ContentInfoData from LocalDB
    func getContentInfo(contentId : Int)
    {
        // call ViewModelHandler
        print("IN VIEWCONTROLLER")
        mContentInfoViewModelHandler.getContentInfo(contentId)
    }
    
    // updateContentListViewModelprotocol function
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
            numberOfrow = mContentInfoViewModelHandler.mContentInfoViewModelArray.count
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
            //get Content Info
            //mContentInfoViewModel = mContentInfoViewModelHandler!.getContentInfo(mContentId)
            
                       
            //get ContentInfo dummy data fro each cell
            mContentInfoViewModel =  mContentInfoViewModelHandler!.getContentInfoViewModel(indexPath.row)
            
             // construct cell with identifier participantCell
            customCell = participantTable.dequeueReusableCellWithIdentifier("participantCell") as! CustomCell
            
            // set value of lable participantNameLabel
            customCell.participantNameLabel.text = mContentInfoViewModel!.mParticipantName.value
            
            // set value of lable participantNameLabel
            customCell.participantLastActionLabel.text = mContentInfoViewModel!.mParticipantAction.value
            
            // set value of lable participantNameLabel
            customCell.participantLastViewDateLabel.text = mContentInfoViewModel!.mParticipantLastOpenedDate.value
            
            customCell.participantViewCountLabel.text = mContentInfoViewModel!.mParticipantViewCount.value
            
            // set Lable value
            self.contentTitleLabel.text = mContentInfoViewModel?.mContentTitle.value
            
            // set Imageview
            // create round profile Image of participant
            util.roundImage(customCell.participantProfileImageView)
           
            
            //print("HELLLO",(mContentInfoViewModel!.mContentImage.value))
            let mParticipnatImage = util.getImage((mContentInfoViewModel!.mParticipantImageView.value))
            
            
            customCell.participantProfileImageView.image = mParticipnatImage
           
        }
        
        return customCell
    }


    // function of  PContentParticipantViewObserver
    
    func updateContentInfoViewModel()
    {
        //tranfer to main thred for asychThred
        dispatch_async(dispatch_get_main_queue())
        { [unowned self] in
                self.contentDetailTableView.reloadData()
                self.participantTable.reloadData()
        }
    }
   
}
