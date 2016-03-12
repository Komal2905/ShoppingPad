//
//  ContentListRestServiceHandler.swift
//  ShoppingPad
//
//  Purpose: REST call is handle here and retrive JSON from that. Resulting JSON is
//           passed to ContentListController.
//
//  Created by Vidya Ramamurthy on 06/03/16.
//  Copyright © 2016 BridgeLabz. All rights reserved.
//

import UIKit


struct ContentInfoRest
{
    var mContentImage : String?     // Thumbview Image link of the Content
    var mContentTitle : String?     // Title of Content
    var mContentID : Int?           // Content ID

}

// Structure for Content View
struct ContentViewRest
{
    var mNumberOfViews : Int!       // Total views of content
    var mNumberOfParticipant : Int! // Total participant of Content
    var mLastViewedDate : String!  // last viewed time of Content
    var mActionPerformed : String!  // shows which action has been last performed on Content
    var mContentID : Int!           // Content ID
    
}


class ContentListRestServiceHandler
{
    // for Unit Test
    var mIsUnitTest : Bool = true
    
    var jsonContentView = NSMutableArray()
    var jsonContentInfo = NSMutableArray()
    
    // create Array of ContentInfoRest for dummy data
     var mContentInfoRest = [ContentInfoRest]()
    
    
    // create Array of ContentViewRest for dummy data
    var mContentViewRest = ContentViewRest()
    var mContentViewRestB = ContentViewRest()
    var mContentViewRestA = [ContentViewRest]()
    
    
    init()
    {
        // Populate Dummy data if it is in Test
        if(mIsUnitTest)
        {
            populateDummyContentData()
        }
        
        else
        {
            populateContentData()
 
        }

    }
    
    
    // populate dummy data for controller in Rest Handler
    func populateDummyContentData()
    {
        setContentInfoRest()
        setContentViewRest()
    }
    
    
    // set dummy ContentView Data
    func setContentViewRest()
    {
        // Json Array define for ContentView
         jsonContentView = [["contentId" : 1 , "mActionPerformed" : "opened" , "mNumberOfParticipant" : 23 , "mNumberOfViews" : 24 , "mLastViewedDate" : "29 May 2015"],["contentId" : 2 , "mActionPerformed" : "Clicked" , "mNumberOfParticipant" : 11 , "mNumberOfViews" : 11 , "mLastViewedDate" : "30 May 2015"]]

        
    }
    
    
    // set dummy ContentInfo Data
    func setContentInfoRest()
    {
         // Json Array define for ContentInfo
         jsonContentInfo = [["contentTitle" : "Sofa" , "contentId" : 1 , "contentImagePath" : "/Users/BridgeLabz/Documents/komal/ShoppingPad/b.jpg"] , ["contentTitle" : "Bed" , "contentId" : 2 , "contentImagePath" : "/Users/BridgeLabz/Documents/komal/ShoppingPad/A.jpg"]]
    }
    
    
    // This function will be calling from ContentListController
    func getContentData() -> (info :NSMutableArray, view : NSMutableArray)
    {
        return(jsonContentInfo,jsonContentView)
    }
    
    
    // return number of data in ContentInfo
    func countContentInfoRest() -> Int
    {
        return mContentInfoRest.count
    }
  
    
    // here main REST call to URL
    // populate JSon and send it to Controller
    func populateContentData() ->(info : NSArray, view : NSArray)
     {
 
        // declare Dummy Jason String

        let jsonContentInfo = "[{\"contentId\":\"01\", \"contentTitle\":\"Gopal Varma\",\"contentImagePath\":\"00\"}]"
        
        let jsonContentView = " [{\"contentId\":\"01\", \"mNumberOfViews\":\"2\", \"mNumberOfParticipant\":\"00\", \"mLastViewedDate\":\"Today\", \"mActionPerformed\":\"Opened\", \"contentId\":\"01\"}]"
        

        // Convert json Strong To Data
        let data1 = jsonContentInfo.dataUsingEncoding(NSUTF8StringEncoding)
        
        let data2 = jsonContentView.dataUsingEncoding(NSUTF8StringEncoding)

        // define 2 Array
        var contentInfoJsonArray = NSArray?()
        var contentViewJsonArray = NSArray?()
        
        
        do
        {
            // Read data form jason and add it to Dictionary
            contentInfoJsonArray = try NSJSONSerialization.JSONObjectWithData(data1!, options: NSJSONReadingOptions.MutableContainers) as? NSArray
            
            
            print("contentJsonArray", contentInfoJsonArray)
            
            contentViewJsonArray = try NSJSONSerialization.JSONObjectWithData(data2!, options: NSJSONReadingOptions.MutableContainers) as? NSArray
            
           
        }
        catch
        {
            print("Some Problem ")
        }
        
        // return Array
        return(contentInfoJsonArray!, contentViewJsonArray!)
        
     }
    

}
