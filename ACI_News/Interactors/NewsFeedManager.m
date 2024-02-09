//
//  NewsFeedManager.m
//  ACI_News
//
//  Created by Murali Madhu on 09/02/24.
//

#import "NewsFeedManager.h"
#import "NewsArticle.h"

@implementation NewsFeedManager

- (void)loadNewsArticlesWithCompletion:(void (^)(NSArray *articles, NSError *error))completion {
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"news" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    NSError *error;
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    
    if (error) {
        completion(nil, error);
        return;
    }
    
    NSArray *articlesJSON = json[@"articles"];
    NSMutableArray *articles = [NSMutableArray arrayWithCapacity:articlesJSON.count];
    
    for (NSDictionary *articleDict in articlesJSON) {
        NewsArticle *article = [[NewsArticle alloc] initWithDictionary:articleDict];
        [articles addObject:article];
    }
    
    // Sort by published date
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"publishedAt" ascending:NO];
    NSArray *sortedArticles = [articles sortedArrayUsingDescriptors:@[sortDescriptor]];
    
    completion(sortedArticles, nil);
}

@end
