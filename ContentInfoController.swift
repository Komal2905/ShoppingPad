//
//  ContentInfoController.swift
//  ShoppingPad
//  Purpose:
//  1) Intract with REST service to get data.
//  2) Intract with Local DB to save and retrive content data.
//  3) encapusulating ContentInfo.
//  4) Data controller in MVVM architecture
//  5) Provide interface of View Model to intract with controller. Abstracting Database layer,
//     service layer and model layer.
//  Created by Vidya Ramamurthy on 21/03/16.
//  Copyright © 2016 BridgeLabz. All rights reserved.
//

import Foundation

// hold variable of perticular content
struct ContentDetails
{
    var mContentID : Int!
    var mContentTitle : String!
}

// holds variable of participant

struct ContentParticipant
{
    var mParticipantName : String!
    var mParticipantLastOpenedDate : String!
    var mParticipantAction : String!
    var mParticipantViewCount : Int!
    var mParticipantImageView : String!
    var mParticipantId : Int!
    var mContentID : Int!
}

class ContentInfoController : PContentParticipantListener
{
    // for Unit Test
    var mIsUnitTest : Bool = false
    
    // create array object of ContentDetails
    var mContentDetails = [ContentDetails]()
    
    // create array object of ContentParticipant
    
    var mContentParticipant = [ContentParticipant]()
    
    //create object REST service handler
    var mContentListRestServiceHandler : ContentListRestServiceHandler?
    
    init()
    {
        if(mIsUnitTest)
        {
            self.populateDummyDataController()
        }
        
        else
        {
            self.populateDataFromRest()
            
            //Uncomment this when used Protocol
            
            //populateParticipantDetails()
        }
    }
    
    // this function is called form ContentInfoMovieModelHandler
    // it fetch data form Rest
    func populateParticipantDetails()
    {
        // all Rest service
        mContentListRestServiceHandler = ContentListRestServiceHandler()
        
        //populate Participant data from rest using POST
        mContentListRestServiceHandler!.getParticipantDetails(self)
    }
    
    // protocol function
    func updateContentParticipant(JsonContentParticipant : NSMutableArray)
    {
        print("JsonContentParticipant in Protocol FUnction",JsonContentParticipant)
        // populate ContentParticipant
        self.populateDataFromRest()
    }
    
    // this function in calling Rest Service and populate ContentInfoModel
    // then in popultate Controller
    func populateDataFromRest()//JsonContentParticipant : NSMutableArray
    {
        // all Rest service
        mContentListRestServiceHandler = ContentListRestServiceHandler()
        
        // populate DUmmy Data fro ContentDetails
        //mContentListRestServiceHandler!.populateContentDetailsDummy()

        
        mContentListRestServiceHandler!.getParticipantDetails(self)
        
        let mContentInfoFroRest =  mContentListRestServiceHandler!.getContentData()
        

        //seperate ContentInfo
        let mContentData = mContentInfoFroRest.info
        
        for cCount in 0...mContentData.count-1
        {

            // populate ContentDetailsModel
            let contentDetailDictionary = mContentData[cCount] as! NSDictionary
            
            // populate ContentDetailsModel
            let mContentDetailsModel = ContentDetailsModel(contentDetail: contentDetailDictionary)
            
            // populate COntrollers structure ContentDetails
            let set = ContentDetails(mContentID: mContentDetailsModel.mContentID, mContentTitle: mContentDetailsModel.mContentTitle)
            
            mContentDetails.append(set)
            
        }
        
        //seperate ContentParticipant
        let mContentParticipants = mContentInfoFroRest.view
        
         print("mContentParticipants",mContentParticipants.count)
        
        for pCount in 0...mContentParticipants.count-1
        {
            // populate ContentDetailsModel
            
            let contentParticipantDictionary = mContentParticipants[pCount] as! NSDictionary
        
            // populate ContentParticipantModel
            let mContentParticipantModel = ContentParticipantModel(contentParticipant: contentParticipantDictionary)
            
            
            // populate COntrollers structure ContentDetails
            let set = ContentParticipant(mParticipantName: mContentParticipantModel.mParticipantName, mParticipantLastOpenedDate: mContentParticipantModel.mParticipantLastOpenedDate, mParticipantAction: mContentParticipantModel.mParticipantAction, mParticipantViewCount: mContentParticipantModel.mParticipantViewCount, mParticipantImageView: mContentParticipantModel.mParticipantImageView, mParticipantId: mContentParticipantModel.mParticipantId, mContentID: mContentParticipantModel.mContentID)
            
                mContentParticipant.append(set)
            
        }

     
    }
    
    // This method will be called from ContentInfoViewModelHandler
    func getContentInfoData(userId : Int) ->(contentDetail : [ContentDetails], contentParticiapnt : [ContentParticipant])
    {
        // return Content details and Content participant to ContentInfoViewModelHandler
        // which will set it to ContentViewModel
        return(mContentDetails, mContentParticipant)
    }
    
    // this function populate dummy data from controller
    func populateDummyDataController()
    {


        self.setDummyContentDetails()
        self.setDummyContentparticipant()

    }
    
    //this function populate dummy ContentDetails fro ContentInfoController
    func setDummyContentDetails()
    {
        let dummyData1 = ContentDetails(mContentID: 31, mContentTitle: "Title31Duumy")
        let dummyData2 = ContentDetails(mContentID: 32, mContentTitle: "Title32Duumy")
        let dummyData3 = ContentDetails(mContentID: 33, mContentTitle: "Title33Duumy")
        
        //add to array
        
        mContentDetails.append(dummyData1)
        mContentDetails.append(dummyData2)
        mContentDetails.append(dummyData3)
    }
    
     //this function populate dummy ContentPArticipant fro ContentInfoController
    func setDummyContentparticipant()
    {
        let dummyData1 = ContentParticipant(mParticipantName: "ABC", mParticipantLastOpenedDate: "01 Jan 2000", mParticipantAction: "Clicked", mParticipantViewCount: 90, mParticipantImageView: "ImageViewTestDuumy", mParticipantId: 1,mContentID : 31)
         let dummyData2 = ContentParticipant(mParticipantName: "PQR", mParticipantLastOpenedDate: "01 Jan 2000", mParticipantAction: "Shared", mParticipantViewCount: 90, mParticipantImageView: "ImageViewTestDuumy", mParticipantId: 2,mContentID : 31)
         let dummyData3 = ContentParticipant(mParticipantName: "RST", mParticipantLastOpenedDate: "01 Jan 2000", mParticipantAction: "Opened", mParticipantViewCount: 90, mParticipantImageView: "ImageViewTestDuumy", mParticipantId: 3,mContentID : 31)
        
        mContentParticipant.append(dummyData1)
        mContentParticipant.append(dummyData2)
        mContentParticipant.append(dummyData3)
        
    }
    
}