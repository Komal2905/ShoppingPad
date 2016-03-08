//
//  ContentListController.swift
//  ShoppingPad
//
//  Purpose:
//  1) Intract with REST service to get data.
//  2) Intract with Local DB to save and retrive content data.
//  3) encapusulating ContentInfo.
//  4) Data controller in MVVM architecture
//  5) Provide interface of View Model to intract with controller. Abstracting Database layer,
//     service layer and model layer.
//
//
//  Created by Vidya Ramamurthy on 06/03/16.
//  Copyright © 2016 BridgeLabz. All rights reserved.
//

import UIKit


// Structure holding ContentInfo
struct ContentInfo
{
    var mContentImage : String?     // Thumbview Image link of the Content
    var mContentTitle : String?     // Title of Content
    
}

// Structure for Content View
struct ContentView
{
    var mNumberOfViews : Int?       // Total views of content
    var mNumberOfParticipant : Int? // Total participant of Content
    var mLastViewedDate : String?   // last viewed time of Content
    var mActionPerformed : String?  // shows which action has been last performed on Content
}



class ContentListController
{
 
    
    //create object REST service handler
    var mContentListRestServiceHandler : ContentListRestServiceHandler?
    
    // create object of Database handler
    var mContentListDBHandler : ContentListDBHandler?
    
    // object for ContentInfo Structure
    var mContentInfo = [ContentInfo]()
    
    
    // object for ContentView Structure
    var mContentView = [ContentView]()
    
    
    
    init()
    {
        print("Controller init")
        
        //Populate Dummy data for ContentInfo and ContentView
        setContentInfo()
        
        setContentView()
        
        //populateDummyContentData()

    }
    
   
    
    func setContentInfo()
    {
     
        let dummyData1 = ContentInfo(mContentImage:  "/Users/BridgeLabz/Documents/komal/ShoppingPad/b.jpg", mContentTitle: "Sofa")
        
        let dummyData2 = ContentInfo(mContentImage:  "/Users/BridgeLabz/Documents/komal/ShoppingPad/b.jpg", mContentTitle: "Sofa")
        
        mContentInfo.append(dummyData1)
        mContentInfo.append(dummyData2)
    }
    
    
    func setContentView()
    {
        let dummyData1 = ContentView(mNumberOfViews: 2, mNumberOfParticipant: 4, mLastViewedDate: "22 Feb 2016", mActionPerformed: "Opened")
        
        let dummyData2 = ContentView(mNumberOfViews: 2, mNumberOfParticipant: 4, mLastViewedDate: "22 Feb 2016", mActionPerformed: "Opened")
        
        mContentView.append(dummyData1)
        mContentView.append(dummyData2)
    }
    
    
    
    // This method will be called from ViewModel
    func getContentData(position : Int) ->(info : ContentInfo, views : ContentView)
    {
       return(mContentInfo[position], mContentView[position])
    }
    
    
    
    
    // Populate Dummy content data calling from ViewModel
    func populateDummyContentData()->ContentViewModel
    {
        print("Inside Dummy content Data in controller")
        
        let dummyData1 = ContentViewModel(mContentImage: "/Users/BridgeLabz/Documents/komal/ShoppingPad/b.jpg", mContentTitle: "Sofa", mNumberOfViews: 1, mNumberOfParticipant: 2, mLastViewedDate: "22 Feb 2016", mActionPerformed: "Viewed")
        
        
        return dummyData1

    }

}
