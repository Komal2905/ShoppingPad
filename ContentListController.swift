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
}

// Structure for Content View
struct ContentView
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

}

// this structure holds variable for ContentParticipant
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


// this class Implement PContentListListener protocol
class ContentListController : PControllerListener
{
    // for Unit Test
    var mIsUnitTest : Bool = false
    
    //create object REST service handler
    var mContentListRestServiceHandler : ContentListRestServiceHandler!
    
    // create object of Database handler
    var mContentListDBHandler : ContentListDBHandler!
    
    // create object of  ContentInfoDataModel of Model
    var contentInfoDataModel : ContentInfoDataModel!
    
    // create object of  ContentViewDataModel of Model
    var contentViewRestModel : ContentViewDataModel!
    
    // object for ContentInfo Structure
    var mContentInfo = [ContentInfo]()
   
    // object for ContentView Structure
    var mContentView = [ContentView]()
    
    // create array object of ContentParticipant
    var mContentParticipant = [ContentParticipant]()
    
    
    var mContentDetails = [ContentDetails]()

    // protocol of ViewModel
    var mContentViewModelListener : PContentListInformerToViewModel?
    
    // array that will hold Result of Resultset For ContentParticipant
    var contentInfoArray = [AnyObject]()
    
    init(pContentListInformerToViewModel : PContentListInformerToViewModel)
    {
        // Populate Dummy data if it is in Test
        if(mIsUnitTest)
        {
            self.populateDummyContentData()
            self.populateDummyContentParticipant()
        }
        
        else
        {
            mContentViewModelListener = pContentListInformerToViewModel
            // intialize DB handler
            mContentListDBHandler = ContentListDBHandler()
    
        }

    }
    
    // This function will fetch data from Rest Handler
    // called from ContentListViewModelHandler
    func populateContentData()
    {
        mContentListRestServiceHandler = ContentListRestServiceHandler()
        
        //get ContentInfo from Rest
        mContentListRestServiceHandler!.populateContentInfoData(self)
        
        //get ContentView from Rest
        mContentListRestServiceHandler!.populateContentViewData(self)
        
    }
    

    // This function will populate COntentInfo in ContentListController
    func populateContentInfo(JsonContentInfo : NSMutableArray)
    {
        // Iterate thorugh Array
        for contentCount in 0...JsonContentInfo.count-1
        {
           
            // define dictionary
            let contentInfoDictionary = JsonContentInfo[contentCount] as! NSDictionary
            
            //Populate ContentInfoDataModel class  of ContentListModel with Dictionary
            contentInfoDataModel = ContentInfoDataModel(info: contentInfoDictionary)
            
            
            // Populate Controller's Structure ContentInfo
            
            let set = ContentInfo(mcontentLink: contentInfoDataModel.mcontentLink, mContentType: contentInfoDataModel.mContentType, mContentID: contentInfoDataModel.mContentID, mCreatedAt: contentInfoDataModel.mCreatedAt, mDescription: contentInfoDataModel.mDescription, mContentDisplay: contentInfoDataModel.mContentDisplay, mContentImage: contentInfoDataModel.mContentImage, mModifiedAt: contentInfoDataModel.mModifiedAt, mSyncDateTime: contentInfoDataModel.mSyncDateTime, mContentTitle: contentInfoDataModel.mContentTitle, mContentUrl: contentInfoDataModel.mContentUrl, mContentZip: contentInfoDataModel.mContentZip)
            // append set to ContentInfo's Array
        
            mContentInfo.append(set)
            
            // pass array for insertion in table ContentInfo
            mContentListDBHandler!.insertContentInfo(set)
        
        }
    }
    

    // This function will populate COntentView in Controller
    
    func populateContentView(JsonContentView : NSMutableArray)
    {
        // Iterate thorugh Array
        for contentCount in 0...JsonContentView.count-1
        {
          
            // define dictionary
            let contentViewDictionary = JsonContentView[contentCount] as! NSDictionary
        
             //Populate ContentViewDataModel class  of Model with Dicionary
            let contentViewDataModel = ContentViewDataModel(view: contentViewDictionary)
            
            // Populate Controller's Structure ContentView
            let set = ContentView(mContentID: contentViewDataModel.mContentID, mActionPerformed: contentViewDataModel.mActionPerformed, mDisplayProfile: contentViewDataModel.mDisplayProfile, mEmail: contentViewDataModel.mEmail, mFirstName: contentViewDataModel.mFirstName, mLastName: contentViewDataModel.mLastName, mLastViewedDate: contentViewDataModel.mLastViewedDate, mNumberOfViews: contentViewDataModel.mNumberOfViews, mNumberOfParticipant: contentViewDataModel.mNumberOfParticipant, mUserAdminId: contentViewDataModel.mUserAdminId, mUserContentId: contentViewDataModel.mUserContentId, mUserId: contentViewDataModel.mUserId)
            
            // append set to ContentView's Array
            mContentView.append(set)
            
            // pass array for insertion in table ContentInfo
            mContentListDBHandler?.insertContentView(set)
            
        }

    }
    
    
    // Function form PContentListListener Protocol
    // This will be called from rest
    func updateControllerInfoModel(JsonContentInfo : NSMutableArray)
    {
        //Populate ContentInfo
        self.populateContentInfo(JsonContentInfo)
        
        // Call back to ViewModelHandler
        mContentViewModelListener!.updateViewModelContentInformer()
        
    }
    
    // Function form PContentListListener Protocol
    func updateControllerViewModel(JsonContentView : NSMutableArray)
    {
        //Populate ContentView
        self.populateContentView(JsonContentView)
        mContentViewModelListener!.updateViewModelContentInformer()
        
    }
    
    
    // protocol function for COntentParticipant
    func updateContentParticipant(JsonContentParticipant : NSMutableArray)
    {
        // populate ContentParticipant
        self.populateContentParticipant(JsonContentParticipant)
        
        // call back to ContentInfoViewModelHandler
        mContentViewModelListener!.updateViewModelContentInformer()
    }
    
    
    // this function in calling Rest Service and populate ContentInfoModel
    // then in popultate Controller
    func populateContentParticipant(JsonContentParticipant : NSMutableArray)
    {
        
        
        for pCount in 0...JsonContentParticipant.count-1
        {
            // populate ContentParticipantModel
            
            let contentParticipantDictionary = JsonContentParticipant[pCount] as! NSDictionary
            
            // populate ContentParticipantModel
            let mContentParticipantModel = ContentParticipantModel(contentParticipant: contentParticipantDictionary)
            
            
            // populate COntrollers structure ContentDetails
            let set = ContentParticipant(mParticipantName: mContentParticipantModel.mParticipantName, mParticipantLastOpenedDate: mContentParticipantModel.mParticipantLastOpenedDate, mParticipantAction: mContentParticipantModel.mParticipantAction, mParticipantViewCount: mContentParticipantModel.mParticipantViewCount, mParticipantImageView: mContentParticipantModel.mParticipantImageView, mParticipantId: mContentParticipantModel.mParticipantId, mContentID: mContentParticipantModel.mContentID)
            
            mContentParticipant.append(set)
            
            // Insert Into Database
            
        }
        
    }
    
    
    // This method will be called from ContentInfoViewModelHandler
    func getContentParticipantData(userId : Int) ->(contentDetail : [ContentDetails], contentParticiapnt : [ContentParticipant])
    {
        // return Content details and Content participant to ContentInfoViewModelHandler
        // which will set it to ContentViewModel
        
        print("mContentDetails in COntrooler", mContentDetails)
        return(mContentDetails, mContentParticipant)
    }

    
    
    // This method will be called from ContentInfoViewModel
    func getContentData(userId : Int) ->(info : [ContentInfo], views : [ContentView])
    {
        
        // return Content info and Content View to View Model
        // which will set it to ContentViewModel
        return(mContentInfo, mContentView)
    }
    
    
    
    // This function will fetch ContentInfoData from LocalDB
    func getContentInfo(contentId : Int)
    {
        // call LocalDb
        print("IN CONTROLLER")
        contentInfoArray = mContentListDBHandler!.getContentInfo(contentId)
        
        print("ContentInfoInt COntroller",contentInfoArray)
        // populate ContentInfo Model
        self.populateContentInfoDataModel(contentInfoArray)
        
    }
    
    // this function populate COntentInfo data model
    func populateContentInfoDataModel(jsonContentInfo : [AnyObject])
    {
        // itearte through array and poulate ContentInfo model
        for pCount in 0...jsonContentInfo.count-1
        {
            // define dictionary
            let contentInfoDictionary = jsonContentInfo[pCount] as! NSDictionary
            
            //Populate ContentInfoDataModel class  of ContentListModel with Dictionary
            contentInfoDataModel = ContentInfoDataModel(info: contentInfoDictionary)
            
            
        }
    }

    
    
    
    // this function is called form ContentInfoMovieModelHandler
    // it fetch data form Rest
    func populateParticipantDetails(contentId : Int)
    {
        // all Rest service
        mContentListRestServiceHandler = ContentListRestServiceHandler()
        
        //populate Participant data from rest using POST
        mContentListRestServiceHandler!.getParticipantDetails(self,content:contentId)
    }
    
    
    
    // return number of content in ContentInfo
    // This method will be called from ViewModel
    func contentViewModelCount() -> Int
    {
        return mContentInfo.count
    }
    

    // this function will insert ContentInfo array in table named ContentInfo
    func InsertIntoLocalDB()
    {
        // intialize DB handler
        mContentListDBHandler = ContentListDBHandler()
        
       // pass one Array at time to Local DB for insertion in ContentInfo table
        for contentInfo in mContentInfo

        {
           // pass array for insertion in table ContentInfo
            mContentListDBHandler?.insertContentInfo(contentInfo)
        }
        
        
        // pass one Array at time to Local DB for insertion in ContentView table
        for contentView in mContentView
        {
            // pass array for insertion in table ContentInfo
            mContentListDBHandler?.insertContentView(contentView)
        }
        
        
    }
    
    
   
    
    
    // Fetch ContentInfo From Rest // Not in use
    func setContentInfoRest(array :[ContentInfoDataModel])
    {
        for cInfo in array
        {
        
            let set1 = ContentInfo(mcontentLink: cInfo.mcontentLink, mContentType: cInfo.mContentType, mContentID: cInfo.mContentID, mCreatedAt: cInfo.mCreatedAt, mDescription: cInfo.mDescription, mContentDisplay: cInfo.mContentDisplay, mContentImage: cInfo.mContentImage, mModifiedAt: cInfo.mModifiedAt, mSyncDateTime: cInfo.mSyncDateTime, mContentTitle: cInfo.mContentTitle, mContentUrl: cInfo.mContentUrl, mContentZip: cInfo.mContentZip)
        
            mContentInfo.append(set1)
            
        }
        
    }
    
    // Fetch ContentView From Rest
    func setContentViewRest(array :[ContentViewDataModel])
    {

        for cView in array
        {
        
            let set1 = ContentView(mContentID: cView.mContentID, mActionPerformed: cView.mActionPerformed, mDisplayProfile: cView.mDisplayProfile, mEmail: cView.mEmail, mFirstName: cView.mFirstName, mLastName: cView.mLastName, mLastViewedDate: cView.mLastViewedDate, mNumberOfViews: cView.mNumberOfViews, mNumberOfParticipant: cView.mNumberOfParticipant, mUserAdminId: cView.mUserAdminId, mUserContentId: cView.mUserContentId, mUserId: cView.mUserId)
        
            mContentView.append(set1)
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
     
        
        
        let dummyData1 = ContentInfo(mcontentLink: "/Users/BridgeLabz/Documents/komal/ShoppingPad/b.jpg", mContentType: "Video", mContentID: 1, mCreatedAt: "Today", mDescription: "This is an Desc", mContentDisplay: "Displya1", mContentImage: "Image", mModifiedAt: "yesterday", mSyncDateTime: "Somedate", mContentTitle: 2, mContentUrl: "URL", mContentZip: "SomeZip")
        
        let dummyData2 = ContentInfo(mcontentLink: "/Users/BridgeLabz/Documents/komal/ShoppingPad/A.jpg", mContentType: "Video", mContentID: 1, mCreatedAt: "Today", mDescription: "This is an Desc", mContentDisplay: "Displya1", mContentImage: "Image", mModifiedAt: "yesterday", mSyncDateTime: "Somedate", mContentTitle: 2, mContentUrl: "URL", mContentZip: "SomeZip")
        
        mContentInfo.append(dummyData1)
        mContentInfo.append(dummyData2)
        
    }
    
    
    //Populate Dummy data for ContentView
    func setContentView()
    {
        let dummyData1 = ContentView(mContentID: 1, mActionPerformed: "Action", mDisplayProfile: "DisplyaProf", mEmail: "Email", mFirstName: "firstNAme", mLastName: "lastNAme", mLastViewedDate: "Today", mNumberOfViews: 8, mNumberOfParticipant: 8, mUserAdminId: 1, mUserContentId: 1, mUserId: 1)
        
        let dummyData2 = ContentView(mContentID: 2, mActionPerformed: "Action", mDisplayProfile: "DisplyaProf", mEmail: "Email", mFirstName: "firstNAme", mLastName: "lastNAme", mLastViewedDate: "Today", mNumberOfViews: 8, mNumberOfParticipant: 8, mUserAdminId: 1, mUserContentId: 1, mUserId: 1)

        
        let dummyData3 = ContentView(mContentID: 3, mActionPerformed: "Action", mDisplayProfile: "DisplyaProf", mEmail: "Email", mFirstName: "firstNAme", mLastName: "lastNAme", mLastViewedDate: "Today", mNumberOfViews: 8, mNumberOfParticipant: 8, mUserAdminId: 1, mUserContentId: 1, mUserId: 1)

        
        mContentView.append(dummyData1)
        mContentView.append(dummyData2)
        mContentView.append(dummyData3)
    }
    
    
    
    // this function populate dummy ContentPArticipatdata from controller
    func populateDummyContentParticipant()
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


