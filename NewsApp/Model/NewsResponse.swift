//
//  NewsResponseModel.swift
//  NewsApp
//
//  Created by pvrdixit on 20/02/23.
//

import Foundation

struct NewsResponse: Decodable {
    let status: String
    let message: String?
    let articles : [Article]?
}


struct Source: Decodable {
    let name : String
}


struct Article: Decodable {
    let title: String
    let urlToImage: String?
    let url: String
    let source: Source
    private let publishedAt: String
    
    var headline: String  {
        get {
            if let index = title.lastIndex(of: "-") {
                return title.prefix(upTo: index).trimmingCharacters(in: .whitespacesAndNewlines)
            }
            else {
                return title
            }
        }
    }
    
    var datePublished: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let date = dateFormatter.date(from: publishedAt)
        
        dateFormatter.dateFormat = "d MMM y h:mm a"
        let formattedDateString = dateFormatter.string(from: date!)
        return formattedDateString
    }
}
