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
struct ContentViewModel
{
    var mContentImage : String?     // Thumbview Image link of the Content
    var mContentTitle : String?     // Title of Content
    var mNumberOfViews : Int?       // Total views of content
    var mNumberOfParticipant : Int? // Total participant of Content
    var mLastViewedDate : String?   // last viewed time of Content
    var mActionPerformed : String?  // shows which action has been last performed on Content
}

class ContentListViewModel
{
    //contentListController is type of ContentListController.
    var mContentListController : ContentListController?
    
    // mListOfContentViewModel holds list of all content
    var mListOfContentViewModel = [ContentViewModel]()
    
    
    
    // contentListViewModel is type of ContentListViewModel
    var contentListViewModel : ContentListViewModel?
    
   // for Unit Test
   var mIsUnitTest : Bool = true
    
 
    
    //This return list of content
    func getContentViewModel(position : Int)->ContentViewModel
    {

        return mListOfContentViewModel[position]
    }
    
    
    // Constructor of ContentListViewModel
    init()
    {
        // Check if ListOfContentView Is Nill
        if(mListOfContentViewModel.count == 0)
        {
            
            if(mIsUnitTest)
            {
                
                // ContentListViewModel call this method for populatingData in ViewModel
                // self.populateDummyContentData()
                
                // call controller constructor an populate data
                 mContentListController = ContentListController()
                 populateDummyData()
                
                
                // And set value of ContentViewModel
                // setContentViewModel()
            }
            
        }
        
    }
    
    
    // Populate Dummy content data for ViewModel
    func populateDummyData()
    {
        // retrive ContentInfo structire variable
        let contentInfo = mContentListController?.getContentData(0).info
       
        
        // retrive ContentView structire variable
        let contentView = mContentListController?.getContentData(0).views
        
        
        let setContentViewModel = ContentViewModel(mContentImage: contentInfo?.mContentImage, mContentTitle: contentInfo?.mContentTitle, mNumberOfViews: contentView?.mNumberOfViews, mNumberOfParticipant: contentView?.mNumberOfParticipant, mLastViewedDate: contentView?.mLastViewedDate, mActionPerformed: contentView?.mActionPerformed)
        
        mListOfContentViewModel.append(setContentViewModel)
    }
    
    
    
    // Populate Dummy content data for ViewModel
        func populateDummyContentData() ->[ContentViewModel]
        {
            print("Inside Dummy content Data")
            // Take Dummy Data from Structure
            let dummyData1 = ContentViewModel(mContentImage: "/Users/BridgeLabz/Documents/komal/ShoppingPad/b.jpg", mContentTitle: "Sofa", mNumberOfViews: 1, mNumberOfParticipant: 2, mLastViewedDate: "22 Feb 2016", mActionPerformed: "Viewed")
    
    
            let dummyData2 = ContentViewModel(mContentImage: "/Users/BridgeLabz/Documents/komal/ShoppingPad/b.jpg", mContentTitle: "Bed", mNumberOfViews: 3, mNumberOfParticipant: 4, mLastViewedDate: "3rd March 2016", mActionPerformed: "Opened")
    
    
            mListOfContentViewModel.append(dummyData1)
            mListOfContentViewModel.append(dummyData2)
    
            print("mListOfContentViewModel",mListOfContentViewModel)
    
            return mListOfContentViewModel
        }
    
    
    // This function will call Controller and fetch dummy data from it and set that data to ConetentViewModel
    func setContentViewModel()
    {
        let dummyData1 = mContentListController!.populateDummyContentData()
        mListOfContentViewModel.append(dummyData1)
    }
    
    
	
}

