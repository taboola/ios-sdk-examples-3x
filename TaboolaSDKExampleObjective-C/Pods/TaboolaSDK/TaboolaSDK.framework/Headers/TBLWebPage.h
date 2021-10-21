//
//  TBLWebUnit.h
//  TaboolaSDK
//
//  Created by Tzufit Lifshitz on 3/11/20.
//

#import <Foundation/Foundation.h>
#import "TBLWebUnit.h"
#import "TBLPage.h"
NS_ASSUME_NONNULL_BEGIN

@interface TBLWebPage : TBLPage

/*! @brief Optional. pageExtraProperties is a dictionary contains relevant property keys and data values. */
@property (nonatomic, strong) NSDictionary *pageExtraProperties;

- (instancetype)initWithDelegate:(id<TBLWebPageDelegate>)delegate;

- (TBLWebUnit*)createUnitWithWebView:(WKWebView *)webView;

- (void)fetchAllUnitsContent;

@property (nonatomic) TBLFetchingPolicy fetchingPolicy;

@end

NS_ASSUME_NONNULL_END
