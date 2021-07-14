//
//  TBLNativeUnit.h
//  TaboolaView
//
//  Created by Tzufit Lifshitz on 8/12/19.
//  Copyright © 2019 Taboola. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TBLRecommendationResponse.h"

typedef void(^TBRequestSuccessCallback)(TBLRecommendationResponse * _Nullable response);
typedef void(^TBRequestFailureCallback)(NSError * _Nullable error);

NS_ASSUME_NONNULL_BEGIN

@interface TBLNativeUnit: NSObject

/*! @brief number of items to load on nextBatch */
@property (nonatomic) NSInteger numberOfItems;

/*! @brief sets the width and the height of thumbnail view */
@property (nonatomic) CGSize thumbnailSize;

/*! @brief name given to the unit */
@property (nonatomic, readonly) NSString *placementId;

/*!
 @discussion Init function for the TBLNativeUnit
 
 @param placement The current placement's name
 @param numberOfItems number of items to fetch

 @return TBLNativeUnit object
*/
- (instancetype)initWithPlacement:(NSString*)placement numberOfItems:(int)numberOfItems;

/*!
 @discussion Call this function to fetch content with completion blocks
 
 @param onSuccess success completion block
 @param onFailure failure completion block
*/
- (void)fetchContentOnSuccess:(TBRequestSuccessCallback)onSuccess
                    onFailure:(TBRequestFailureCallback)onFailure;

/*!
 @discussion Called in order to clean the datasource
*/
-(void)clear;


/*!
 @discussion use to report to SDK on scroll and send visible event
*/
- (void)checkIfVisibleFromScroll:(UIScrollView*)scrollView;

@end

NS_ASSUME_NONNULL_END
