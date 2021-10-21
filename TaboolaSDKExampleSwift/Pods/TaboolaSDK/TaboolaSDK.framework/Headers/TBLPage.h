//
//  TBLPage.h
//  TaboolaSDK
//
//  Created by Tzufit Lifshitz on 3/12/20.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSInteger, TBLFetchingPolicy) {
    FetchingPolicySerial = 0,
    FetchingPolicyParallel
};

@interface TBLPage : NSObject

@end

NS_ASSUME_NONNULL_END
