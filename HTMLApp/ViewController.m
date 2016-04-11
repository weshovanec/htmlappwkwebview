//
//  ViewController.m
//  HTMLApp
//
//  Created by Wesley Hovanec on 4/24/15.
//  Copyright (c) 2015 Wesley Hovanec. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
    self.webPage = [[WKWebView alloc] initWithFrame:CGRectZero configuration:config];
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:self.webPage, @"webPage", self.topLayoutGuide, @"topLayoutGuide", nil];
    self.webPage.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.webPage];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[topLayoutGuide]-2-[webPage]-2-|" options:0 metrics:0 views:dic]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-2-[webPage]-2-|" options:0 metrics:0 views:dic]];
    [self.webPage loadHTMLString:[NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"buttonwebsite" ofType:@"html"] encoding:NSUTF8StringEncoding error:nil] baseURL:nil];
    [self.webPage setUIDelegate:self];
    [self.webPage setNavigationDelegate:self];
    [self.view bringSubviewToFront:self.button];
    [self.view bringSubviewToFront:self.label];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    if (navigationAction.navigationType == 1) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"UIAlertController" message:@"Alert" preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"OK"
                                                           style:UIAlertActionStyleCancel
                                                         handler:nil]];
        [self presentViewController:alertController animated:YES completion:nil];
        decisionHandler(WKNavigationActionPolicyCancel);
    }
    decisionHandler(WKNavigationActionPolicyAllow);
}

- (IBAction)button:(id)sender {
    [self.webPage evaluateJavaScript:@"alert(\"Javascript Alert\")" completionHandler:nil];
}

-(void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)())completionHandler {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:message
                                                                             message:nil
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"OK"
                                                        style:UIAlertActionStyleCancel
                                                      handler:^(UIAlertAction *action) {
                                                          completionHandler();
                                                      }]];
    [self presentViewController:alertController animated:YES completion:nil];
}

@end
