//
//  ContentListModel.swift
//  ShoppingPad
//
//  Purpose :   1) Holds variable for Content info and ContentView Model
//              2) Intialize its variable from data which it got from COntroller
//
//  Created by Vidya Ramamurthy on 06/03/16.
//  Copyright © 2016 BridgeLabz. All rights reserved.
//

import UIKit

// define classs for ContentInfo
class ContentInfoRestModel
{
    var mContentImage : String!     // Thumbview Image link of the Content
    var mContentTitle : String!    // Title of Content
    var mContentID : Int!          // Content ID
        
    // constructor
    init(info : NSDictionary)
    {
        // initialize mContentImage with info Dictionary
        mContentImage = info["imagesLink"] as! String
        
        // initialize mContentTitle with info Dictionary
        mContentTitle = info["display_name"] as! String
        
        // initialize mContentID with info Dictionary
        mContentID = info["content_id"] as! Int
    }
    
}


//define class For ContentView

class ContentViewRestModel
{
    var mNumberOfViews : Int!       // Total views of content
    var mNumberOfParticipant : Int! // Total participant of Content
    var mLastViewedDate : String!   // last viewed time of Content
    var mActionPerformed : String!  // shows which action has been last performed on Content
    var mContentID : Int!           // Content ID

    // intialize with Dictionary
    init(view : NSDictionary)
    {
        mNumberOfViews = view["numberOfViews"] as! Int
        mNumberOfParticipant = view["numberofparticipant"] as! Int
        mLastViewedDate = view["lastViewedDateTime"] as! String
        mActionPerformed = view["action"] as! String
        mContentID =  view["contentId"] as! Int
        
    }
}

    

