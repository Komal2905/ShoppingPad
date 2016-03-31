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
import SystemConfiguration

import ReactiveKit
import ReactiveUIKit
import ReactiveFoundation
import Alamofire

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
            print("URL is not nil")
            // fetch the imageData from url
                //let data = NSData(contentsOfURL: url!)
            
            Alamofire.request(.GET, url!).response()
                {
                (_, _, data, _) in
                    if(data != nil)
                    {
                        convertedImage = UIImage(data: data! )!
                    }
                   
                }
            
            // if image data exist
            /*
            if (data != nil)
            {
                print("Data is not nill")
                // convert imagedata back to an image
                convertedImage = UIImage(data: data!)!
            }
            else
            {
                print("Data is nill")
                return convertedImage
            }*/
        }
      
        return convertedImage
    }
    
    func isConnectedToNetwork() -> Bool
    {
        // for socket address
        var zeroAddress = sockaddr_in()
        
        zeroAddress.sin_len = UInt8(sizeofValue(zeroAddress))
        
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        let defaultRouteReachability = withUnsafePointer(&zeroAddress)
            {
                SCNetworkReachabilityCreateWithAddress(nil, UnsafePointer($0))
        }
        var flags = SCNetworkReachabilityFlags()
        
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags)
        {
            return false
        }
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        
        return (isReachable && !needsConnection)
    }
    
    
    // testing Almo
    
    var testFetchError : Int = 0
    var testFetchSuccess : Int = 0
    
    // this function uses Almafire Libary for image fetching form URL
    func fetchImage(url: NSURL) -> Operation<UIImage, NSError>
    {
        return Operation { observer in
            
            // use almofire to deal with server request
            let request = Alamofire.request(.GET, url).response { request, response, data, error in
                
                // if error occurs then abort the operation
                if let error = error
                {
                    observer.next(UIImage(named: "defaultImage.png")!)
                
                    print("testFetchERRor : ",self.testFetchError)
                    self.testFetchError = self.testFetchError+1
                    
                    observer.failure(error)
                }
                else
                {
                    // if doesnt occurs error then convert imageData back to image
                    observer.next(UIImage(data : data!)!)
                    
                    print("testFetchSuccess : ",self.testFetchSuccess)
                    self.testFetchSuccess = self.testFetchSuccess+1
                    observer.success()
                }
            }
            
            // if response is nil then execute this block
            return BlockDisposable
            {
                request.cancel()
            }
        }
    }
    
    
    // this function uses Almafire Libary for image fetching form URL
    func fetchImage1(url: NSURL) -> UIImage
    {
       
        var convertedImage = UIImage()
        // use almofire to deal with server request
        let request = Alamofire.request(.GET, url).response { request, response, data, error in
                
            // if error occurs then abort the operation
            if let error = error
            {
                //if URL is Invalied then Return Default Image
                convertedImage = UIImage(named: "defaultImage.png")!
                
            }
            else
            {
                // if doesnt occurs error then convert imageData back to image
                convertedImage = UIImage(data : data!)!
                    
            }
        }
        
        // return Image
        return convertedImage
    
    }

    
    // This function dowload image in local path
    func downloadImage(urle : NSString)
    {
        // Trimm white Space
        let urlTrim = urle.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        
        // Convert To NSString
        let urlStr : NSString = urlTrim.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!
       
        
        let url = NSURL(string:urlStr as String)
        
        print("URL of source1",urlTrim)
        print("URL of sourcec3", url)
        
        // dowload Image To Local Path
        Alamofire.download(.GET, url!)
            {
                temporaryURL, response in
                // local path
                let fileManager = NSFileManager.defaultManager()
                let directoryURL = fileManager.URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)[0]
                let pathComponent = response.suggestedFilename
                
                print("directoryURL",directoryURL)
                return directoryURL.URLByAppendingPathComponent(pathComponent!)
            }
        
        }

    }


