//
//  WebViewController.m
//  TaboolaSDKExampleObjective-C
//
//  Created by Liad Elidan on 24/05/2020.
//  Copyright © 2020 Liad Elidan. All rights reserved.
//

#import "WebViewController.h"
#import <TaboolaSDK/TaboolaSDK.h>
#import <WebKit/WebKit.h>


@interface WebViewController () <WKNavigationDelegate, TBLWebDelegate>

@property (weak, nonatomic) IBOutlet UIView *webViewContainer;

// TBLWebPage object that will contain the JS recommendation content
@property (nonatomic, strong) TBLWebPage* webPage;
@property (nonatomic, strong) WKWebView *webView;

@end

@implementation WebViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    _webView = [[WKWebView alloc] initWithFrame:CGRectZero];
    
    _webView.frame = self.view.frame;
    [_webViewContainer addSubview:_webView];
    
    TBLWebPage* jsPage = [[TBLWebPage alloc]initWithDelegate:self];
    [jsPage createUnitWithWebView:_webView];
    
    [self loadExamplePage:_webView];
}

- (void)loadExamplePage:(WKWebView*)webView {
    NSString* htmlPath = [[NSBundle mainBundle] pathForResource:@"SampleHTMLPage" ofType:@"html"];
    NSString* appHtml = [NSString stringWithContentsOfFile:htmlPath encoding:NSUTF8StringEncoding error:nil];
    [webView loadHTMLString:appHtml baseURL:[NSURL URLWithString:@"https://cdn.taboola.com/mobile-sdk/init/"]];
}

-(void)webView:(UIView *)webView didLoadPlacementNamed:(NSString *)placementName withHeight:(CGFloat)height{
    NSLog(@"%@", placementName);
}

- (void)taboolaView:(UIView *)taboolaView didFailToLoadPlacementNamed:(NSString *)placementName withErrorMessage:(NSString *)error {
    NSLog(@"%@", error);
}

- (BOOL)onItemClick:(NSString *)placementName withItemId:(NSString *)itemId withClickUrl:(NSString *)clickUrl isOrganic:(BOOL)organic {
    if (!organic) {
        return NO;
    }
    return YES;
}

@end
