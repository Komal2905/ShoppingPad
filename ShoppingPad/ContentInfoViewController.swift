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
import ReactiveKit
import ReactiveUIKit
import ReactiveFoundation


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
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
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
    var mContentParticipantViewModel : ContentParticipantViewModel!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.activityIndicator.startAnimating()
        // create ContentImagevIew round shape
        util.roundImage(contentInfoImageView)
    
        // call constructor of ContentInfoViewModelHandler
        mContentInfoViewModelHandler = ContentInfoViewModelHandler(pContentParticipantViewObserver: self)

        //mContentParticipantViewModel = ContentParticipantViewModel()
        
        // Strat Asyc Thread
        let qualityOfServiceClass = QOS_CLASS_BACKGROUND
        let backgroundQueue = dispatch_get_global_queue(qualityOfServiceClass, 0)
        
        dispatch_async(backgroundQueue, {
            print("This is run on the background queue")
            
            ///call ContentInfoViewModelHandler method and pass ContentId
            self.mContentInfoViewModelHandler.populateContentParticipantData(self.mContentId)
            
            })
        
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
            numberOfrow = mContentInfoViewModelHandler.mContentParticipantViewModelArray.count
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
            // set contentLabl
            
            //get ContentInfo  data for each cell
            mContentParticipantViewModel =  mContentInfoViewModelHandler!.getContentInfoViewModel(indexPath.row)
            
             // construct cell with identifier participantCell
            customCell = participantTable.dequeueReusableCellWithIdentifier("participantCell") as! CustomCell
            
            // Checking wheteher Participant table Has any value
             if(self.mContentInfoViewModelHandler.mContentParticipantViewModelArray[0].mParticipantId.value == "")
             {
                // hides ImageView and Button
                customCell.participantProfileImageView.hidden = true
                customCell.participantShare?.hidden = true
               
             }
            // bind ContentTitle
                //mContentParticipantViewModel!.mContentTitle.bindTo(self.contentTitleLabel)
            
            // create round profile Image of participant
            util.roundImage(customCell.participantProfileImageView)
            
            let mParticipnatImage = util.getImage((mContentParticipantViewModel!.mParticipantImageView.value))
            
            customCell.participantProfileImageView.image = mParticipnatImage
            
            
            // call data binding
            
            self.bind(customCell, contentParticipantViewModel: mContentParticipantViewModel!)
            
           
        }
        
        return customCell
    }

    
    //this function used for data binding
    
    func bind(customCell : CustomCell, contentParticipantViewModel : ContentParticipantViewModel )
    {
            // bind participant name
            contentParticipantViewModel.mParticipantName.bindTo(customCell.participantNameLabel)
        
            // bind participantAction
            contentParticipantViewModel.mParticipantAction.bindTo(customCell.participantLastActionLabel)
        
            // bind participant Last Action
            contentParticipantViewModel.mParticipantLastOpenedDate.bindTo(customCell.participantLastViewDateLabel)
        
            // bind  Participant Count
            contentParticipantViewModel.mParticipantViewCount.bindTo(customCell.participantViewCountLabel)
        
            
            //bind contentTitleLabel
            contentParticipantViewModel.mContentTitle.bindTo(self.contentTitleLabel)
        
            //bind ContentImageView
        
            let contentImageUrl = NSURL(string: contentParticipantViewModel.mContentTitle.value)
        
            // check URL null or not
            if(contentImageUrl != nil)
            {
                // call utility function for fetch image
                let contentImage : ObservableBuffer<UIImage>? = util.fetchImage(contentImageUrl!).shareNext()
            
                // check COntentImage Is Null
                if((contentImage) != nil)
                {
                    // bind ImageView
                
                    contentImage?.bindTo(self.contentInfoImageView)
                }
            }
           // contentParticipantViewModel.mParticipantImageView.bindTo(self.contentInfoImageView)

        
    }

    // function of  PContentParticipantViewObserver
    
    func updateContentInfoViewModel()
    {
        //tranfer to main thred for asychThred
        dispatch_async(dispatch_get_main_queue())
        { [unowned self] in
        
            self.activityIndicator.stopAnimating()
            self.activityIndicator.hidesWhenStopped = true
            self.participantTable.reloadData()
        }
    }
    
    
   
}
