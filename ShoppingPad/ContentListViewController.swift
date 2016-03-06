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
    
    
    // contentListViewModel is type of ContentListViewModel. It can be null or hold any value.
    var mContentListViewModel : ContentListViewModel?

    
    //create CustomCell Object for Table Cell
    var customCell : CustomCell = CustomCell()
    
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
        
        //set Cell's Label
        customCell.contentTitleLabel.text = contentViewModel.mContentTitle!
        customCell.contentActioLabel.text = contentViewModel.mActionPerformed!
        customCell.contentLastViewedDate.text = contentViewModel.mLastViewedDate!
        customCell.contentParticipantLabel.text = String(format :"%d" ,contentViewModel.mNumberOfParticipant!) + " Participant"
        customCell.contentViewLabel.text = String(format: "%d", contentViewModel.mNumberOfViews!)
        
        
        util.roundImage(customCell.contentImageView)
        customCell.contentImageView.image = UIImage(named: contentViewModel.mContentImage!)
        
        return customCell
        
    }
    

}
