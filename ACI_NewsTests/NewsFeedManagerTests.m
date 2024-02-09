//
//  ACI_NewsTests.m
//  ACI_NewsTests
//
//  Created by Murali Madhu on 09/02/24.
//

#import <XCTest/XCTest.h>

// NewsFeedManagerTests.m
#import <XCTest/XCTest.h>
#import "NewsFeedManager.h"

@interface NewsFeedManagerTests : XCTestCase

@end

@implementation NewsFeedManagerTests

- (void)testLoadNewsArticles {
    XCTestExpectation *expectation = [self expectationWithDescription:@"LoadNewsArticles"];
    NewsFeedManager *manager = [[NewsFeedManager alloc] init];
    
    [manager loadNewsArticlesWithCompletion:^(NSArray *articles, NSError *error) {
        XCTAssertNil(error);
        XCTAssertNotNil(articles);
        XCTAssertTrue(articles.count > 0);
        [expectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:5.0 handler:nil];
}

@end

