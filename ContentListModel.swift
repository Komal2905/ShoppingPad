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
class ContentInfoDataModel
{
    var mcontentLink  : String!     // Thumbview Image link of the Content
    var mContentType : String!
    var mContentID : Int!          // Content ID
    var mCreatedAt : String!
    var mDescription : String!
    var mContentDisplay : String!    // Title of Content
    var mContentImage : String!     // Thumbview Image link of the Content
    var mModifiedAt : String!
    var mSyncDateTime : String!
    var mContentTitle : Int!
    var mContentUrl : String!
    var mContentZip : String!
        
    // constructor
    init(info : NSDictionary)
    {
        print("INFO IN MODLE", info)
        mcontentLink = info["contentLink"] as! String
        
        mContentType = info["contentType"] as! String
        
        mContentID = info["content_id"] as! Int
        
        mCreatedAt = info["created_at"] as! String
        
        mDescription = info["decription"] as! String
        
        mContentDisplay = info["display_name"] as! String
        
        mContentImage = info["imagesLink"] as! String
        
        mModifiedAt = info["modified_at"] as! String
        
        mSyncDateTime = info["syncDateTime"] as! String
        
        mContentTitle = info["title"] as! Int
        
        mContentUrl = info["url"] as! String
        
        mContentZip = info["zip"] as! String

    }
    
}


//define class For ContentView

class ContentViewDataModel
{
    var mContentID : Int!           // Content ID
    var mActionPerformed : String!  // shows which action has been last performed on Content
    var mDisplayProfile : String!
    var mEmail : String!
    var mFirstName : String!
    var mLastName : String!
    var mLastViewedDate : String!   // last viewed time of Content
    var mNumberOfViews : Int!       // Total views of content
    var mNumberOfParticipant : Int! // Total participant of Content
    var mUserAdminId : Int!
    var mUserContentId : Int!
    var mUserId : Int!
   
    // intialize with Dictionary
    init(view : NSDictionary)
    {
        
        
        mContentID = view["contentId"] as! Int
        
        mActionPerformed = view["action"] as! String
        
        mDisplayProfile = view["displayProfile"] as! String
        
        mEmail = view["email"] as! String
        
        mFirstName = view["firstName"] as! String
        
        mLastName = view["lastName"] as! String
        
        mLastViewedDate = view["lastViewedDateTime"] as! String
        
        mNumberOfViews = view["numberOfViews"] as! Int
        
        mNumberOfParticipant = view["numberofparticipant"] as! Int
        
        mUserAdminId = view["userAdminId"] as! Int
        
        mUserContentId = view["userContentId"] as! Int
        
        mUserId = view["userId"] as! Int
        
    }
}

    

