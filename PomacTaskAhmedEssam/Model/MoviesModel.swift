//
//  MoviesModel.swift
//  PomacTaskAhmedEssam
//
//  Created by Adam on 10/30/20.
//

import Foundation


struct MoviesModel: Codable {
    let results: [ApiResults]?

}
    
    
struct ApiResults: Codable {
    
    let title: String?
    let publishedBy: String?
    let publishedDate: String?
    let multimedia: MultimediaStruction
    
    enum CodingKeys:String, CodingKey {
        case title = "display_title"
        case publishedBy = "byline"
        case publishedDate = "publication_date"
        case multimedia = "multimedia"
        
    }
}

struct MultimediaStruction: Codable {
    var photo: String
    
    enum CodingKeys: String, CodingKey {
        case photo = "src"
    }
}
