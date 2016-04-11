//
//  ViewController.h
//  HTMLApp
//
//  Created by Wesley Hovanec on 4/24/15.
//  Copyright (c) 2015 Wesley Hovanec. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

@interface ViewController : UIViewController <WKUIDelegate, WKNavigationDelegate>

@property (strong, nonatomic) IBOutlet WKWebView *webPage;
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UIButton *button;

@end

