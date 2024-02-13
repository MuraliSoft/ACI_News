//
//  NewsArticleTests.m
//  ACI_NewsTests
//
//  Created by Murali Madhu on 13/02/24.
//

#import <XCTest/XCTest.h>
#import "NewsArticle.h"

@interface NewsArticleTests : XCTestCase
@end

@implementation NewsArticleTests

- (void)testNewsArticleInitialization {
    // Define a mock dictionary with article data
    NSDictionary *mockArticleData = @{
        @"title": @"Test Article",
        @"publishedAt": @"2024-01-10T22:41:25Z",
        @"url": @"https://example.com/article",
        @"urlToImage": @"https://example.com/image.jpg"
    };
    
    // Initialize NewsArticle with the mock dictionary
    NewsArticle *article = [[NewsArticle alloc] initWithDictionary:mockArticleData];
    
    // Verify that the NewsArticle properties are correctly set
    XCTAssertEqualObjects(article.title, @"Test Article", @"The title should match the dictionary value.");
    XCTAssertEqualObjects(article.publishedAt, @"2024-01-10T22:41:25Z", @"The publishedAt should match the dictionary value.");
    XCTAssertEqualObjects(article.url, @"https://example.com/article", @"The URL should match the dictionary value.");
    XCTAssertEqualObjects(article.urlToImage, @"https://example.com/image.jpg", @"The URL to image should match the dictionary value.");

}

@end
