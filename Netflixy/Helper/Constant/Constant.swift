//
//  Constant.swift
//  Netflixy
//
//  Created by abdurhman elbosaty on 05/01/2022.
//

import Foundation
import UIKit

final class Constans{
    
    static let ScreenWidth = UIScreen.main.bounds.width
    static let ScreenHeight = UIScreen.main.bounds.height
    
    private static let domain = "https://api.themoviedb.org"
    static let API_KEY = "477d9c6eeae4f2d4918ae1563b233162"
    static let YOUTUBE_API_KEY = "AIzaSyBYxLb1nnku1UMHAD8Og6qBwOJ2oKXclXw"
    static let YOUTUBE_URL = "https://youtube.googleapis.com/youtube/v3/search"
    
    class func get_URL()-> (domian: String, key: String){
     return (domain,API_KEY)
    }
    
   private static let Default_Header = ["Content-Type":"application/json"]
    
    class func getDefaultHeader()-> [String:String]{
        return Default_Header
    }
    
}

