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
    var mContentID : Int?           // Content ID
    
}

// Structure for Content View
struct ContentView
{
    var mNumberOfViews : Int?       // Total views of content
    var mNumberOfParticipant : Int? // Total participant of Content
    var mLastViewedDate : String?   // last viewed time of Content
    var mActionPerformed : String?  // shows which action has been last performed on Content
    var mContentID : Int?           // Content ID

}



class ContentListController
{
 
    // for Unit Test
    var mIsUnitTest : Bool = true
    
    
    //create object REST service handler
    var mContentListRestServiceHandler : ContentListRestServiceHandler?
    
    // create object of Database handler
    var mContentListDBHandler : ContentListDBHandler?
    
    // object for ContentInfo Structure
    var mContentInfo = [ContentInfo]()
   
    
    var test = ContentView()
    
    
    
    
    // object for ContentView Structure
    var mContentView = [ContentView]()
    
    
    
    init()
    {
        // Populate Dummy data if it is in Test
        if(mIsUnitTest)
        {
            populateDummyContentData()
        }
        

    }
    
    // Populate Dummy content data calling from Controller
    func populateDummyContentData()
    {
        setContentInfo()
        setContentView()
    }
    
    
    //Populate Dummy data for ContentInfo
    func setContentInfo()
    {
     
        let dummyData1 = ContentInfo(mContentImage:  "/Users/BridgeLabz/Documents/komal/ShoppingPad/b.jpg", mContentTitle: "Sofa", mContentID: 1)
        
        let dummyData2 = ContentInfo(mContentImage:  "/Users/BridgeLabz/Documents/komal/ShoppingPad/A.jpg", mContentTitle: "Bed", mContentID: 4)
        
        mContentInfo.append(dummyData1)
        mContentInfo.append(dummyData2)
        
    }
    
    
    //Populate Dummy data for ContentView
    func setContentView()
    {
        let dummyData1 = ContentView(mNumberOfViews: 2, mNumberOfParticipant: 4, mLastViewedDate: "22 Feb 2016", mActionPerformed: "Opened",mContentID: 1)
        
        let dummyData2 = ContentView(mNumberOfViews: 5, mNumberOfParticipant: 1, mLastViewedDate: "03 March 2016", mActionPerformed: "Clicked",mContentID: 4)
        
         let dummyData3 = ContentView(mNumberOfViews: 5, mNumberOfParticipant: 1, mLastViewedDate: "03 March 2016", mActionPerformed: "Clicked",mContentID: 5)
        
        mContentView.append(dummyData1)
        mContentView.append(dummyData2)
        mContentView.append(dummyData3)
    }

    
    
    // This method will be called from ViewModel
    func getContentData(userId : Int) ->(info : [ContentInfo], views : [ContentView])
    {
        
        // return Content info and Content View to View Model
        // which will set it to ContentViewModel
        return(mContentInfo, mContentView)
    }
    
    
    // return number of content in ContentInfo
    // This method will be called from ViewModel
    func contentViewModelCount() -> Int
    {
       return mContentInfo.count
    }
}