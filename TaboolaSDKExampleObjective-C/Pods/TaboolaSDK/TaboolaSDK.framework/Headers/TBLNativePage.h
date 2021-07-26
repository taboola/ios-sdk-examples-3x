//
//  TBLNativePage.h
//  TaboolaView
//
//  Created by Tzufit Lifshitz on 8/12/19.
//  Copyright © 2019 Taboola. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TBLNativeUnit.h"
#import "TBLPage.h"

NS_ASSUME_NONNULL_BEGIN

/*! @brief Describes the widget's type */
typedef enum {
    SourceTypeVideo,
    SourceTypeText,
    SourceTypePhoto,
    SourceTypeHome,
    SourceTypeSection,
    SourceTypeSearch
} SourceType;

@protocol TBLNativePageDelegate <NSObject>

/*!
@discussion When implemented, it allows the hosting app to decide what do do when intercepting clicks.

@param placementName The current placement (widget or feed)
@param itemId The placement's unique id
@param clickUrl A string representation of URL click
@param organic Determines whether the article is organic or sponsored

@return YES if the view should begin loading content; otherwise, NO.
*/
- (BOOL)onItemClick:(NSString *)placementName withItemId:(NSString *)itemId withClickUrl:(NSString *)clickUrl isOrganic:(BOOL)organic customData:(NSString *)customData;

@end

/*!
TBLNativePage is the first object to initialize, and is being used to fetch TaboolaView's content (widget or Feed)
*/
@interface TBLNativePage : TBLPage

/*! @brief The referrer (HTTP header) from the request that led to the current page. */
@property (nonatomic, strong) NSString *userReferrer;

/*! @brief Sets a unique id */
@property (nonatomic, strong) NSString *unifiedId;

/*! @brief Set according to your Taboola account manager (Usually will be "mix"). */
@property (nonatomic, strong) NSString *targetType;

/*!
@discussion Init function for the TBLClassicPage

@param delegate Sets the listener for Taboola calls
@param sourceType String describes the widget's type (e.g. SourceTypeVideo)
@param pageUrl String describes the website's URL

@return TBLNativePage object
*/
- (instancetype)initWithDelegate:(id<TBLNativePageDelegate>)delegate sourceType:(SourceType)sourceType pageUrl:(NSString *)pageUrl;

/*!
 @discussion A must function that creates TBLNativeUnit in order to build Taboola widgets
 
 @param placement The current placement's name
 @param numberOfItems number of items to fetch

 @return TBLNativeUnit object (Taboola widget / Feed)
*/
- (TBLNativeUnit*)createUnitWithPlacement:(NSString *)placement numberOfItems:(int)numberOfItems;

/*!
@discussion Call this function if you want to handle attribution click.
*/
- (void)handleAttributionClick;

@end

NS_ASSUME_NONNULL_END
