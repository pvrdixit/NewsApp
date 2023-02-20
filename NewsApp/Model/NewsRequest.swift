//
//  NewsRequestModel.swift
//  NewsApp
//
//  Created by pvrdixit on 20/02/23.
//

import Foundation

struct NewsRequest
{
    private let countryCode: String
    var requestURL: URL {
        let urlString = "\(ApiEndpoints.newsRequest)?country=\(countryCode)&apiKey=\(ApiEndpoints.apiKey)"
        return URL(string: urlString)!
    }
    
    init(countryCode: String) {
        self.countryCode = countryCode
    }
}
