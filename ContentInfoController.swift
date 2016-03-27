//
//  ContentInfoController.swift
//  ShoppingPad
//  Purpose:
//  1) Intract with REST service to get data.
//  2) Intract with Local DB to save and retrive content data.
//  3) encapusulating ContentInfo.
//  4) Data controller in MVVM architecture
//  5) Provide interface of View Model to intract with controller. Abstracting Database layer,
//     service layer and model layer.
//  Created by Vidya Ramamurthy on 21/03/16.
//  Copyright © 2016 BridgeLabz. All rights reserved.
//

import Foundation

// hold variable of perticular content
struct ContentDetails
{
    var mContentID : Int!
    var mContentTitle : String!
}
