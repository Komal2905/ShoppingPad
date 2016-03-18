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
    var mIsUnitTest : Bool = false
    
    var jsonContentView = NSMutableArray()
    var jsonContentInfo = NSMutableArray()
    
    // create Array of ContentInfoRest for dummy data
     var mContentInfoRest = [ContentInfoRest]()
    
    
    // create Array of ContentViewRest for dummy data
    var mContentViewRest = ContentViewRest()

    
    init()
    {
        
        print("REST Constructor")
        // Populate Dummy data if it is in Test
        if(mIsUnitTest)
        {
            populateDummyContentData()
        }
        
//        else
//        {
//           populateContentInfoData()
//
//        }

    }
    
    
    // Populate ContentInfo From Rest call
    func populateContentInfoData(pContentListListener : PContentListListener)
    {
      // define StringURL
        let urlString = "http://54.165.130.78:3000/api/v4/contentinfo"
        
        //Convert String to URL
        let url = NSURL(string: urlString)
        
        //Session
        NSURLSession.sharedSession().dataTaskWithURL(url!, completionHandler:{
            (data,response,error) -> Void in
            
            if error == nil && data != nil
            {
                do
                {
                    // Convert NSData to Dictionary where keys are of type String, and values are of any type
                    self.jsonContentInfo = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as! NSMutableArray
                    
                    // Access specific key with value of type String
                    let Dict = self.jsonContentInfo [1]
                    
                    print ("INFO : Dictionary from REST",Dict)
                    
                    pContentListListener.updateControllerInfoModel(self.jsonContentInfo)

                    //pContentListListener.updateControllerInfoModel(self.jsonContentInfo)
                    
                }
                
                catch
                {
                   print("Something Went Wrong in REST")
                }
                
            }
            
        }).resume()

    }
    
    // Populate ContentInfo From Rest call
    func populateContentViewData(pContentListListener : PContentListListener)
    {
        // define StringURL
        let urlString = "http://54.165.130.78:3000/api/v4/usercontentview"
        
        //Convert String to URL
        let url = NSURL(string: urlString)
        
        //Session
        NSURLSession.sharedSession().dataTaskWithURL(url!, completionHandler:{
            (data,response,error) -> Void in
            
            if error == nil && data != nil
            {
                do
                {
                    // Convert NSData to Dictionary where keys are of type String, and values are of any type
                    self.jsonContentView = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as! NSMutableArray
                    
                    // Access specific key with value of type String
                    let Dict = self.jsonContentView [1]
                    
                    print ("VIEW from REST",Dict)
                    
                    //pass ContentView To Protocol
                    pContentListListener.updateControllerViewModel(self.jsonContentView)
                    
                }
                
                catch
                {
                    print("Something Went Wrong in REST")
                    
                }
                
            }
            
        }).resume()
        
        
        
        print ("Dictionary from REST",jsonContentInfo)
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
    func populateContentData()// ->(info : NSArray, view : NSArray)
     {
        // call the json from server
        var json : NSMutableArray?
        
        print("1")
        
        NSURLSession.sharedSession().dataTaskWithURL(NSURL(string: "http://52.90.50.117:3046/api/v1/user_content_view")!, completionHandler: { (data, response, error) ->
            Void in
            
        print("2")
          
            
            // Check if data was received successfully
            if error == nil && data != nil
            {
                do
                {
                    // Convert NSData to Dictionary where keys are of type String, and values are of any type
                    let mJsonArrayInfo = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as! NSMutableArray
                    
                    print("mJsonArrayInfo",mJsonArrayInfo)
                    
                    // Access specific key with value of type String
                    
                }
                catch
                {
                    print("SOmehting went wrong")
                }
            }
        }).resume()
        print("3")
        
    
        /*
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
      */
        
     }


}
