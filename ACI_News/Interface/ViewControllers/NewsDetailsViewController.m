//
//  NewsDetailsViewController.m
//  ACI_News
//
//  Created by Murali Madhu on 09/02/24.
//

#import "NewsDetailsViewController.h"
#import <WebKit/WebKit.h>

@interface NewsDetailsViewController ()
@property (strong, nonatomic) UIActivityIndicatorView *activityIndicator;
@end

@implementation NewsDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Initialize and configure the web view
    WKWebView *webView = [[WKWebView alloc] initWithFrame:self.view.bounds];
    webView.navigationDelegate = self;
    webView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:webView];

    // Initialize the activity indicator
    self.activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleLarge];
    self.activityIndicator.center = self.view.center;
    self.activityIndicator.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    [self.view addSubview:self.activityIndicator];
    [self.activityIndicator startAnimating];

    // Load the request
    if(self.newsURL) {
        NSURLRequest *request = [NSURLRequest requestWithURL:self.newsURL];
        [webView loadRequest:request];
    }
}

- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(null_unspecified WKNavigation *)navigation {
    [self.activityIndicator startAnimating];
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation {
    [self.activityIndicator stopAnimating];
}

- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error {
    [self.activityIndicator stopAnimating];
    // Show error alert
    [self showAlertWithError:error];
}

- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    [self.activityIndicator stopAnimating];
    // Show error alert
    [self showAlertWithError:error];
}
- (void)showAlertWithError:(NSError *)error {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Loading Error"
                                                                   message:error.localizedDescription
                                                            preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:action];
    [self presentViewController:alert animated:YES completion:nil];
}

@end
