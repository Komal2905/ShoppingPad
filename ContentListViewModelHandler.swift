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
    // This holds array for Dummy Data
    var mListOfContentViewModel = [ContentViewModel]()
    
    // Create List Of ViewModel
    
    var mListOfViewModel = [ContentListViewModel]()
    
    //create object of View Model
    var cViewModel : ContentListViewModel!

    // contentListViewModel is type of ContentListViewModel
    //var contentListViewModel : ContentListViewModelHandler?
    
    // for Unit Test
    var mIsUnitTest : Bool = false
    
    
    // create object of content list ContentListViewObserver
    var mContentViewObserver : PContentListViewObserver?
    
    // Checking status of Protocol function execution
    var mCheck : Bool? = true
    
    //This return list of ContentViewModel to View ; For Dummy Data
    /*
    func getContentViewModel(position : Int)->ContentViewModel


        //return mListOfContentViewModel[position]
        
    }
    */

// this return List of content from ViewModel
    func getContentViewModel(position : Int)-> ContentListViewModel
    {
        
        return mListOfViewModel[position]
        
    }
    
    // Constructor of ContentListViewModel
    //ContentListViewModelHandler take argument of class which implements PContentListViewObserver
    init(pContentListViewObserver : PContentListViewObserver)
    {
        if(mIsUnitTest)
        {
            // ContentListViewModel call this method for populating Dummy Data in ViewModel
            self.populateDummyContentData()
        }
            
        else
        {
            mContentViewObserver = pContentListViewObserver
                
            // call Controller Constructor
            mContentListController = ContentListController(pContentListInformerToViewModel: self)

        }
        
    }
    
    
    // This function is called from ContentListViewController
    func populateContentViewModelData()
    {
        mContentListController!.populateUserContentData()
        
    }

    // implementing protocol PContentListInformerToViewModel
    func updateViewModelContentListInformer()
    {
        // for checking that ConetntInfo and ContentView
        // are populate we execute this function twice.
        if (mCheck == false)
        {
        //Populate  ViewModel
        self.populateUserContentData()
        
        // callback to ContentListViewController
        mContentViewObserver?.updateContentListViewModel()
            
        }
        mCheck = false
    }
    
    
    // Populate Data from Controller
    func populateUserContentData()
    {
        //get Content from Controller
        let mContentData = mContentListController!.getContentData(1)
        
        print("mContentData Count",mContentData.info.count)
        
        //get Content Info
        let mContentInfo = mContentData.info

        // retrive ContentView
        let mContentView = mContentData.views
        

        // Iterate through ContentInfo and ContentView
        for index1 in 0...mContentInfo.count-1
        {
            
            for index2 in 0...mContentView.count-1
            {
                
                // if ContentId from ContentInfo and ContentView matches
                // add it to
                if(mContentInfo[index1].mContentID == mContentView[index2].mContentID)
                {
                    // Intialzed CViewModel of ViewModel
                    cViewModel = ContentListViewModel(mContentImage : Observable(mContentInfo[index1].mContentImage), mContentTitle : Observable(String(mContentInfo[index1].mContentDisplay)), mNumberOfViews : Observable(String(mContentView[index2].mNumberOfViews)),mNumberOfParticipant : Observable(String(mContentView[index2].mNumberOfParticipant)), mLastViewedDate : Observable(mContentView[index2].mLastViewedDate), mActionPerformed : Observable(mContentView[index2].mActionPerformed), mContentID : Observable(String( mContentView[index2].mContentID)))

        
    
                    //append to array of type CViewModel
                    mListOfViewModel.append(cViewModel)
        
                    //Observe changes in property
                    //observeChanges()
                }
            }
            
        }
    
    }

    //this function will Observe changes to Observable
    // whenever variable changes its value this excutes
    func observeChanges()
    {
        //change value of variable; Testing how to change Value of Observable
        //cViewModel.mContentTitle.value = "MyTitle"
        
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

        
    // Populate Dummy content data for ContentListViewModelHandler Structure
        func populateDummyContentData() ->[ContentViewModel]
        {
            // Take Dummy Data from Structure
            let dummyData1 = ContentViewModel(mContentImage: "/Users/BridgeLabz/Documents/komal/ShoppingPad/b.jpg", mContentTitle: "Sofa", mNumberOfViews: 1, mNumberOfParticipant: 2, mLastViewedDate: "22 Feb 2016", mActionPerformed: "Viewed", mContentID: 1)
    
    
            let dummyData2 = ContentViewModel(mContentImage: "/Users/BridgeLabz/Documents/komal/ShoppingPad/b.jpg", mContentTitle: "Bed", mNumberOfViews: 3, mNumberOfParticipant: 4, mLastViewedDate: "3rd March 2016", mActionPerformed: "Opened",mContentID: 2)
    
            // append dummy data to ContentViewModel array
            mListOfContentViewModel.append(dummyData1)
            mListOfContentViewModel.append(dummyData2)

            
            return mListOfContentViewModel
        }
    
	
}

