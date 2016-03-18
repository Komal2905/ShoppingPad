//
//  ContentListViewModel.swift
//  ShoppingPad
//
//  Purpose:
//  1) This class is ViewModel of MVVM design pattern
//  2) It is holding the model required for ContentViewList
//  3) This class has Controller object to retrive neccessary model
//  4) this class holds attribute like ContentImage, ContentTitle, number of Views, number of Participant

//  Created by Vidya Ramamurthy on 06/03/16.
//  Copyright © 2016 BridgeLabz. All rights reserved.
//



// holding required attribute for ContentListViewModel

// Import Reactive Framework

import ReactiveKit
import ReactiveUIKit
import ReactiveFoundation


struct ContentViewModel
{
    var mContentImage : String!                 // Thumbview Image link of the Content
    var mContentTitle : String!                 // Title of Content
    var mNumberOfViews : Int!                   // Total views of content
    var mNumberOfParticipant : Int!             // Total participant of Content
    var mLastViewedDate : String!               // last viewed time of Content
    var mActionPerformed : String!              // shows which action has been last performed on Content
    var mContentID : Int!
    
}

class ContentListViewModelHandler : PContentListInformerToViewModel
{
    //contentListController is type of ContentListController.
    var mContentListController : ContentListController?
    
    // mListOfContentViewModel holds list of all content
    var mListOfContentViewModel = [ContentViewModel]()
    
    // Create List Of ViewModel
    
    var mListOfViewModel = [CViewModel]()
    
    // contentListViewModel is type of ContentListViewModel
    var contentListViewModel : ContentListViewModelHandler?
    
    // for Unit Test
    var mIsUnitTest : Bool = false
    
    var setContentViewModel = ContentViewModel()
    
    //create object of View Model
    
    var cViewModel : CViewModel!
    
    // create object of content list ContentListViewObserver
    var mContentViewObserver : PContentListViewObserver?
    
    
    //This return list of content to View
//    func getContentViewModel(position : Int)->ContentViewModel
//
//
//        //return mListOfContentViewModel[position]
//        
//    }
    
// this return List of content from ViewModel
    func getContentViewModel(position : Int)-> CViewModel
    {
        
        return mListOfViewModel[position]
        
    }
    
    // Constructor of ContentListViewModel
    //ContentListViewModelHandler take argument of class which implements PContentListViewObserver
    init(pContentListInformerToViewModel : PContentListViewObserver)
    {
        // Check if ListOfContentView Is Nill
        if(mListOfContentViewModel.count == 0)
        {
            
            if(mIsUnitTest)
            {
                // ContentListViewModel call this method for populatingData in ViewModel
                self.populateDummyContentData()
            }
            
            else
            {
                mContentViewObserver = pContentListInformerToViewModel
            }
        }
        
    }
    
    
    // This function is called from ContentListViewController
    func populateContentViewModelData()
    {
        mContentListController = ContentListController(pContentListInformerToViewModel: self)
        mContentListController!.populateUserContentData()
        
    }

    // implementing protocol PContentListInformerToViewModel
    func updateViewModelContentListInformer()
    {
        //Populate  ViewModel
        self.populateUserContentData()
        
        mContentViewObserver?.updateContentListViewModel()
    }
    
    
        // Populate Data from Controller
    func populateUserContentData()
    {
     
        // Calculate total content in contentInfo from controller
        let fContentCount = mContentListController!.contentViewModelCount()
        
        //get Content from Controller
        let mContentData = mContentListController!.getContentData(1)
        
        print("mContentData Count",mContentData.info.count)
        
        //get Content Info
        let mContentInfo = mContentData.info

        // retrive ContentView
        let mContentView = mContentData.views
        

        // Iterate through ContentInfo and ContentView
        for index1 in 0...mContentInfo.count - 1
        {
            
            for index2 in 0...mContentView.count - 1
            {
                
                // if ContentId from ContentInfo and ContentView matches
                // add it to
                if(mContentInfo[index1].mContentID == mContentView[index2].mContentID)
                {
                    // Intialzed CViewModel of ViewModel
                    cViewModel = CViewModel(mContentImage : Observable(mContentInfo[index1].mContentImage), mContentTitle : Observable(mContentInfo[index1].mContentTitle), mNumberOfViews : Observable(mContentView[index2].mNumberOfViews),mNumberOfParticipant : Observable(mContentView[index2].mNumberOfParticipant), mLastViewedDate : Observable(mContentView[index2].mLastViewedDate), mActionPerformed : Observable(mContentView[index2].mActionPerformed), mContentID : Observable( mContentView[index2].mContentID))
        
    
                    //append to array of type CViewModel
                    mListOfViewModel.append(cViewModel)
        
                    //observeChanges()
                }
            }
            
        }
    
    }

    //this function will Observe changes to Observable
    // whenever variable changes its value this excutes
    func observeChanges()
    {
        //change value of variable
        cViewModel.mContentTitle.value = "MyTitle"
        
        //observ changes in ContentTitle
        
        cViewModel.mContentTitle.observe
        {
            Value in
            print("Title---",(Value))
        }
         //change value of variable
        cViewModel.mLastViewedDate.value = "3rd Jun 2016"
        
        
        //observ changes in mLastViewedDate
        cViewModel.mLastViewedDate.observe
        {
            Value in
            print("mLastViewedDate",(Value))
        }
        
        
        //observ changes in mNumberOfViews
        cViewModel.mNumberOfViews.observe
            {
                Value in
                print("mNumberOfViews",(Value))
            }
        
        //change Value in mNumberOfViews
        cViewModel.mNumberOfViews.value = 90

    }
    
    
    // This function will bind the model with UI
    func bindModel()
    {
        // Reactive
        let test =  ObservableCollection([cViewModel!])
        
        test.observe{ e in
            print("Aray Collection",e.collection)
            
        }
    
    }

    

    
    // Populate Dummy content data for ViewModel
        func populateDummyContentData() ->[ContentViewModel]
        {
            // Take Dummy Data from Structure
            let dummyData1 = ContentViewModel(mContentImage: "/Users/BridgeLabz/Documents/komal/ShoppingPad/b.jpg", mContentTitle: "Sofa", mNumberOfViews: 1, mNumberOfParticipant: 2, mLastViewedDate: "22 Feb 2016", mActionPerformed: "Viewed", mContentID: 1)
    
    
            let dummyData2 = ContentViewModel(mContentImage: "/Users/BridgeLabz/Documents/komal/ShoppingPad/b.jpg", mContentTitle: "Bed", mNumberOfViews: 3, mNumberOfParticipant: 4, mLastViewedDate: "3rd March 2016", mActionPerformed: "Opened",mContentID: 2)
    
    
            mListOfContentViewModel.append(dummyData1)
            mListOfContentViewModel.append(dummyData2)

    
            return mListOfContentViewModel
        }
    
	
}

