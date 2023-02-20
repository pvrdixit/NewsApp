//
//  NewsViewModel.swift
//  NewsApp
//
//  Created by pvrdixit on 20/02/23.
//

import Foundation


struct NewsViewModel
{
    func getNewsByCountry(completion: @escaping(_ result: [Article], _ message: String?)-> Void)
    {
        let countryCode = UserDefaultUtility().getCountryCode()
        let newsRequest = NewsRequest(countryCode: countryCode, apiKey: ApiEndpoints.apiKey)
        let newsResource = NewsResource()
        
        newsResource.getNewsByCountry(newsRequest: newsRequest) { (newsResponse) in
            let viewData = newsResponse?.articles
            if let viewData {
                completion(viewData, nil)
            }
            else {
                let message = newsResponse?.message ?? "Sorry, Unable to load data"
                completion([], message)
            }
        }
    }
}


@propertyWrapper
struct CountryCodePropertyWrapper {
    private var _value: String
    var wrappedValue: String
    {
        get
        {
            switch _value {
                case "United States": return "us"
                case "Canada": return "ca"
                case "India": return "in"
                default: return "us"
            }
        }
        set
        {
            _value = newValue
        }
    }
    
    init(_countryName: String) {
        _value = _countryName
    }
}
