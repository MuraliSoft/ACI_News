//
//  ViewController.m
//  ACI_News
//
//  Created by Murali Madhu on 09/02/24.
//

#import "NewsFeedViewController.h"
#import "NewsFeedManager.h"
#import "NewsArticle.h"
#import "NewsArticleTableViewCell.h"
#import "SDWebImage/SDWebImage.h"
#import "NewsDetailsViewController.h"

@interface NewsFeedViewController ()
@property (strong, nonatomic) NSArray *articles;
@property (strong, nonatomic) NSArray *filteredArticles;
@property (strong, nonatomic) UISearchController *searchController;
@end

@implementation NewsFeedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadNewsFeed];
    [self configTableViewCell];
    [self configSearchResultViewController];
}

- (void)configSearchResultViewController {
    // Initialize and configure the search controller
      self.searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
      self.searchController.searchResultsUpdater = self;
      self.searchController.obscuresBackgroundDuringPresentation = NO;
      self.searchController.searchBar.placeholder = @"Search Articles";
      self.tableView.tableHeaderView = self.searchController.searchBar;
      self.definesPresentationContext = YES;
}

- (void)configTableViewCell {
    // configure the tableview cell
    [self.tableView registerNib:[UINib nibWithNibName:@"NewsArticleTableViewCell" bundle:nil] forCellReuseIdentifier:@"NewsArticleCell"];
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 100; // Adjust this value based on your placeholder image size
}


- (void)loadNewsFeed {
    // load data from news JSON
    NewsFeedManager *manager = [[NewsFeedManager alloc] init];
    [manager loadNewsArticlesWithCompletion:^(NSArray *articles, NSError *error) {
        if (error) {
            NSLog(@"Error loading news articles: %@", error.localizedDescription);
            return;
        }
        self.articles = articles;
        self.filteredArticles = articles;
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    }];
}

#pragma mark - SearchController delegates
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    // Filter functionality
    NSString *searchText = searchController.searchBar.text;
    if (searchText && searchText.length > 0) {
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"title CONTAINS[cd] %@", searchText];
        self.filteredArticles = [self.articles filteredArrayUsingPredicate:predicate];
    } else {
        self.filteredArticles = self.articles;
    }
    [self.tableView reloadData];
}


#pragma mark - Table view data source and delegates

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // To set total no of rows
    return self.filteredArticles.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // Table view cell allocation and value also assigend
    NewsArticleTableViewCell *cell = (NewsArticleTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"NewsArticleCell" forIndexPath:indexPath];
    NewsArticle *article = self.filteredArticles[indexPath.row];
   
    cell.titleLabel.text = article.title;
    cell.dateLabel.text = article.formattedPublishedDate;
   
   // Use SDWebImage to load images asynchronously
    [cell.newsImageView sd_setImageWithURL:[NSURL URLWithString:article.urlToImage]
                         placeholderImage:[UIImage imageNamed:@"placeholder"]];
   
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Table view cell on click action
    NewsArticle *article = self.filteredArticles[indexPath.row];
    NSURL *url = [NSURL URLWithString:article.url];
    if (url) {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        NewsDetailsViewController *detailVC = [self.storyboard instantiateViewControllerWithIdentifier:@"NewsDetailsViewController"];
        detailVC.newsURL = url;
        [self.navigationController pushViewController:detailVC animated:YES];
    }
}

@end

