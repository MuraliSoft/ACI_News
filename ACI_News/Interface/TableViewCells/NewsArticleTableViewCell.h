//
//  NewsArticleTableViewCell.h
//  ACI_News
//
//  Created by Murali Madhu on 09/02/24.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NewsArticleTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UIImageView *newsImageView;

@end

NS_ASSUME_NONNULL_END
