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
    private let apiKey: String

    var requestURL: URL {
        let urlString = "\(ApiEndpoints.newsRequest)?country=\(countryCode)&apiKey=\(apiKey)"
        return URL(string: urlString)!
    }
    
    init(countryCode: String, apiKey: String) {
        self.countryCode = countryCode
        self.apiKey = apiKey
    }
}
