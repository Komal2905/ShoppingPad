//
//  ContentInfoViewModelHandler.swift
//  ShoppingPad
//  Purpose:
//  1) This class is ViewModel of MVVM design pattern for COntentInfo
//  2) It is holding the model required for ContentInfo
//  3) This class has Controller object to retrive neccessary model
//  4) Also holds variable participantName, participantLastViewDate, participantLastAction, participantViewCount, contentTotalPArticipant, contentMediaCount
//
//  Created by Vidya Ramamurthy on 21/03/16.
//  Copyright © 2016 BridgeLabz. All rights reserved.
//

import Foundation
// Import Reactive Framework
import ReactiveKit
import ReactiveUIKit
import ReactiveFoundation

// define structure that will take dumm data and populate ViewModel
//
struct ContentInfoViewModelDummy
{
    var mContentID : Int!
    var mContentTitle : String!
    var mParticipantName : String!
    var mParticipantLastOpenedDate : String!
    var mParticipantAction : String!
    var mParticipantViewCount : Int!
    var mParticipantImageView : String!
    var mParticipantId : Int!
}

class ContentInfoViewModelHandler : PContentParticipantInformerToViewModel
{
    // for Unit Test
    var mIsUnitTest : Bool = false
    
    // mContentInfoViewModel holds list of all  participant
    // This holds array for Dummy Data
    var mContentInfoViewModelDummy = [ContentInfoViewModelDummy]()
    
    // create object of ContentInfoController
    var mContentInfoController : ContentInfoController!
    
    // Aray of ContentParticipantViewModel
    var mContentInfoViewModelArray = [ContentParticipantViewModel]()
    
    // object of ContentParticipantViewModel
    var mContentInfoViewModel : ContentParticipantViewModel!
    
    
    // object of PContentParticipantInformerToViewModel
    var pContentParticipantInformerToViewModel : PContentParticipantInformerToViewModel!
    
    // object of PContentListViewObserver
    var mContentParticipantViewObserver : PContentParticipantViewObserver?
    
    
    init(pContentParticipantViewObserver : PContentParticipantViewObserver)
    {
        if(mIsUnitTest == true)
        {
            //populate dummy data
            self.populateDummyData()
        }
        
        else
        {
            // get data from Cotroller and Populate ContentInfoViewModel
            mContentInfoController = ContentInfoController(pContentParticipantInformerToViewModel: self)
            
            mContentParticipantViewObserver = pContentParticipantViewObserver
            
        }
    }
    
    // This function will fetch ContentInfoData from LocalDB
    func getContentInfo(contentId : Int)
    {
        // call Controller
        print("IN HANDLELER")
        mContentInfoController.getContentInfo(contentId)
        
    }
    
    
    // this will populate ContentDetailsViewModel
    func populateContentDetailsViewModel()
    {
        
    }
    
    //this function is Called form COntentInfoViewController
    func populateContentParticipantData(content : Int)
    {
       // call controller and participant ID
        mContentInfoController!.populateParticipantDetails(content)
        
    }
    
    // PContentParticipantInformerToViewModel protocol's Function
    // this is called form ContentInfoController
    func updateViewModelContentParticipant()
    {
        // populate ContentInfo
        self.populateContentInfo()
        
        // callback to ContentInfoViewCOntroller
        mContentParticipantViewObserver!.updateContentInfoViewModel()
        
    }
    // This function populate ContentInfo; it calls Controller for ContentInfo;
    // after getting data from Controller it populate ContentInfoViewModel
    
    func populateContentInfo()
    {
        // call Controller for populateing data
        let mContentInfo = mContentInfoController.getContentInfoData(1)
        
        // seperate ContentInfoDetails;uncomment
                //let mContentDetail = mContentInfo.contentDetail
       
        //seperate ContentParticipant
        
        let mContentParticipant = mContentInfo.contentParticiapnt
        
        // seperate ConetntDetais and participant view one by one
        // and populate ContentInfoViewModel
        
        for index1 in 0...mContentParticipant.count-1 // contentDeatilsHere
        {
        
            // populate ContentInfoViewModel ;
            //mContentInfoViewModel = ContentInfoViewModel(mContentID : Observable(String(mContentDetail[index1].mContentID)),mContentTitle : Observable(mContentDetail[index1].mContentTitle),mParticipantName: Observable(mContentParticipant[index1].mParticipantName),mParticipantLastOpenedDate : Observable(mContentParticipant[index1].mParticipantLastOpenedDate),mParticipantAction: Observable(mContentParticipant[index1].mParticipantAction),mParticipantViewCount: Observable(String(mContentParticipant[index1].mParticipantViewCount)),mParticipantImageView : Observable(mContentParticipant[index1].mParticipantImageView),mParticipantId:Observable(String(mContentParticipant[index1].mParticipantId)))
            
            // TESTING PUROPSE
            mContentInfoViewModel = ContentParticipantViewModel(mContentID : Observable(String(1)),mContentTitle : Observable("MyTitle"),mParticipantName: Observable(mContentParticipant[index1].mParticipantName),mParticipantLastOpenedDate : Observable(mContentParticipant[index1].mParticipantLastOpenedDate),mParticipantAction: Observable(mContentParticipant[index1].mParticipantAction),mParticipantViewCount: Observable(String(mContentParticipant[index1].mParticipantViewCount)),mParticipantImageView : Observable(mContentParticipant[index1].mParticipantImageView),mParticipantId:Observable(String(mContentParticipant[index1].mParticipantId)))
                    
                    
            mContentInfoViewModelArray.append(mContentInfoViewModel)
        
        }
    }
    
 // This function is called from ContentInfoViewController
    func getContentInfoViewModel(position : Int) -> ContentParticipantViewModel
    {
        return mContentInfoViewModelArray[position]
    }
    
   // This function populate dummy participant data for ContentInfoViewModel
    func populateDummyData()
    {
        // define some data
        let dummyData1 = ContentInfoViewModelDummy(mContentID: 1, mContentTitle : "Display1", mParticipantName: "Amol", mParticipantLastOpenedDate: "2nd March,2015", mParticipantAction: "Opened", mParticipantViewCount: 5, mParticipantImageView: "abc", mParticipantId: 11)
        
        let dummyData2 = ContentInfoViewModelDummy(mContentID: 2, mContentTitle : "Display2",mParticipantName: "Vimal", mParticipantLastOpenedDate: "12nd April,2015", mParticipantAction: "Share", mParticipantViewCount: 4, mParticipantImageView: "pqr", mParticipantId: 12)
        
        let dummyData3 = ContentInfoViewModelDummy(mContentID: 3, mContentTitle : "Display3",mParticipantName: "Reena", mParticipantLastOpenedDate: "29th May,2015", mParticipantAction: "Clicked", mParticipantViewCount: 8, mParticipantImageView: "xyz", mParticipantId: 13)
        
        mContentInfoViewModelDummy.append(dummyData1)
        mContentInfoViewModelDummy.append(dummyData2)
        mContentInfoViewModelDummy.append(dummyData3)
        
    }
    
    /*
    // this function return data(Dummy) to ConetntInfoViewController
    
    func getContentInfoViewModel(position : Int)-> ContentInfoViewModelDummy
    {
        // retun dummy data
        return mContentInfoViewModelDummy[position]
    }
    */
    

    
}