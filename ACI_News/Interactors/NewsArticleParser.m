//
//  NewsArticleParser.m
//  ACI_News
//
//  Created by Murali Madhu on 13/02/24.
//

#import "NewsArticleParser.h"
#import "GlobalDefinitions.h"

@implementation NewsArticleParser
- (NSArray<NewsArticle *> *)parseArticlesFromJSONData:(NSData *)jsonData error:(NSError **)error {
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:error];
    if (!json) {
        return nil; // Error is set by NSJSONSerialization
    }
    
    NSArray *articlesJSON = json[@"articles"];
    if (!articlesJSON) {
        if (error) {
            *error = [NSError errorWithDomain:NewsArticleLoaderErrorDomain code:NewsArticleLoaderErrorJSONParsing userInfo:@{NSLocalizedDescriptionKey: @"Unable to find 'articles' key in JSON"}];
        }
        return nil;
    }
    
    NSMutableArray *articles = [NSMutableArray arrayWithCapacity:articlesJSON.count];
    for (NSDictionary *articleDict in articlesJSON) {
        NewsArticle *article = [[NewsArticle alloc] initWithDictionary:articleDict];
        [articles addObject:article];
    }
    
    return articles;
}

@end
