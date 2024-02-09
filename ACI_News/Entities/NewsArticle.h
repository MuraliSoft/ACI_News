//
//  NewsArticle.h
//  ACI_News
//
//  Created by Murali Madhu on 09/02/24.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NewsArticle : NSObject

@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *publishedAt;
@property (strong, nonatomic) NSString *url;
@property (strong, nonatomic) NSString *urlToImage;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

- (NSString *)formattedPublishedDate;
@end

NS_ASSUME_NONNULL_END
