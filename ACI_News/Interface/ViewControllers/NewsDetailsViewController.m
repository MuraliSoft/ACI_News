//
//  NewsDetailsViewController.m
//  ACI_News
//
//  Created by Murali Madhu on 09/02/24.
//

#import "NewsDetailsViewController.h"
#import <WebKit/WebKit.h>

@interface NewsDetailsViewController ()
@end

@implementation NewsDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    WKWebView *webView = [[WKWebView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:webView];
    webView.navigationDelegate = self;
    webView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;    if(self.newsURL) {
        NSURLRequest *request = [NSURLRequest requestWithURL:self.newsURL];
        [webView loadRequest:request];
    }
}

- (void)webView:(WKWebView *)webView didFailProvisionalLoadWithError:(NSError *)error {
    NSLog(@"Failed to load: %@", [error localizedDescription]);
    // You can inspect the error.code and error.domain here to handle specific errors
    
    // Optionally, inform the user of the error
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Loading Error"
                                                                   message:error.localizedDescription
                                                            preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:action];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error {
    NSLog(@"Failed to load with error: %@", error.localizedDescription);
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Loading Error"
                                                                   message:error.localizedDescription
                                                            preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:action];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation {
    NSLog(@"Finished loading");
}

@end
