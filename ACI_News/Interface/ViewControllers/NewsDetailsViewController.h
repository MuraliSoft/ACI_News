//
//  NewsDetailsViewController.h
//  ACI_News
//
//  Created by Murali Madhu on 09/02/24.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NewsDetailsViewController : UIViewController <WKNavigationDelegate>
@property (strong, nonatomic) NSURL *newsURL;
@end

NS_ASSUME_NONNULL_END
