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
    var mLastViewedDate : String!   // last viewed time of Content
    var mActionPerformed : String!  // shows which action has been last performed on Content
    var mContentID : Int!           // Content ID
    
}


class ContentListRestServiceHandler
{
    // for Unit Test
    var mIsUnitTest : Bool = false
    
    // json array for ContentView
    var jsonContentView = NSMutableArray()
    
    // json array for contentInfo
    var jsonContentInfo = NSMutableArray()
    
    //json Array for ContentParticipant
    var jsonContentParticipants = NSMutableArray()
    

    
    // create Array of ContentInfoRest for dummy data
    var mContentInfoRest = [ContentInfoRest]()

    // create Array of ContentViewRest for dummy data
    var mContentViewRest = ContentViewRest()

    
    
    init()
    {
        // Populate Dummy data if it is in Test
        if(mIsUnitTest)
        {
            populateDummyContentData()
            
            // Populate dummy data for ContentINFO REST
            populateContentDetailsDummy()
        }
        
//        else
//        {
//           populateContentInfoData()
//
//        }

    }
    
    
    // Populate ContentInfo From Rest call
    func populateContentInfoData(pContentListListener : PControllerListener)
    {
      // define StringURL
        let urlString = "http://54.86.64.100:3000/api/v4/content/info"
        
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
                    
                    // callback to controller protocol
                    pContentListListener.updateControllerInfoModel(self.jsonContentInfo)
                }
                
                catch
                {
                   print("Something Went Wrong in REST")
                }
                
            }
            
        }).resume()

    }
    
    // Populate ContentInfo From Rest call
    func populateContentViewData(pContentListListener : PControllerListener)
    {
        // define StringURL
        let urlString = "http://54.86.64.100:3000/api/v4/content/View"
        
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
                    
                    //pass ContentView To Protocol
                    pContentListListener.updateControllerViewModel(self.jsonContentView)
                    
                }
                
                catch
                {
                    print("Something Went Wrong in REST")
                    
                }
                
            }
            
        }).resume()
      
    }
    
    
  // Function get all participant for content
func getParticipantDetails(pContentParticipantListener : PControllerListener, content : Int)
{
    // post parameter
    let postParams : [Int] = [content]
    
    //url String
    let postEndpoint: String = "http://54.86.64.100:3000/api/v4/content/\(postParams[0])/participant/"
    
    print("postEndpoint",postEndpoint)
    // convert string to NSURL
    let url = NSURL(string: postEndpoint)!
            
    // establish seesion
    let session = NSURLSession.sharedSession()
            
    // Create the request
    let request = NSMutableURLRequest(URL: url)
            
    // HTTP Post
    request.HTTPMethod = "POST"
            
    request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
            
    do
    {
        // write json
        request.HTTPBody = try NSJSONSerialization.dataWithJSONObject(postParams, options: NSJSONWritingOptions())
        
    }
    catch
    {
        print("bad things happened")
    }
            
    // Make the POST call and handle it in a completion handler
    // make a Request
    session.dataTaskWithRequest(request, completionHandler: { ( data: NSData?, response: NSURLResponse?, error: NSError?) -> Void in
        // Make sure we get an OK response
    guard let realResponse = response as? NSHTTPURLResponse where
    realResponse.statusCode == 200
        
        else
        {
            print("Not a 200 response")
            return
        }
                
        // Read the JSON and append it to jsonContentParticipants
        
        do
        {
            // Convert NSData to Dictionary where keys are of type String, and values are of any type
            self.jsonContentParticipants = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as! NSMutableArray
            
            // call back to ContentInfoController
            pContentParticipantListener.updateContentParticipant(self.jsonContentParticipants )
        }
            
        catch
        {
            print("Something Went Wrong in REST")
            
        }

    }).resume()
            
            
}
        
    

    
    
    // populate Dummy COntentDeatils and COntentParticipant for COntentInfo
    func populateContentDetailsDummy()
    {
        print("jsonContentInfo",jsonContentInfo)
        jsonContentInfo = [["content_id" : 1 , "display_name" : "opened"],["content_id" : 2 , "display_name" : "Clicked"],["content_id" : 3 , "display_name" : "Shared000"]]
        
        jsonContentView =  [["contentId" : 1 , "action" : "opened" , "mNumberOfParticipant" : 23 , "numberOfViews" : 24 , "lastViewedDateTime" : "29 May 2015", "displayProfile" :"Display","userId" : 2,"firstName" :"myName1"],["contentId" : 2 , "action" : "opened" , "mNumberOfParticipant" : 23 , "numberOfViews" : 24 , "lastViewedDateTime" : "30 May 2015", "displayProfile" :"Display","userId" : 2,"firstName" :"myName2"],["contentId" : 3 , "action" : "opened" , "mNumberOfParticipant" : 23 , "numberOfViews" : 24 , "lastViewedDateTime" : "31 May 2015", "displayProfile" :"Display","userId" : 3,"firstName" :"myName3"]]
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
        
    
    }


}
