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

import ReactiveKit
import ReactiveUIKit
import ReactiveFoundation


class ContentListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, PContentListViewObserver
{
    @IBOutlet weak var tableView: UITableView!

    
    @IBOutlet weak var activityIndiactor: UIActivityIndicatorView!
    
    // use Utility class function for Round Image
    var util = Util()
    
    //create CustomCell Object for Table Cell
    var customCell : CustomCell = CustomCell()
    
    
    // contentListViewModel is type of ContentListViewModel. It can be null or hold any value.
    var mContentListViewModel : ContentListViewModelHandler?

    
    
    var contentViewModel : ContentListViewModel?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        activityIndiactor.startAnimating()
        
        // call init() of ContentListViewModel
        mContentListViewModel = ContentListViewModelHandler(pContentListViewObserver: self)
        
        // populate content list model
        mContentListViewModel!.populateContentViewModelData()
        
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
        return (mContentListViewModel!.mListOfViewModel.count)
        
    }
    
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        customCell = tableView.dequeueReusableCellWithIdentifier("cell") as! CustomCell
        
        //accept multiple line to text field
        util.multiLineLabel(customCell.mContentLastViewedDate)
        
        // set value to outlet of CustomCell
        // call getContentViewModel function in ViewModel for respective list
        contentViewModel = (mContentListViewModel?.getContentViewModel(indexPath.row))! as  ContentListViewModel
        
        //set content's Title label
        customCell.mContentTitleLabel.text = contentViewModel!.mContentTitle.value
        
        // set content's action label
        customCell.mContentActioLabel.text = contentViewModel!.mActionPerformed.value
        
        // set content's last viewed date
        customCell.mContentLastViewedDate.text = contentViewModel!.mLastViewedDate.value
 
        
        // Uncomment following In ViewModel is All STRING
        print(String(contentViewModel!.mNumberOfParticipant.value) + " Participants")
        //set content's participant count Lable
        customCell.mContentParticipantLabel.text = String(contentViewModel!.mNumberOfParticipant.value) + " Participants"
        
        //set content's view count Lable
        customCell.mContentViewLabel.text = (String(contentViewModel!.mNumberOfViews.value) + " Views ")
        
        // call Util method for round imageview
        util.roundImage(customCell.mContentImageView)
        
        
        customCell.mContentImageView.image = UIImage(named: contentViewModel!.mContentImage.value)
 
        self.bind()
        return customCell
        
    }
   
    //for binding Varible with Outlet
    func bind()
    {
        //bind.mContentTitleLabel Label with contentViewModel!.mContentTitle
        contentViewModel!.mContentTitle.bindTo(customCell.mContentTitleLabel)
        
        
        //bind mContentLastViewedDate Label with contentViewModel!.mLastViewedDate
        contentViewModel!.mLastViewedDate.bindTo(customCell.mContentLastViewedDate)
        
        
        //bind mContentActioLabel Label with contentViewModel!.mActionPerformed
        contentViewModel!.mActionPerformed.bindTo(customCell.mContentActioLabel)
        
        //bind mNumberOfParticipant with contentViewModel!.mContentParticipantLabel
        
        contentViewModel!.mNumberOfParticipant.bindTo(customCell.mContentParticipantLabel)
        
        // bind NumberOfViews to ViewsLabel
        contentViewModel?.mNumberOfViews.bindTo(customCell.mContentViewLabel)
        
    }
    
    // implemeeting protocol ContentListViewObserver
    func  updateContentListViewModel()
    {
        //tranfer to main thred for asychThred
        dispatch_async(dispatch_get_main_queue()) { [unowned self] in
        
            // reload table
            self.tableView.reloadData()
            
            //Stop Activity Indicator
            self.activityIndiactor.stopAnimating()
            self.activityIndiactor.hidesWhenStopped = true
           
        }
        
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
