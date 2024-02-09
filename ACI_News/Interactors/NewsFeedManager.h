//
//  NewsFeedManager.h
//  ACI_News
//
//  Created by Murali Madhu on 09/02/24.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NewsFeedManager : NSObject

- (void)loadNewsArticlesWithCompletion:(void (^)(NSArray *articles, NSError *error))completion;

@end

NS_ASSUME_NONNULL_END
