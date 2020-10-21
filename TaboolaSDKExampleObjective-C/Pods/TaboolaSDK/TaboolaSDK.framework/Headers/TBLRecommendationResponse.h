//
//  TBLRecommendationResponse.h
//  TaboolaView
//
//  Copyright © 2017 Taboola. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TBLNativeItem.h"


@interface TBLRecommendationResponse : NSObject

@property (nonatomic, strong) NSMutableArray<TBLNativeItem*> *items;



@end
