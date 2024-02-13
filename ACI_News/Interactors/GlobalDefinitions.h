//
//  GlobalDefinitions.h
//  ACI_News
//
//  Created by Murali Madhu on 13/02/24.
//

#ifndef GlobalDefinitions_h
#define GlobalDefinitions_h


#endif /* GlobalDefinitions_h */

#import <Foundation/Foundation.h>

extern NSString * const NewsArticleLoaderErrorDomain;

typedef NS_ENUM(NSInteger, NewsArticleLoaderErrorCode) {
    NewsArticleLoaderErrorNoData = 1,
    NewsArticleLoaderErrorJSONParsing = 2,
    NewsArticleLoaderErrorAPIServer = 3
};

