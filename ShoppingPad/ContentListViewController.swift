//
//  ContentListViewController.swift
//  ShoppingPad
//
//  Purpose :
//  1)  This class is View of MVVM design pattern
//  2)  It is main UI class. It has outlet and action
//  3)  It listen to action
//  4)  It implement Observer pattern and update UIView
//  5)  It hold ContentListViewModel state. It reflect the changes
//      in UIView accroding to state of ContentListViewModel

//  Created by Vidya Ramamurthy on 06/03/16.
//  Copyright © 2016 BridgeLabz. All rights reserved.
//

import UIKit


class ContentListViewController: UIViewController, ContentListViewObserver, UITableViewDataSource, UITableViewDelegate
{
    // use Utility class function for Round Image
    var util = Util()
    
    
    //create CustomCell Object for Table Cell
    var customCell : CustomCell = CustomCell()
    
    
    // contentListViewModel is type of ContentListViewModel. It can be null or hold any value.
    var mContentListViewModel : ContentListViewModel?

    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        // call init() of ContentListViewModel
        mContentListViewModel = ContentListViewModel()
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
      
    }
    
    
    // define number of row in section
    func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return 1
    }
    
    
    // define number of row
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        
        return 2
    }
    
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        customCell = tableView.dequeueReusableCellWithIdentifier("cell") as! CustomCell
        
        
        // set value to outlet of CustomCell
        // call getContentViewModel function in ViewModel for respective list
        let contentViewModel = (mContentListViewModel?.getContentViewModel(indexPath.row))! as  ContentViewModel
        

        
        //set content's Title label
        customCell.mContentTitleLabel.text = contentViewModel.mContentTitle!
        
        // set content's action label
        customCell.mContentActioLabel.text = contentViewModel.mActionPerformed!
        
        // set content's last viewed date
        customCell.mContentLastViewedDate.text = contentViewModel.mLastViewedDate!
        
        //set content's participant count Lable
        customCell.mContentParticipantLabel.text = String(format :"%d" ,contentViewModel.mNumberOfParticipant!) + " Participants"
        
        //set content's view count Lable
        customCell.mContentViewLabel.text = String(format: "%d", contentViewModel.mNumberOfViews!) + " Views "
        
        // call Util method for round imageview
        util.roundImage(customCell.mContentImageView)
        
        
        customCell.mContentImageView.image = UIImage(named: contentViewModel.mContentImage!)
        
        return customCell
        
    }
   

    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        showAlertController("Cell Selected")
    }
    
    // This function declare AlertController and its action
    func showAlertController(message : String)
    {
        
        // create alert controller
        let alertController = UIAlertController(title: "Result", message:message, preferredStyle: .Alert)
        
        // create action for for alert controller
        let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
        
        //add action to alert controller
        alertController.addAction(defaultAction)
        
        // show alertController in main view
        presentViewController(alertController, animated: true, completion: nil)
    }
    
    
    
    // When Share button on cell is pressed this Action calls.
    // This will show alert box stating that button has been pressed
    @IBAction func mShareButtonPressed(sender: AnyObject)
    {
        
        showAlertController("Share button pressed")
    }
    

    
    // this button is on imageView. 
    // when clicked this button it will show large imageView
    @IBAction func mShowLargeImage(sender: AnyObject)
    {
        
        showAlertController("Large Image will be here")

    }
    
    
}
