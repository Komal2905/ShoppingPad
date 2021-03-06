//
//  PContentListListener.swift
//  ShoppingPad
//
//  purpose : defining protocol implemented by ContentListController
//
//  Created by Vidya Ramamurthy on 17/03/16.
//  Copyright © 2016 BridgeLabz. All rights reserved.
//

import Foundation

// define protocol which will be implemented by ContentListController 

protocol PControllerListener
{
    // For ContentInfo
    func updateControllerInfoModel(JsonContentInfo : NSMutableArray)
    
    //For COntentVIew
    func updateControllerViewModel(JsonContentView : NSMutableArray)
    
    // for ContentParticipant
    func updateContentParticipant(JsonContentParticipant : NSMutableArray)

}

