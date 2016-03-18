//
//  PContentListListener.swift
//  ShoppingPad
//
//  Created by Vidya Ramamurthy on 17/03/16.
//  Copyright © 2016 BridgeLabz. All rights reserved.
//

import Foundation

// define protocol which will be implemented by ContentListController

protocol PContentListListener
{
    // For ContentInfo
    func updateControllerInfoModel(JsonContentInfo : NSMutableArray)
    
    //For COntentVIew
    func updateControllerViewModel(JsonContentView : NSMutableArray)
}