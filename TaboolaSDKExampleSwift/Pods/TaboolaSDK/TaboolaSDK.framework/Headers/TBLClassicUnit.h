//
//  TBLClassicUnit.h
//
//  Created by Karen Shaham Palman on 26/08/2019.
//  Copyright © 2019 Taboola. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "TBLClassicPageDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@interface TBLClassicUnit : UIView

/*! @brief Optional. Use to override scrollIntercept. */
@property(nonatomic, readwrite) BOOL overrideScrollIntercept;

/*! @brief Optional. Controls whether the widget content is scrollable or not (default is enabled). */
@property(nonatomic, readwrite) BOOL scrollEnable;

/*! @brief Optional. Sets additional styling CSS rules for the widget. (e.g. Use it to control the widget's background). */
@property (nonatomic, strong) NSString *optionalWidgetStyle;

/*! @brief Show progress bar when Taboola Feed is being loaded. */
@property (nonatomic, readwrite) BOOL progressBarEnabled;

/*! @brief Optional. Sets the color of the progressBar, whenever the Feed is being loaded (default color is blue). */
@property(nonatomic, strong) NSString *progressBarColor;

/*! @brief Optional. Controls the progressBar animation duration. */
@property (nonatomic) CGFloat progressBarAnimationTime;

/*! @brief Optional. get the placement height. */
@property (nonatomic) CGFloat placementHeight;

/*!
 @brief After initializing TaboolaView, this method should be called to actually fetch the recommendations
*/
- (void)fetchContent;

/*
 @brief Resets TaboolaView - All conents and pushed commands are cleared. new commands must be pushed before fetching data again.
*/
- (void)reset;

/*!
 When returning from background mode and / or scrolling to top - call this function to ensure proper use in the SDK
 */
- (void)releaseScroll;

/*!
 Get Taboola's WKWebView
 */
- (UIScrollView *)getScrollView;

/*!
 @brief Show progress bar animation when scrolling in feed. Time in seconds
*/
-(void)startProgressBarAnimation;

/*!
 @brief Adds to paremeters an ActionType and relevant data
 
 @param actionType A NSNumber which represents the desired action
 @param data A String sent along with the actionType, in order to send extra info about the action
*/
- (void)setAction:(NSNumber*)actionType data:(NSString*)data;

/*!
 @brief Updating an ActionType with more relevant data
 
 @param actionType A NSNumber which represents the action needs to be updated
 @param data A String sent along with the actionType, in order to update the info about the action
*/
- (void)updateAction:(NSNumber*)actionType data:(NSString*)data;

/*!
 @brief Taboola SDK will manage UICollectionView in order to ease integration. Call this function from "collectionView:layout:sizeForItemAtIndexPath:" function on UICollectionViewDatasource delegate.
 
 @param collectionView Use same collectionView as in UICollectionViewDatasource delegate
 @param collectionViewLayout Use same collectionViewLayout as in UICollectionViewDatasource delegate
 @param indexPath Use same indexPath as in UICollectionViewDatasource delegate
 @param insets Sets TaboolaView insets
 
 @return Size of TaboolaView cell
*/
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath withUIInsets:(UIEdgeInsets)insets;

/*!
 @brief Taboola SDK will manage UICollectionView in order to ease integration. Call this function from "collectionView:cellForItemAtIndexPath:" function on UICollectionViewDatasource delegate.
 
 @param collectionView Use same collectionView as in UICollectionView function
 @param indexPath Use same indexPath as in UICollectionView function
 @param background Sets background color for TaboolaView cell
 
 @return UICollectionViewCell with TaboolaView
*/
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath withBackground:(nullable UIColor*)background;

/*!
 @brief Taboola SDK will manage UITableView in order to ease integration. Call this function from "tableView:heightForRowAtIndexPath:" function on UITableViewDatasource delegate.
 
 @param tableView Use same tableView as in UITableViewDelegate
 @param indexPath Use same indexPath as in UITableViewDelegate
 @param insets Sets TaboolaView insets

 @return Size of TaboolaView cell
*/
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath withUIInsets:(UIEdgeInsets)insets;

/*!
 @brief Taboola SDK will manage UITableView in order to ease integration. Call this function from "tableView:cellForRowAtIndexPath:" function on UITableViewDatasource delegate.
 
 @param tableView Use same tableView as in UITableView function
 @param indexPath Use same indexPath as in UITableView function
 @param background Sets background color for TaboolaView cell
 
 @return UITableViewCell with TaboolaView
*/
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath withBackground:(nullable UIColor*)background;

@end

NS_ASSUME_NONNULL_END
