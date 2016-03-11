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
    init()
    {
        // create Table COntentInfo and ContentView
        createTable()
    }
    
    func createTable()
    {
        // path to DB
        var databasePath = "/Users/BridgeLabz/Documents/komal/ShoppingPad/ShoppingPad.sqlite"
        
        
        // create ShoppingPad DB
        let shoppingPad = FMDatabase(path: databasePath as String)
        
        
        if shoppingPad == nil
        {
            print("Error: \(shoppingPad.lastErrorMessage())")
        }
        
        if shoppingPad.open()
        {
            // create tAble ContentInfo
            let createContentTable = "CREATE TABLE  IF NOT EXISTS ContentInfo(contentid INT NOT NULL, contentImage VARCHAR(45) NULL,ContentTitle INT)"
            
            if !shoppingPad.executeStatements(createContentTable)
            {
                print("Error: \(shoppingPad.lastErrorMessage())")
            }
            shoppingPad.close()
        }
        else
        {
            print("Error: \(shoppingPad.lastErrorMessage())")
        }

        
        
        
    }
    
    
    // ContentInfo will be inserted in table  ContentInfo
    // this function will be called from Controller
    func InsertContentInfo(info: [Array])
    {
        var databasePath = "/Users/BridgeLabz/Documents/komal/ShoppingPad/ShoppingPad.sqlite"

            let contactDB = FMDatabase(path: databasePath as String)
            
            if contactDB == nil
            {
                print("Error: \(contactDB.lastErrorMessage())")
            }
            
            if contactDB.open()
            {
                let sql_stmt = "INSERT INTO ContentInfo VALUES() "
                if !contactDB.executeStatements(sql_stmt)
                {
                    print("Error: \(contactDB.lastErrorMessage())")
                }
                contactDB.close()
            }
            else
            {
                print("Error: \(contactDB.lastErrorMessage())")
            }
        
    }
    
    func InsertContentView()
    {
        var databasePath = "/Users/BridgeLabz/Documents/komal/ShoppingPad/ShoppingPad.sqlite"
        
        
        
        let contactDB = FMDatabase(path: databasePath as String)
        
        if contactDB == nil
        {
            print("Error: \(contactDB.lastErrorMessage())")
        }
        
        if contactDB.open()
        {
            //                let sql_stmt = "CREATE TABLE IF NOT EXISTS CONTACTS (ID INTEGER PRIMARY KEY AUTOINCREMENT, NAME TEXT, ADDRESS TEXT, PHONE TEXT)"
            //                if !contactDB.executeStatements(sql_stmt)
            //                {
            //                    print("Error: \(contactDB.lastErrorMessage())")
            //                }
            contactDB.close()
        }
        else
        {
            print("Error: \(contactDB.lastErrorMessage())")
        }
        
    }

}