//
//  NewsResource.swift
//  NewsApp
//
//  Created by pvrdixit on 20/02/23.
//

import Foundation


struct NewsResource
{
    func getNewsByCountry(newsRequest: NewsRequest, completion: @escaping(_ result : NewsResponse?) -> Void)
    {
        let httpUtility = HttpUtility()
        
        httpUtility.getApiData(requestUrl: newsRequest.requestURL, resultType: NewsResponse.self) { (newsResponse) in
            
            _ = completion(newsResponse)
        }
    }
}
