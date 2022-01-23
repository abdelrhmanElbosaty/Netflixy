//
//  HelperFunctions.swift
//  Netflixy
//
//  Created by abdurhman elbosaty on 23/01/2022.
//

import Foundation
import CoreData
class HelperFunctions {
    static func insertToEntity(indexPath: IndexPath, titles: [Title]){
        let obj = NSEntityDescription.insertNewObject(forEntityName: "MovieEnt", into: context) as! MovieEnt
        obj.id = Int64(titles[indexPath.row].id)
        obj.media_type = titles[indexPath.row].media_type
        obj.original_name = titles[indexPath.row].original_name
        obj.original_title = titles[indexPath.row].original_title
        obj.overview = titles[indexPath.row].overview
        obj.poster_path = titles[indexPath.row].poster_path
        obj.release_date = titles[indexPath.row].release_date
        obj.vote_average = titles[indexPath.row].vote_average
        obj.vote_count = Int64(titles[indexPath.row].vote_count)
        
        context.insert(obj)
        do {
            try context.save()
            print("saved")
        } catch  {
            print(error.localizedDescription)
        }
    }
    static func insertToEntity( titles: Title){
        let obj = NSEntityDescription.insertNewObject(forEntityName: "MovieEnt", into: context) as! MovieEnt
        obj.id = Int64(titles.id)
        obj.media_type = titles.media_type
        obj.original_name = titles.original_name
        obj.original_title = titles.original_title
        obj.overview = titles.overview
        obj.poster_path = titles.poster_path
        obj.release_date = titles.release_date
        obj.vote_average = titles.vote_average
        obj.vote_count = Int64(titles.vote_count)
        
        context.insert(obj)
        do {
            try context.save()
            print("saved")
        } catch  {
            print(error.localizedDescription)
        }
    }
}
