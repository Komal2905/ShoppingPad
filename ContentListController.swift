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
    var mContentImage : String?     // Thumbview Image link of the Content
    var mContentTitle : String?     // Title of Content
    var mContentID : Int?           // Content ID
    
}

// Structure for Content View
struct ContentView
{
    var mNumberOfViews : Int?       // Total views of content
    var mNumberOfParticipant : Int? // Total participant of Content
    var mLastViewedDate : String?   // last viewed time of Content
    var mActionPerformed : String?  // shows which action has been last performed on Content
    var mContentID : Int?           // Content ID

}



class ContentListController
{
 
    // for Unit Test
    var mIsUnitTest : Bool = false
    
    
    //create object REST service handler
    var mContentListRestServiceHandler : ContentListRestServiceHandler?
    
    // create object of Database handler
    var mContentListDBHandler : ContentListDBHandler?
    
    
    // create object of Model
    var contentListModel : ContentListModel?
    
    
    // create object of  ContentInfoRest of Model
    
    var contentInfoRestModel : ContentInfoRestModel?
    
    // create object of  ContentViewRest of Model
    var contentViewRestModel : ContentViewRestModel?
    
    // object for ContentInfo Structure
    
    var mContentInfo = [ContentInfo]()
   
    
    var test = ContentView()
    
    
    // object for ContentView Structure
    var mContentView = [ContentView]()
    
    
    
    init()
    {
        // Populate Dummy data if it is in Test
        if(mIsUnitTest)
        {
            populateDummyContentData()
        }
        
        else
        {
            mContentListRestServiceHandler = ContentListRestServiceHandler()
            populateUserContentData()
            InsertIntoLocalDB()
        }
        

    }
    
    // This function will fetch data from Rest Handler
    func populateUserContentData()
    {
        print("Inside Controller's populateUserContentData")
        
        //get Data from Rest
        let contentDataRest = mContentListRestServiceHandler!.getContentData()
        
        let contentInfo = contentDataRest.info
        let contentView = contentDataRest.view
        
        
        // retrive Dictionary from Array
        for  contentCount in 0...contentInfo.count-1
        {
            // define Dictiory for ContentInfo
            let contentInfoDictionary = contentInfo[contentCount] as! NSDictionary
            
            // define Dictiory for ContentView
            let contentViewDictionary = contentView[contentCount] as! NSDictionary
            
            // call ContentListModel and pass Dictionary as arguments
            contentListModel = ContentListModel(info: contentInfoDictionary,view: contentViewDictionary)
            
            //get ContentInfo from model
            let contentInfoC = contentListModel!.getContentInfoModel()
            
            //get ContentVIew from Model
            let contentViewC = contentListModel!.getContentViewModel()

            setContentInfoRest(contentInfoC)
            setContentViewRest(contentViewC)
            
        } // for loop closed
        
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
    
       
    }
    
   
    func InsertIntoLocalDB()
    {
        mContentListDBHandler = ContentListDBHandler()
        
        print("mContentInfo",mContentInfo)
       
        for a in mContentInfo

        {
           
            mContentListDBHandler?.InsertContentInfo(a)
        }
    }
    
    // Fetch ContentInfo From Rest
    func setContentInfoRest(array :[ContentInfoRestModel])
    {
        
        print("4")
        for cInfo in array
        {
        
            let set1 = ContentInfo(mContentImage: cInfo.mContentImage, mContentTitle: cInfo.mContentTitle, mContentID: cInfo.mContentID)
        
            mContentInfo.append(set1)
            
        }
        
    }
    
    // Fetch ContentView From Rest
    func setContentViewRest(array :[ContentViewRestModel])
    {
        
        print("5")
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
}