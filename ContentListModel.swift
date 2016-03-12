//
//  ContentListModel.swift
//  ShoppingPad
//
//  Purpose : 1) Holds variable for ContentView Model 
//              2) Intialize its variable from datat which it got from COntroller
//
//  Created by Vidya Ramamurthy on 06/03/16.
//  Copyright © 2016 BridgeLabz. All rights reserved.
//

import UIKit


// class for ContentInfo
struct ContentInfoRestModel
{
    var mContentImage : String!     // Thumbview Image link of the Content
    var mContentTitle : String!    // Title of Content
    var mContentID : Int!          // Content ID
    


    // return ContentInfoRestModel object to controller
    

}

// class for Content View
struct ContentViewRestModel
{
    var mNumberOfViews : Int!       // Total views of content
    var mNumberOfParticipant : Int! // Total participant of Content
    var mLastViewedDate : String!   // last viewed time of Content
    var mActionPerformed : String!  // shows which action has been last performed on Content
    var mContentID : Int!           // Content ID
    
}


class ContentListModel
{
    
    // create object of structure
    
    var contentInfoRestModel = [ContentInfoRestModel]()
    
    var contentViewRestModel = [ContentViewRestModel]()
    
    init(info: NSDictionary, view: NSDictionary)
    {
        setContentInfo(info)
        setContentView(view)
        
    }
    
    
    // intialze Model with ContentInfo Array
    func setContentInfo(info : NSDictionary)
    {
        
        let set1 = ContentInfoRestModel(mContentImage: info["contentImagePath"] as! String, mContentTitle: info["contentTitle"] as! String, mContentID: info["contentId"] as! Int)
     
        contentInfoRestModel.append(set1)
    }
    

    
    // intialze Model with ContentView Array
    func setContentView(view : NSDictionary)
    {
        let set1 = ContentViewRestModel(mNumberOfViews: view["mNumberOfViews"] as! Int, mNumberOfParticipant: view["mNumberOfParticipant"] as! Int, mLastViewedDate: view["mLastViewedDate"] as! String, mActionPerformed: view["mActionPerformed"] as! String, mContentID: view["contentId"] as! Int)
        
        contentViewRestModel.append(set1)
    }

    
    // return ContentInfoRestModel to Controller
    func getContentInfoModel ()->[ContentInfoRestModel]
    {
        return contentInfoRestModel
    }
    
    
     // return ContentViewRestModel to Controller
    func getContentViewModel() ->[ContentViewRestModel]
    
    {
        return contentViewRestModel
        
    }
    
    
    // This will call from controller
    func getContentData() ->(info : [ContentInfoRestModel], view : [ContentViewRestModel])
    {
        return(contentInfoRestModel,contentViewRestModel)
    }
    
}
