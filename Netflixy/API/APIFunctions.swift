//
//  APIFunctions.swift
//  Netflixy
//
//  Created by abdurhman elbosaty on 14/01/2022.
//

import Foundation
class APIFunctions{
    //###Trending Movies###
    class func getTrendingMovie(complition: @escaping ( _ response: TrendingTitleResponse ) -> Void){
        let base_URL = "/3/trending/movie/day?api_key="
        let url = Constans.get_URL()
        let finalUrl = url.domian + base_URL + url.key
        APIManger.Get(strURL: finalUrl, parameters: nil, headers: nil) { (status, response:TrendingTitleResponse?) in
            switch status {
            case .succ:
                complition(response!)
            case .fail:
                print("Cant reload trending movies")
            }
        }
    }
    //###Trending TV###
    class func getTrendingTv(complition: @escaping ( _ response: TrendingTitleResponse ) -> Void){
        let base_URL = "/3/trending/tv/day?api_key="
        let url = Constans.get_URL()
        let finalUrl = url.domian + base_URL + url.key
        APIManger.Get(strURL: finalUrl, parameters: nil, headers: nil) { (status, response:TrendingTitleResponse?) in
            switch status {
            case .succ:
                complition(response!)
            case .fail:
                print("cant reload trending tv")
            }
        }
    }
    //###Popular Movies###
    class func getPopularMovies(complition: @escaping ( _ response: TrendingTitleResponse ) -> Void){
        let base_URL = "/3/movie/popular?api_key="
        let url = Constans.get_URL()
        let finalUrl = url.domian + base_URL + url.key
        APIManger.Get(strURL: finalUrl, parameters: nil, headers: nil) { (status, response:TrendingTitleResponse?) in
            switch status {
            case .succ:
                complition(response!)
            case .fail:
                print("cant reload popular movies")
            }
        }
    }
    //###Upcomming Movies###
    class func getUpcommingMovies(complition: @escaping ( _ response: TrendingTitleResponse ) -> Void){
        let base_URL = "/3/movie/upcoming?api_key="
        let url = Constans.get_URL()
        let finalUrl = url.domian + base_URL + url.key
        APIManger.Get(strURL: finalUrl, parameters: nil, headers: nil) { (status, response:TrendingTitleResponse?) in
            switch status {
            case .succ:
                complition(response!)
            case .fail:
                print("cant reload upcomming movies")
            }
        }
    }
    //###Top Trending###
    class func getTopTrendingMovies(complition: @escaping ( _ response: TrendingTitleResponse ) -> Void){
        let base_URL = "/3/movie/top_rated?api_key="
        let url = Constans.get_URL()
        let finalUrl = url.domian + base_URL + url.key
        APIManger.Get(strURL: finalUrl, parameters: nil, headers: nil) { (status, response:TrendingTitleResponse?) in
            switch status {
            case .succ:
                complition(response!)
            case .fail:
                print("cant reload top trending movies")
            }
        }
    }
    //###Discover Movies###
    class func discoveredMovies(complition: @escaping ( _ response: TrendingTitleResponse ) -> Void){
        let base_URL = "/3/discover/movie?api_key="
        let url = Constans.get_URL()
        let finalUrl = url.domian + base_URL + url.key + "&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1&with_watch_monetization_types=flatrate"
        APIManger.Get(strURL: finalUrl, parameters: nil, headers: nil) { (status, response:TrendingTitleResponse?) in
            switch status {
            case .succ:
                complition(response!)
            case .fail:
                print("cant load")
            }
        }
    }
    //###Search###
    class func searchMovies(query: String, complition: @escaping ( _ response: TrendingTitleResponse ) -> Void){
        guard let finalQuery = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {return}
        
        let base_URL = "/3/search/movie?api_key="
        let url = Constans.get_URL()
        let finalUrl = url.domian + base_URL + url.key + "&query=\(finalQuery)"
        
        APIManger.Get(strURL: finalUrl, parameters: nil, headers: nil) { (status, response:TrendingTitleResponse?) in
            switch status {
            case .succ:
                complition(response!)
            case .fail:
                print("Cant")
            }
        }
    }
    
    
    
    //###Get From Youtube###
    class func getFromYoutube(title: String, complition: @escaping ( _ response: YoutubeResponse ) -> Void ){
        guard let query = title.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {return}
        let base_URL = "?q=\(query)&key="
        let finalUrl = Constans.YOUTUBE_URL + base_URL + Constans.YOUTUBE_API_KEY
        APIManger.Get(strURL: finalUrl, parameters: nil, headers: nil) { (status, response:YoutubeResponse?) in
            switch status {
            case .succ:
                complition(response!)
            case .fail:
                print("cant get from youtube")
            }
        }
    }
}
