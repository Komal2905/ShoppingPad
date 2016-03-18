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
    var mContentImage : String!     // Thumbview Image link of the Content
    var mContentTitle : String!     // Title of Content
    var mContentID : Int!           // Content ID
    
}

// Structure for Content View
struct ContentView
{
    var mNumberOfViews : Int!       // Total views of content
    var mNumberOfParticipant : Int! // Total participant of Content
    var mLastViewedDate : String!   // last viewed time of Content
    var mActionPerformed : String!  // shows which action has been last performed on Content
    var mContentID : Int!           // Content ID

}


// this class Implement PContentListListener protocol
class ContentListController : PContentListListener
{
 
    // for Unit Test
    var mIsUnitTest : Bool = false
    
    
    //create object REST service handler
    var mContentListRestServiceHandler : ContentListRestServiceHandler?
    
    // create object of Database handler
    var mContentListDBHandler : ContentListDBHandler?
    
    
    
    // create object of  ContentInfoRest of Model
    
    var contentInfoRestModel : ContentInfoRestModel?
    
    // create object of  ContentViewRest of Model
    var contentViewRestModel : ContentViewRestModel?
    
    // object for ContentInfo Structure
    
    var mContentInfo = [ContentInfo]()
   
    
    var test = ContentView()
    
    
    // object for ContentView Structure
    var mContentView = [ContentView]()
    
    // protocol of view model
    var mContentViewModelListener : PContentListInformerToViewModel?
    
    init(pContentListInformerToViewModel : PContentListInformerToViewModel)
    {
        // Populate Dummy data if it is in Test
        if(mIsUnitTest)
        {
            populateDummyContentData()
        }
        
        else
        {
            mContentViewModelListener = pContentListInformerToViewModel
        }
        
        
//        else
//        {
//            mContentListRestServiceHandler = ContentListRestServiceHandler()
//            
////            populateUserContentData()
//            
//            //insert data to local database
//            InsertIntoLocalDB()
//        }
        

    }
    
    // This function will fetch data from Rest Handler
    func populateUserContentData()
    {
        mContentListRestServiceHandler = ContentListRestServiceHandler()
        
        //get ContentInfo from Rest
        mContentListRestServiceHandler!.populateContentInfoData(self)
        
        //get ContentView from Rest
        mContentListRestServiceHandler!.populateContentViewData(self)
        
        //print("contentDataRest",contentDataRest)
        
        
        //        let contentInfo = contentDataRest.info
        //        let contentView = contentDataRest.view
        //
        //
        //        // retrive Dictionary from Array
        //        for  contentCount in 0...0//contentInfo.count-1
        //        {
        //            // define Dictiory for ContentInfo
        //            let contentInfoDictionary = contentInfo[contentCount] as! NSDictionary
        //
        //            // define Dictiory for ContentView
        //            let contentViewDictionary = contentView[contentCount] as! NSDictionary
        //
        //            // call ContentListModel and pass Dictionary as arguments
        //            contentListModel = ContentListModel(info: contentInfoDictionary,view: contentViewDictionary)
        //
        //            //get ContentInfo from model
        //            let contentInfoC = contentListModel!.getContentInfoModel()
        //
        //            //get ContentVIew from Model
        //            let contentViewC = contentListModel!.getContentViewModel()
        //
        //            setContentInfoRest(contentInfoC)
        //            setContentViewRest(contentViewC)
        //
        //        } // for loop closed
        
        
        
        
        //          call ContentInfoRest of ContentListModel
        //        let cInfo = contentInfoRestModel?.getContentInfo()
        //
        //        print("cInfo",cInfo)
        
        //        let getContent =  contentInfoRestModel!.getContentInfo()
        //
        //        print("getContent", getContent)
        // call ContentViewRest of ContentListModel
        //        contentViewRestModel = ContentViewRestModel(view : contentView)
        //
        //        let getView = contentViewRestModel!.getContentView()
        //
        //        print("getView",getView)
        //        print("getContentInfo11",getContentInfo)
        //
        //        var getContentView = getContent.view
        //        self.setContentInfoRest(getContentInfo)
        //        self.setContentViewRest(getContentView)
        
        // set Content Info in Model
        //        contentListModel!.setContentInfo(contentInfo)
        
        // set Content View in Model
        //        contentListModel!.setContentView(contentView)
        
        //        setContentInfoRest(contentDataRest!.info)
        //
        //        
        //        setContentViewRest(contentDataRest!.view)
        
        //       mContentViewModelListener?.updateViewModelContentListInformer()
    }
    

    // This function will populate COntentInfo in Controller 
    
    func populateContentInfo(JsonContentInfo : NSMutableArray)
    {
        // Iterate thorugh Array
        for contentCount in 0...JsonContentInfo.count-1
        {
           
            // define dictionary
            let contentInfoDictionary = JsonContentInfo[contentCount] as! NSDictionary
            
            //Populate ContentInfo class  of Model with Dicionary
            let contentInfoRestModel = ContentInfoRestModel(info: contentInfoDictionary)
            
            
            // Populate Controller's Structure ContentInfo
           
            let set = ContentInfo(mContentImage: contentInfoRestModel.mContentImage, mContentTitle: contentInfoRestModel.mContentTitle, mContentID: contentInfoRestModel.mContentID)
            
            // append set to ContentInfo's Array
        
            mContentInfo.append(set)
        }
    }
    
    
    
    // This function will populate COntentViewin Controller
    
    func populateContentView(JsonContentView : NSMutableArray)
    {
        // Iterate thorugh Array
        for contentCount in 0...JsonContentView.count-1
        {
          
            // define dictionary
            let contentViewDictionary = JsonContentView[contentCount] as! NSDictionary
        
             //Populate ContentInfo class  of Model with Dicionary
            let contentViewRestModel = ContentViewRestModel(view: contentViewDictionary)
            
            // Populate Controller's Structure ContentView
            let set = ContentView(mNumberOfViews: contentViewRestModel.mNumberOfViews, mNumberOfParticipant: contentViewRestModel.mNumberOfParticipant, mLastViewedDate: contentViewRestModel.mLastViewedDate, mActionPerformed: contentViewRestModel.mActionPerformed, mContentID: contentViewRestModel.mContentID)
            
            // append set to ContentView's Array
            mContentView.append(set)
            
            }

    }
    
    
    // Function form PContentListListener Protocol
    // This will be called from rest
    func updateControllerInfoModel(JsonContentInfo : NSMutableArray)
    {
        //Populate ContentInfo
        self.populateContentInfo(JsonContentInfo)
        
    }
    
    // Function form PContentListListener Protocol
    func updateControllerViewModel(JsonContentView : NSMutableArray)
    {
        //Populate ContentView
        
        self.populateContentView(JsonContentView)
        mContentViewModelListener!.updateViewModelContentListInformer()
        
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

    // this function will insert ContentInfo array in table named ContentInfo
    func InsertIntoLocalDB()
    {
        // intialize DB handler
        mContentListDBHandler = ContentListDBHandler()
        
       // pass one Array at time to Local DB for insertion in ContentInfo table
        for contentInfo in mContentInfo

        {
           // pass array for insertion in table ContentInfo
            mContentListDBHandler?.InsertContentInfo(contentInfo)
        }
        
        
        // pass one Array at time to Local DB for insertion in ContentView table
        for contentView in mContentView
        {
            // pass array for insertion in table ContentInfo
            mContentListDBHandler?.InsertContentView(contentView)
        }
        
        
    }
    
    // Fetch ContentInfo From Rest // Not in use
    func setContentInfoRest(array :[ContentInfoRestModel])
    {
        for cInfo in array
        {
        
            let set1 = ContentInfo(mContentImage: cInfo.mContentImage, mContentTitle: cInfo.mContentTitle, mContentID: cInfo.mContentID)
        
            mContentInfo.append(set1)
            
        }
        
    }
    
    // Fetch ContentView From Rest
    func setContentViewRest(array :[ContentViewRestModel])
    {

        for cView in array
        {
        
            let set1 = ContentView(mNumberOfViews: cView.mNumberOfViews, mNumberOfParticipant: cView.mNumberOfParticipant, mLastViewedDate: cView.mLastViewedDate, mActionPerformed: cView.mActionPerformed, mContentID: cView.mContentID)
        
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

    
   }