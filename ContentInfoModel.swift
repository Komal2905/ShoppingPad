//
//  ContentInfoModel.swift
//  ShoppingPad
//
//  Purpose :   1) Holds variable for ContentDetails and ContentParticipant Model
//              2) Intialize its variable from data which it got from ContentInfoCOntroller
//
//  Created by Vidya Ramamurthy on 22/03/16.
//  Copyright © 2016 BridgeLabz. All rights reserved.
//

import Foundation

// hold variable of ContentDetailsModelnt
class ContentDetailsModel
{
    var mContentID : Int!
    var mContentTitle : String!
    
    // intialize ContentDetailModel with value of Dictionary
    init(contentDetail : NSDictionary)
    {
        mContentID = contentDetail["content_id"] as! Int
        mContentTitle = contentDetail["display_name"] as! String
    }
}

// holds variable for participants of contets

class ContentParticipantModel
{
    var mParticipantName : String!
    var mParticipantLastOpenedDate : String!
    var mParticipantAction : String!
    var mParticipantViewCount : Int!
    var mParticipantImageView : String!
    var mParticipantId : Int!
    var mContentID : Int!
    
    
    // intialize ContentParticipantModel with value of Dictionary
    init(contentParticipant : NSDictionary)
    {
        mParticipantName = contentParticipant["firstName"] as! String
        mParticipantLastOpenedDate = contentParticipant["lastViewedDateTime"] as! String
        mParticipantAction = contentParticipant["action"] as! String
        mParticipantViewCount = contentParticipant["numberOfViews"] as! Int
        mParticipantImageView = contentParticipant["displayProfile"] as! String
        mParticipantId = contentParticipant["userId"] as! Int
        mContentID = contentParticipant["contentId"] as! Int
    }
}