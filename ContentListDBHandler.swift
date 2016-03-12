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
            let createContentInfo = "CREATE TABLE  IF NOT EXISTS ContentInfo(contentid INT NOT NULL, contentImage VARCHAR(100) NULL,ContentTitle INT)"
            
            // create table ContentView
            let createContentView = "CREATE TABLE  IF NOT EXISTS ContentView(contentid INT NOT NULL, actionPerformed VARCHAR(45) NULL, numberOfParticipant VARCHAR(45), numberOfViews VARCHAR(45), LastViewedDate VARCHAR(45) )"
                
            
            if !shoppingPad.executeStatements(createContentInfo)
            {
                print("Error: \(shoppingPad.lastErrorMessage())")
            }
            
            if !shoppingPad.executeStatements(createContentView)
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
    func InsertContentInfo(info: ContentInfo)
    {
        if shoppingPad == nil
        {
            print("Error: \(shoppingPad.lastErrorMessage())")
        }
            
        if shoppingPad.open()
        {
                
            // retrive value from Array to insert into table
         
            let insertContentInfo = "INSERT INTO ContentInfo VALUES(\(info.mContentID),'\(info.mContentImage)','\(info.mContentTitle)') "
                
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
    func InsertContentView(view : ContentView)
    {

        if shoppingPad == nil
        {
            print("Error: \(shoppingPad.lastErrorMessage())")
        }
        
        if shoppingPad.open()
        {
            
            // retrive value from Array to insert into table
            
            let insertContentView = "INSERT INTO ContentView VALUES(\(view.mContentID),'\(view.mActionPerformed)',\(view.mNumberOfParticipant),\(view.mNumberOfViews),'\(view.mLastViewedDate)') "
            
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

}