//
//  ViewModel.swift
//  ShoppingPad
//  Purpose : This class Holds variable for ViewModel
//
//
//  Created by Vidya Ramamurthy on 16/03/16.
//  Copyright © 2016 BridgeLabz. All rights reserved.
//



import ReactiveKit
import ReactiveUIKit
import ReactiveFoundation

// Holds variable
struct CViewModel
{
    var mContentImage : Observable<String>              // Thumbview Image link of the Content
    var mContentTitle : Observable<String>              // Title of Content
    var mNumberOfViews : Observable< Int>               // Total views of content
    var mNumberOfParticipant : Observable<Int>          // Total participant of Content
    var mLastViewedDate : Observable<String>            // last viewed time of Content
    var mActionPerformed : Observable<String>           // shows which action has been lastperformed on Content
    var mContentID : Observable<Int>
}

