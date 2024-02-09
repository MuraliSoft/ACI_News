//
//  NewsArticle.m
//  ACI_News
//
//  Created by Murali Madhu on 09/02/24.
//

#import "NewsArticle.h"

@implementation NewsArticle

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        _title = dictionary[@"title"];
        _publishedAt = dictionary[@"publishedAt"];
        _url = dictionary[@"url"];
        _urlToImage = dictionary[@"urlToImage"];
    }
    return self;
}

- (NSString *)formattedPublishedDate {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd'T'HH:mm:ssZ";
    
    // Your NSDate object
    NSDate *date = [formatter dateFromString:_publishedAt];

    // Create an NSDateFormatter for the day
    NSDateFormatter *dayFormatter = [[NSDateFormatter alloc] init];
    [dayFormatter setDateFormat:@"dd"];

    // Create another formatter for the month and year
    NSDateFormatter *monthYearFormatter = [[NSDateFormatter alloc] init];
    [monthYearFormatter setDateFormat:@"MMM yy"];

    // Get the day as a number
    NSInteger dayNumber = [[dayFormatter stringFromDate:date] integerValue];

    // Determine the suffix
    NSString *suffix;
    switch (dayNumber % 10) {
        case 1:
            suffix = (dayNumber % 100 == 11) ? @"th" : @"st";
            break;
        case 2:
            suffix = (dayNumber % 100 == 12) ? @"th" : @"nd";
            break;
        case 3:
            suffix = (dayNumber % 100 == 13) ? @"th" : @"rd";
            break;
        default:
            suffix = @"th";
            break;
    }

    // Assemble the final string
    NSString *dayString = [NSString stringWithFormat:@"%ld%@", (long)dayNumber, suffix];
    NSString *monthYearString = [monthYearFormatter stringFromDate:date];
    NSString *finalDateString = [NSString stringWithFormat:@"%@ %@", dayString, monthYearString];
    
    return finalDateString;
}




@end
