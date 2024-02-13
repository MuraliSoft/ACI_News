//
//  NewsFeedManager.m
//  ACI_News
//
//  Created by Murali Madhu on 09/02/24.
//

#import "NewsFeedManager.h"
#import "NewsArticle.h"
#import "NewsArticleParser.h"
#import "GlobalDefinitions.h"

@implementation NewsFeedManager

- (void)loadNewsArticlesWithCompletion:(void (^)(NSArray *articles, NSError *error))completion {
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"news" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    if (!data) {
        NSError *error = [NSError errorWithDomain:@"com.yourapp.error" code:1001 userInfo:@{NSLocalizedDescriptionKey: @"Failed to load data from file."}];
        completion(nil, error);
        return;
    }
    
    NewsArticleParser *parser = [[NewsArticleParser alloc] init];
    NSError *parseError;
    NSArray *articles = [parser parseArticlesFromJSONData:data error:&parseError];
    if (parseError) {
        completion(nil, parseError);
        return;
    }
    
    // Optionally sort by published date
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"publishedAt" ascending:NO];
    NSArray *sortedArticles = [articles sortedArrayUsingDescriptors:@[sortDescriptor]];
    
    completion(sortedArticles, nil);
}


- (void)loadNewsArticlesFromAPIWithCompletion:(void (^)(NSArray *articles, NSError *error))completion {
    NSURL *url = [NSURL URLWithString: @"https://example.com/api/news"];
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (error) {
            completion(nil, error); // Handle network error
            return;
        }
        
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
        if (httpResponse.statusCode != 200) {
            NSError *apiError = [NSError errorWithDomain:NewsArticleLoaderErrorDomain code:NewsArticleLoaderErrorAPIServer userInfo:@{NSLocalizedDescriptionKey: [NSString stringWithFormat:@"API Error: %ld", (long)httpResponse.statusCode]}];
            completion(nil, apiError); // Handle API error
            return;
        }
        
        if (!data) {
            NSError *noDataError = [NSError errorWithDomain:NewsArticleLoaderErrorDomain code:NewsArticleLoaderErrorNoData userInfo:@{NSLocalizedDescriptionKey: @"No data received from API"}];
            completion(nil, noDataError); // Handle no data error
            return;
        }
        
        NewsArticleParser *parser = [[NewsArticleParser alloc] init];
        NSError *parseError;
        NSArray *articles = [parser parseArticlesFromJSONData:data error:&parseError];
        if (parseError) {
            completion(nil, parseError); // Handle parsing error
            return;
        }
        
        // Optionally sort by published date
        NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"publishedAt" ascending:NO];
        NSArray *sortedArticles = [articles sortedArrayUsingDescriptors:@[sortDescriptor]];
        
        completion(sortedArticles, nil);
    }];
    [task resume];
}

@end
