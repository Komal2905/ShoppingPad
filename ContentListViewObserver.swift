//
//  ContentListViewObserver.swift
//  ShoppingPad
//
//  Purpose: Observe the database and update ContentListView. Whenever there is change in
//           ContentListViewModel it will notify to ContentListView
//
//  Created by Vidya Ramamurthy on 06/03/16.
//  Copyright © 2016 BridgeLabz. All rights reserved.
//

import UIKit
import ReactiveKit
import ReactiveUIKit
import ReactiveFoundation

protocol PContentListViewObserver
{
    // update ContentListViewController
     func updateContentListViewModel()
}
