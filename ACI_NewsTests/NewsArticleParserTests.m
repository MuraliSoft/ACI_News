//
//  NewsArticleParserTests.m
//  ACI_NewsTests
//
//  Created by Murali Madhu on 13/02/24.
//

#import <XCTest/XCTest.h>
#import "NewsArticleParser.h" // Replace with your actual parser class header
#import "NewsArticle.h"
#import "GlobalDefinitions.h"


@interface NewsArticleParserTests : XCTestCase

@end

@implementation NewsArticleParserTests

- (void)testParseArticlesFromValidJSON {
    // Prepare valid JSON data
    NSString *validJSONString = @"{\"articles\": [{\"publishedAt\": \"2024-01-10T22:41:25Z\", \"title\": \"Test Title\", \"url\": \"https://example.com/article\", \"urlToImage\": \"https://example.com/image.jpg\"}]}";
    NSData *validJSONData = [validJSONString dataUsingEncoding:NSUTF8StringEncoding];
    
    // Initialize the parser
    NewsArticleParser *parser = [[NewsArticleParser alloc] init];
    
    // Perform parsing
    NSError *error = nil;
    NSArray<NewsArticle *> *articles = [parser parseArticlesFromJSONData:validJSONData error:&error];
    
    // Assertions
    XCTAssertNotNil(articles, @"Parsing should succeed and return non-nil articles array.");
    XCTAssertTrue(articles.count == 1, @"There should be one article parsed.");
    XCTAssertNil(error, @"No error should occur during successful parsing.");
}


- (void)testParseArticlesFromInvalidJSON {
    // Prepare invalid JSON data
    NSString *invalidJSONString = @"Invalid JSON";
    NSData *invalidJSONData = [invalidJSONString dataUsingEncoding:NSUTF8StringEncoding];
    
    // Initialize the parser
    NewsArticleParser *parser = [[NewsArticleParser alloc] init];
    
    // Perform parsing
    NSError *error = nil;
    NSArray<NewsArticle *> *articles = [parser parseArticlesFromJSONData:invalidJSONData error:&error];
    
    // Assertions
    XCTAssertNil(articles, @"Parsing should fail and return nil articles array.");
    XCTAssertNotNil(error, @"An error should occur during parsing of invalid JSON.");
}

- (void)testParseArticlesFromJSONWithoutArticlesKey {
    // Prepare JSON data without 'articles' key
    NSString *jsonStringWithoutArticlesKey = @"{\"unexpectedKey\": []}";
    NSData *jsonDataWithoutArticlesKey = [jsonStringWithoutArticlesKey dataUsingEncoding:NSUTF8StringEncoding];
    
    // Initialize the parser
    NewsArticleParser *parser = [[NewsArticleParser alloc] init];
    
    // Perform parsing
    NSError *error = nil;
    NSArray<NewsArticle *> *articles = [parser parseArticlesFromJSONData:jsonDataWithoutArticlesKey error:&error];
    
    // Assertions
    XCTAssertNil(articles, @"Parsing should fail and return nil articles array when 'articles' key is missing.");
    XCTAssertNotNil(error, @"An error should occur when JSON does not contain the expected 'articles' key.");
    XCTAssertEqual(error.code, NewsArticleLoaderErrorJSONParsing, @"Error code should match NewsArticleLoaderErrorJSONParsing.");
}

@end
