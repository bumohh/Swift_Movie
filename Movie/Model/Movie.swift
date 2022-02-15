//
//  Movie.swift
//  Movie
//
//  Created by Bruno Gomez on 2/11/22.
//
import Foundation

struct Movie : Codable { //must conform to codable to be used in jsondecoder
    
    var duration : Double?
    var createdAt : String?
    var plays : Int?
    var transcodings : [Transcodings]?
    var title : String?
    
    enum CodingKeys : String, CodingKey {
        case duration,plays,transcodings
        case createdAt = "created_at"
    }
    
}


struct Transcodings : Codable {
    var id : String?
    var size : Int?
    var title : String?
    var height : Int?
    var width : Int?
    var state : String?
    
}
