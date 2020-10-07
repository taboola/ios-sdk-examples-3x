//
//  TaboolaWebDelegate.h
//  TaboolaView
//
//  Created by Tzufit Lifshitz on 8/19/19.
//  Copyright © 2019 Taboola. All rights reserved.
//

#ifndef TaboolaWebDelegate_h
#define TaboolaWebDelegate_h
#import <UIKit/UIKit.h>
#import "TBLClassicUnit.h"
#import <WebKit/WebKit.h>

@protocol TBLWebDelegate <NSObject>

@optional
/*!
@discussion When implemented, it allows the hosting app to decide what do do when intercepting clicks.

@param placementName The current placement (widget or feed)
@param itemId The placement's unique id
@param clickUrl A string representation of URL click
@param organic Determines whether the article is organic or sponsored

@return YES if the view should begin loading content; otherwise, NO. Default value is YES
*/
- (BOOL)onItemClick:(NSString *)placementName withItemId:(NSString *)itemId withClickUrl:(NSString *)clickUrl isOrganic:(BOOL)organic;

/*!
@discussion Triggered after the Taboola is succesfully rendered

@param webView The widget itself
@param placementName The current placement (widget or feed)
@param height TaboolaView's current height
*/
- (void)webView:(WKWebView *)webView didLoadPlacementNamed:(NSString *)placementName withHeight:(CGFloat)height;

/*!
@discussion Triggered after Taboola is failed to render.

@param webView The widget itself
@param placementName The current placement (widget or feed)
@param error The error recieved when TaboolaView is failed to render
*/
- (void)webView:(WKWebView *)webView didFailToLoadPlacementNamed:(NSString *)placementName withErrorMessage:(NSString *)error;


@end

#endif /* TaboolaWebDelegate_h */
