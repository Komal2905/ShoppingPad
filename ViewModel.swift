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

// Holds variable for ViewModel ContentList
struct ContentListViewModel
{
    var mContentImage : Observable<String>              // Thumbview Image link of the Content
    var mContentTitle : Observable<String>              // Title of Content
    var mNumberOfViews : Observable<String>             // Total views of content
    var mNumberOfParticipant : Observable<String>        // Total participant of Content
    var mLastViewedDate : Observable<String>            // last viewed time of Content
    var mActionPerformed : Observable<String>           // shows which action has been lastperformed on Content
    var mContentID : Observable<String>
}

// Structure holds variable For COntentInfoViewModel
// It give list of participants for Content

struct ContentParticipantViewModel
{
    var mContentID : Observable<String>
    var mContentTitle : Observable<String>
    var mParticipantName : Observable<String>
    var mParticipantLastOpenedDate : Observable<String>
    var mParticipantAction : Observable<String>
    var mParticipantViewCount : Observable<String>
    var mParticipantImageView : Observable<String>
    var mParticipantId : Observable<String>

}

// for ContentDetails

struct ContentDetailsViewModel
{
    var mContentID : Observable<String>
    var mContentTitle : Observable<String>
    var mContentImage : Observable<String>              // Thumbview Image link of the Content
}