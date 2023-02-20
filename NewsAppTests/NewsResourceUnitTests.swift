//
//  NewsResourceUnitTests.swift
//  NewsAppTests
//
//  Created by pvrdixit on 20/02/23.
//

import XCTest
@testable import NewsApp

final class NewsResourceUnitTests: XCTestCase {
    
    func test_NewsResource_WithValidRequestAndValidAPIKey_ReturnsArticles() {
        let newsRequest = NewsRequest(countryCode: "us", apiKey: ApiEndpoints.apiKey)
        let newsResource = NewsResource()
        let expectation = self.expectation(description: "ValidRequest_ReturnsArticles")

        newsResource.getNewsByCountry(newsRequest: newsRequest) { (newsResponse) in
            XCTAssertNotNil(newsResponse)
            XCTAssertNil(newsResponse?.message)
            XCTAssertNotEqual(newsResponse?.articles?.count, 0)
            expectation.fulfill()

        }
        
        waitForExpectations(timeout: 5, handler: nil)

    }
    
    
    func test_NewsResource_WithValidRequestAndInvalidCountry_ReturnsError() {
        let newsRequest = NewsRequest(countryCode: "unknown", apiKey: ApiEndpoints.apiKey)
        let newsResource = NewsResource()
        let expectation = self.expectation(description: "InvalidCountry_ReturnsMessage")
        
        newsResource.getNewsByCountry(newsRequest: newsRequest) { (newsResponse) in
            XCTAssertNotNil(newsResponse)
            XCTAssertNotNil(newsResponse?.message)
            XCTAssertEqual(newsResponse?.articles?.count, 0)
            expectation.fulfill()
            
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    
    func test_NewsResource_WithValidRequestAndInvalidAPIKey_ReturnsError() {
        let newsRequest = NewsRequest(countryCode: "unknown", apiKey: "invalid_Key")
        let newsResource = NewsResource()
        let expectation = self.expectation(description: "InvalidAPIRequest_ReturnsMessage")
        
        newsResource.getNewsByCountry(newsRequest: newsRequest) { (newsResponse) in
            XCTAssertNotNil(newsResponse)
            XCTAssertNotNil(newsResponse?.message)
            XCTAssertNil(newsResponse?.articles)
            expectation.fulfill()
            
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
}
