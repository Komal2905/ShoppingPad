//
//  ContentListDBHandler.swift
//  ShoppingPad
//
//  Purpose: Handles Local Database. 
//
//  Created by Vidya Ramamurthy on 06/03/16.
//  Copyright © 2016 BridgeLabz. All rights reserved.
//

import UIKit


class ContentListDBHandler
{
    // Database path
    var databasePath = String!()
    
    // Create database named shoppingPad
    var shoppingPad = FMDatabase!()
    
    // define resulteset
    var contentInfo = FMResultSet()
    var contentView = FMResultSet()
    var contentParticipant = FMResultSet()
    
    // array that will host Result of Resultset
    
    var contentInfoArray = NSMutableArray()
    var contentViewArray = NSMutableArray()
    var contentParticipantArray = NSMutableArray()
    
    
    init()
    {
        // create Table COntentInfo and ContentView
        createTable()

    }
    
    // this function create 2 table in DB ContentInfo and COntentView
    func createTable()
    {
        // path to DB
        databasePath = "/Users/BridgeLabz/Documents/komal/ShoppingPad/ShoppingPad.sqlite"
        
        // create ShoppingPad DB
        shoppingPad = FMDatabase(path: databasePath as String)
        
        
        if shoppingPad == nil
        {
            print("Error: \(shoppingPad.lastErrorMessage())")
        }
        
        // check if Database is open
        if shoppingPad!.open()
        {
            // create table ContentInfo
            let createContentInfo = "CREATE TABLE  IF NOT EXISTS ContentInfo (content_id INT NOT NULL, contentLink VARCHAR(100) NULL, contentType VARCHAR(100),created_at VARCHAR(100), decription VARCHAR(100), display_name VARCHAR(100), imagesLink VARCHAR(100), modified_at VARCHAR(100), syncDateTime VARCHAR(100),  title INT, url VARCHAR(50), zip VARCHAR(50), PRIMARY KEY (content_id))"
            
        
            // create table ContentView
            let createContentView = "CREATE TABLE IF NOT EXISTS ContentView (contentId INT NOT NULL, action VARCHAR(45) NULL, displayProfile VARCHAR(50), email VARCHAR(50), firstName VARCHAR(50), lastName VARCHAR(50), lastViewedDateTime VARCHAR(45), numberOfView INT ,numberofparticipant INT, userAdminId INT, userContentId INT, userId INT, PRIMARY KEY (contentId) )"
            
            // create ContentParticipant Table
            
            let createContentParticipant = "CREATE TABLE IF NOT EXISTS  ContentParticipant(Image VARCHAR(50), Name VARCHAR(50), action VARCHAR(50), contentId INT, lastViewedDateTime VARCHAR(100), numberOfViews INT ,userId INT, PRIMARY KEY(userId))"
                
            
            if !shoppingPad.executeStatements(createContentInfo)
            {
                print("Error: \(shoppingPad.lastErrorMessage())")
            }
            
            
            if !shoppingPad.executeStatements(createContentView)
            {
                print("Error: \(shoppingPad.lastErrorMessage())")
            }
            
            
            if !shoppingPad.executeStatements(createContentParticipant)
            {
                print("Error: \(shoppingPad.lastErrorMessage())")
            }
            // Close database
            shoppingPad.close()
        }
        else
        {
            print("Error: \(shoppingPad.lastErrorMessage())")
        }
        
    }
    
    
    // ContentInfo will be inserted in table  ContentInfo
    // this function will be called from Controller
    func insertContentInfo(info: ContentInfo)
    {
        if shoppingPad == nil
        {
            print("Error: \(shoppingPad.lastErrorMessage())")
        }
            
        if shoppingPad.open()
        {
            // retrive value from Array to insert into table
            
            let insertContentInfo = "INSERT INTO ContentInfo VALUES(\(info.mContentID),'\(info.mcontentLink)','\(info.mContentType)','\(info.mCreatedAt)' ,'\(info.mDescription)','\(info.mContentDisplay)','\(info.mContentImage)','\(info.mModifiedAt)','\(info.mSyncDateTime)',\(info.mContentTitle),'\(info.mContentUrl)','\(info.mContentZip)')"
            
            // excute Insert Query
            if !shoppingPad.executeStatements(insertContentInfo)
            {
                print("Error: \(shoppingPad.lastErrorMessage())")
            }
                
            else
            {
                print("Successfully Inserted in ContentInfo")
            }
                
            shoppingPad.close()
        }
                
        else
        {
            print("Error: \(shoppingPad.lastErrorMessage())")
        }
        
    }
    
    
    //ContentView inserted into ContentView table
    //This function is callled from controller
    func insertContentView(view : ContentView)
    {

        if shoppingPad == nil
        {
            print("Error: \(shoppingPad.lastErrorMessage())")
        }
        
        if shoppingPad.open()
        {
            // retrive value from Array to insert into table
            
            let insertContentView = "INSERT INTO ContentView VALUES(\(view.mContentID),'\(view.mActionPerformed)','\(view.mDisplayProfile)','\(view.mEmail)','\(view.mFirstName)','\(view.mLastName)','\(view.mLastViewedDate)',\(view.mNumberOfViews),\(view.mNumberOfParticipant),\(view.mUserAdminId),\(view.mUserContentId),\(view.mUserId)) "
            
            // excute Insert Query
            if !shoppingPad.executeStatements(insertContentView)
            {
                print("Error: \(shoppingPad.lastErrorMessage())")
            }
                
            else
            {
                print("Successfully Inserted into ContentView")
            }
            
            shoppingPad.close()
        }
            
        else
        {
            print("Error: \(shoppingPad.lastErrorMessage())")
        }
    }
    
    
    // this function insert COntentParticipant in ContentParticipant Table
    
    func inserContenParticiapnt(contenParticiapnt : ContentParticipant)
    {
        if shoppingPad == nil
        {
            print("Error: \(shoppingPad.lastErrorMessage())")
        }
        
        if shoppingPad.open()
        {
            // retrive value from Array to insert into table
            
            let insertContentParticipant = "INSERT INTO ContentParticipant VALUES('\(contenParticiapnt.mParticipantImageView)','\(contenParticiapnt.mParticipantName)','\(contenParticiapnt.mParticipantAction)',\(contenParticiapnt.mContentID),'\(contenParticiapnt.mParticipantLastOpenedDate)',\(contenParticiapnt.mParticipantViewCount),\(contenParticiapnt.mParticipantId)) "
            
            // excute Insert Query
            
            if !shoppingPad.executeStatements(insertContentParticipant)
            {
                print("Error: \(shoppingPad.lastErrorMessage())")
            }
                
            else
            {
                print("Successfully Inserted into ContentView")
            }
            
            shoppingPad.close()
        }
            
        else
        {
            print("Error: \(shoppingPad.lastErrorMessage())")
        }
    }
    
    
    // this function called form Controller;
    // it return all rows fro ContentInfo table to controller;
    func getContentInfo(pContentListListener : PControllerListener)
    {
        print("IN LOCALDB INFO")
        
        if shoppingPad == nil
        {
            print("Error: \(shoppingPad.lastErrorMessage())")
        }
        
        if shoppingPad.open()
        {
            // select query
            let getContentInfo = "SELECT * FROM CONTENTINFO"
            
            // define resultset
            contentInfo = shoppingPad.executeQuery(getContentInfo, withArgumentsInArray: nil)
            
            // seperate value form resultset
            while(contentInfo.next() == true)
            {
                // conver to NsDictionary and add to Array
                contentInfoArray.addObject(contentInfo.resultDictionary())
        
            }
            
            
            shoppingPad.close()
        }
            
        else
        {
            print("Error: \(shoppingPad.lastErrorMessage())")
        }
        
         // callback to controller protocol
         pContentListListener.updateControllerInfoModel(self.contentInfoArray)
    }
    
 
    func getContentView(pContentListListener : PControllerListener)
    {
        print("IN LOCALDB VIEW")
        
        if shoppingPad == nil
        {
            print("Error: \(shoppingPad.lastErrorMessage())")
        }
        
        if shoppingPad.open()
        {
            // select query
            let getContentView = "SELECT * FROM CONTENTVIEW"
            
            // define resultset
            contentView = shoppingPad.executeQuery(getContentView, withArgumentsInArray: nil)
        
            // seperate value form resultset
            while(contentView.next() == true)
            {
                // conver to NsDictionary and add to Array
                contentViewArray.addObject(contentView.resultDictionary())
            }
            
            shoppingPad.close()
        }
            
        else
        {
            print("Error: \(shoppingPad.lastErrorMessage())")
        }
        
         // callback to controller protocol
        pContentListListener.updateControllerViewModel(self.contentViewArray)
    }

    
    // This function will fetch ContentInfoData from ContentInfo Table for perticular ContenId; CHECKING Offline
    func getContentDetails(pContentListListener : PControllerListener, contentId : Int)
    {
        print("Inside Database")
        
        if shoppingPad == nil
        {
            print("Error: \(shoppingPad.lastErrorMessage())")
        }
        
        if shoppingPad.open()
        {
            // select query
            let getContentInfo = "SELECT * FROM CONTENTINFO where content_id = \(contentId)"
            
            // define resultset
            contentInfo = shoppingPad.executeQuery(getContentInfo, withArgumentsInArray: nil)
            
            while(contentInfo.next() == true)
            {
            // conver to NsDictionary and add to Array
                contentInfoArray.addObject(contentInfo.resultDictionary())
            }
            shoppingPad.close()
        }
            
        else
        {
            print("Error: \(shoppingPad.lastErrorMessage())")
        }
        
        // callback to controller protocol
        pContentListListener.updateControllerInfoModel(self.contentInfoArray)
    }
    
    // this function return ContentParticipant for perticular COntentId
    func getContentParticipant(pContentParticipantListener : PControllerListener, contentId : Int)
    {
        if shoppingPad == nil
        {
            print("Error : \(shoppingPad.lastErrorMessage())")
        }
        
        // check if shopping pad is open
        if shoppingPad.open()
        {
            // fro select query
            let getParticipant = "SELECT * FROM ContentParticipant where contentId = \(contentId)"
            
            contentParticipant = shoppingPad.executeQuery(getParticipant, withArgumentsInArray: nil)
            
            while(contentParticipant.next() == true)
            {
                contentParticipantArray.addObject(contentParticipant.resultDictionary())
            }
            
            shoppingPad.close()
        }
        
         pContentParticipantListener.updateContentParticipant(self.contentParticipantArray )
    }
    
    
    // check table is Empty or Not
    func isEmptyTable(name:String)->Bool
    {
        databasePath = "/Users/BridgeLabz/Documents/komal/ShoppingPad/ShoppingPad.sqlite"
        
        let shoppingPad = FMDatabase(path: databasePath as String)
        
        var isEmpty = Bool()
        
        if(shoppingPad.open())
        {
            let checkEmpty = shoppingPad.executeQuery("SELECT COUNT(*) FROM \(name)", withArgumentsInArray: [])
            if checkEmpty.next()
            {
                let count = checkEmpty.intForColumnIndex(0)
                if count > 0
                {
                    shoppingPad.close()
                    isEmpty = false
                }
                else
                {
                    shoppingPad.close()
                    isEmpty = true
                }
            }
            else
            {
                print("Database error", name)
            }
            shoppingPad.close()
        }
        return isEmpty
    }


}