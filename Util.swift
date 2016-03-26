//
//  Util.swift
//  ShoppingPad
//
//  Purpose : This is Utility class. This has util functions to create round images
//
//  Created by Vidya Ramamurthy on 06/03/16.
//  Copyright © 2016 BridgeLabz. All rights reserved.
//

import Foundation
import UIKit

class Util
{
    
    // This function takes ImageView as a parameter and return round ImageView
    func roundImage(imageView : UIImageView)
    {
        imageView.layer.borderWidth = 1.0
        imageView.layer.masksToBounds = false
        imageView.layer.borderColor = UIColor.grayColor().CGColor
        
        imageView.layer.cornerRadius =  imageView.frame.size.height/2
        imageView.clipsToBounds = true
        imageView.contentMode = .ScaleAspectFill
        
    }
    
    // This function take UILable as argument and define totel number of lines
    func multiLineLabel(label : UILabel)
    {
        label.numberOfLines = 0
    }
   
    
    // this function takes an Image Url from Rest
    // and return an Image
    
    func getImage(urlString : String) -> UIImage
    {
        // define an image
        var convertedImage : UIImage = UIImage(named: "defaultImage.png")!
        
        // convert String url to NSURL
        let url = NSURL(string: urlString)
        
        // if url exist
        if (url != nil)
        {
            // fetch the imageData from url
            let data = NSData(contentsOfURL: url!)
            
            // if image data exist
            if (data != nil)
            {
                // convert imagedata back to an image
                convertedImage = UIImage(data: data!)!
            }
        }
        
        return convertedImage
    }
}
