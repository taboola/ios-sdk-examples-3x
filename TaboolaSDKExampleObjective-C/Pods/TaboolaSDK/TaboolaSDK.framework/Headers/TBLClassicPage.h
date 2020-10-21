//
//  TBLClassicPage.h
//  TaboolaView
//
//  Created by Karen Shaham Palman on 21/08/2019.
//  Copyright © 2019 Taboola. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TBLClassicPageDelegate.h"
#import "TBLClassicUnit.h"
#import "TBLPage.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, FetchingPolicy) {
    FetchingPolicySerial = 0,
    FetchingPolicyParallel
};

/*!
 TBLClassicPage is the first object to initialize, and is being used to create TaboolaView (widget or Feed)
 */
@interface TBLClassicPage : TBLPage

/*! @brief Optional. Change only if it's specified by your Taboola account manager (default is "mix"). */
@property (nonatomic, strong) NSString *targetType;

/*! @brief Optional. Sets the pageId of the page on which the widget is displayed (default is to auto generate from URL). */
@property (nonatomic, strong) NSString *pageId;

/*! @brief Optional. pageExtraProperties is a dictionary contains relevant property keys and data values. */
@property (nonatomic, strong) NSDictionary *pageExtraProperties;

/*! @brief Optional. Use fetchingPolicy to change FetchingPolicy. Defult value 'FetchingPolicySerial' */
@property (nonatomic) FetchingPolicy fetchingPolicy;

/*! @brief Optional. If Use fetchingPolicy is 'FetchingPolicySerial' it will use serialDelay in millis. Defult value '3000' */
@property (nonatomic) int serialDelay;

/*!
 @discussion Init function for the TBLClassicPage
 
 @param pageType String describes the page type (e.g. "article")
 @param pageUrl String describes the website's URL
 @param delegate Sets the listener for Taboola calls
 @param scrollView Current scrollView. Normally will be CollectionView / TableView

 @return TBLClassicPage object
 */
- (instancetype)initWithPageType:(NSString *)pageType pageUrl:(NSString *)pageUrl delegate:(id<TBLClassicPageDelegate>)delegate scrollView:(UIScrollView*)scrollView;

/*!
 @param name The current placement's name
 @param mode Widget's UI mode (template)
 @param type PlacementType enum for widget or feed
*/

/*!
  @discussion A must function that creates TBLClassicUnit in order to build Taboola widgets
  @return TBLClassicUnit object (Taboola widget / Feed)
 */
- (TBLClassicUnit*)createUnitWithPlacementName:(NSString *)placementName mode:(NSString *)mode;

/*!
 @discussion A must function that builds a unit with an object TBLClassicUnit that was created in the Storyboard/xib
*/
- (void)addUnit:(TBLClassicUnit*)unit placementName:(NSString *)placementName mode:(NSString *)mode;

/*!
 @discussion Call this function when webviews refresh is needed (all TBLClassicUnits included in the controller will be refreshed)
*/
- (void)refresh;

/*!
 @discussion Resets all TBLClassicUnits included in the controller. New commands must be pushed before fetching data again.
*/
- (void)reset;

@end

NS_ASSUME_NONNULL_END
