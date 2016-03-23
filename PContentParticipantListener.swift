//
//  PContentParticipantListener.swift
//  ShoppingPad
//
//  purpose : defining protocol implemented by ContentInfoController
//
//  Created by Vidya Ramamurthy on 23/03/16.
//  Copyright © 2016 BridgeLabz. All rights reserved.
//

import Foundation



// define protocol which will be implemented by ContentInfoController
protocol PContentParticipantListener
{
    // for ContentParticipant
    func updateContentParticipant(JsonContentParticipant : NSMutableArray)
}