//
//  NewsArticleParser.h
//  ACI_News
//
//  Created by Murali Madhu on 13/02/24.
//

#import <Foundation/Foundation.h>
#import "NewsArticle.h"

NS_ASSUME_NONNULL_BEGIN

@interface NewsArticleParser : NSObject
- (NSArray<NewsArticle *> *)parseArticlesFromJSONData:(NSData *)jsonData error:(NSError **)error;
@end

NS_ASSUME_NONNULL_END
