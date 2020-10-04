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
- (void)webView:(UIView *)webView didLoadPlacementNamed:(NSString *)placementName withHeight:(CGFloat)height;

/*!
@discussion Triggered after Taboola is failed to render.

@param webView The widget itself
@param placementName The current placement (widget or feed)
@param error The error recieved when TaboolaView is failed to render
*/
- (void)webView:(UIView *)webView didFailToLoadPlacementNamed:(NSString *)placementName withErrorMessage:(NSString *)error;

/*!
 @discussion Triggered when the TaboolaView is scrolled to top
 
 @param webView The widget itself
*/
- (void)scrollViewDidScrollToTopWebView:(UIView *)webView;

/*!
 @discussion Triggered when there is an action is managed by the publisher
 
 @param actionType The action's identifier
 @param data Dictionary that contains the action's key-value data
*/
- (void)clickedOnAction:(NSNumber *)actionType data:(NSDictionary *)data;

@end

#endif /* TaboolaWebDelegate_h */
