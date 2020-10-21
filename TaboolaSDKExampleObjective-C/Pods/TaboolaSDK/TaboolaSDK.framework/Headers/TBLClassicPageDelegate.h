//
//  TBLClassicPageDelegate.h
//  TaboolaView
//
//  Created by Karen Shaham Palman on 27/08/2019.
//  Copyright © 2019 Taboola. All rights reserved.
//

#ifndef TBLClassicPageDelegate_h
#define TBLClassicPageDelegate_h
#import <UIKit/UIKit.h>

/*! @brief Enum. Determines the placement's type (Feed or Widget). */
typedef enum {
    PlacementTypeFeed,
    PlacementTypeWidget,
    PlacementTypeWidgetNone
} PlacementType;
/*!
 This protocol should be implemented by the host app. TaboolaView sends various lifecycle events to the delegate, to allow more flexibility for the host app.
 */
@protocol TBLClassicPageDelegate <NSObject>

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
@discussion Triggered while the TaboolaView is being rendered

@param taboolaView The widget itself
@param placementName The current placement (widget or feed)
@param height TaboolaView's current height
*/
- (void)taboolaView:(UIView *)taboolaView didLoadOrResizePlacement:(NSString *)placementName withHeight:(CGFloat)height placementType:(PlacementType)placementType;

/*!
@discussion Triggered after TaboolaView is failed to render.

@param taboolaView The widget itself
@param placementName The current placement (widget or feed)
@param error The error recieved when TaboolaView is failed to render
*/
- (void)taboolaView:(UIView *)taboolaView didFailToLoadPlacementNamed:(NSString *)placementName withErrorMessage:(NSString *)error;

/*!
 @discussion Triggered when the TaboolaView is scrolled to top
 
 @param taboolaView The widget itself
*/
- (void)scrollViewDidScrollToTopTaboolaView:(UIView *)taboolaView;

/*!
 @discussion Triggered when an action was clicked (e.g. clicked Save For Later)
 
 @param actionType The specific type of action sent
 @param data A dictionary of parameters that is being sent along with the action
*/
- (void)clickedOnAction:(NSNumber *)actionType data:(NSDictionary *)data;

@end

#endif /* TaboolaViewDelegate_h */
