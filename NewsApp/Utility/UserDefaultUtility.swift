
//
//  UserDefaultUtility.swift
//  NewsApp
//
//  Created by pvrdixit on 20/02/23.
//

import Foundation

struct UserDefaultUtility
{
    func saveCountryPreference(countryCode: String)
    {
        UserDefaults.standard.set(countryCode, forKey: "countryCode")
    }

    func getCountryCode() -> String
    {
        return UserDefaults.standard.string(forKey: "countryCode") ?? "us" //Default USA
    }
    
    func getCountryPreference() -> String
    {
        let countryCode = UserDefaults.standard.string(forKey: "countryCode") ?? "us"
        switch countryCode {
            case "us": return "United States"
            case "ca": return "Canada"
            case "in": return "India"
            default: return "United States"
        }
    }
}
