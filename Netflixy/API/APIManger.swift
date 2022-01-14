//
//  APIManger.swift
//  Netflixy
//
//  Created by abdurhman elbosaty on 06/01/2022.
//

import Foundation

// Status Enum
enum Status{
    case succ
    case fail
}

class APIManger{
    
    class func Get<T: Codable>(strURL: String, parameters: [String:Any]?, headers: [String:String]?, complition: @escaping (_ status: Status , _ response: T? ) -> Void ){
        guard let url = URL(string: strURL) else{return}
        URLSession.shared.dataTask(with: url) { data, urlResponse, error in
            if error != nil {
                print(error?.localizedDescription as Any)
                complition(.fail, nil)
                return
            }
            guard let data = data else{return}
            
            do {
                let dataRes = try JSONDecoder().decode(T.self, from: data)
                print(dataRes)
                complition(.succ, dataRes )
            } catch  {
                print(error.localizedDescription)
                complition(.fail, nil)
            }
        }.resume()
    }
}


