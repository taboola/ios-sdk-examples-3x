//
//  TBLStoriesUnit.h
//  TaboolaSDK
//
//  Created by Tzufit Lifshitz on 20/05/2021.
//

#import "TBLClassicUnit.h"
#import "TBLStoriesCollectionView.h"

NS_ASSUME_NONNULL_BEGIN

// Possible error names
static NSString* const STORIES_VIEW_FAILED_LOADING = @"STORIES_VIEW_FAILED_LOADING";
static NSString* const FULL_SCREEN_FAILED_LOADING = @"FULL_SCREEN_FAILED_LOADING";
static NSString* const CLASSIC_UNIT_ERROR = @"CLASSIC_UNIT_ERROR";

@protocol TBLStoriesUnitDelegate <NSObject>

@optional

/*!
@discussion Triggered when the storiesUnit did load
*/
- (void)storiesViewDidLoad;

/*!
@discussion Triggered when the VerticalUI opens
*/
- (void)storiesFullScreenDidOpen;

/*!
@discussion Triggered when the VerticalUI closes and moving back to the UIViewController
*/
- (void)storiesFullScreenDidClose;

/*!
@discussion Triggered when an error occurred. Possible errors from the NSStrings at the top.
*/
- (void)storiesDidFailWithError:(NSString *)error;

@end


@interface TBLStoriesUnit : NSObject

/*! @brief Use this property and add it to your UIViewController in order to see the stories carousel */
@property (nonatomic, strong) TBLStoriesCollectionView *storiesCollectionView;

/*!
 @brief After initializing TBLStoriesUnit, this method should be called to actually fetch the Stories' content.
*/
- (void)fetchContent;

@end

NS_ASSUME_NONNULL_END
