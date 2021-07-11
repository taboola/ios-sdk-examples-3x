//
//  TaboolaJSUnit.h
//  TaboolaView
//
//  Created by Karen Shaham Palman on 18/08/2019.
//  Copyright © 2019 Taboola. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TBLWebPageDelegate.h"
#import <WebKit/WebKit.h>

NS_ASSUME_NONNULL_BEGIN

/*!
TBLWebUnit is the first object to initialize, and is being used to fetch TaboolaView's content (widget or Feed)
*/
@interface TBLWebUnit : NSObject

/*!
 @discussion After initializing TBLWebUnit, this method should be called to actually fetch the recommendations
*/
- (void)fetchContent;

@end

NS_ASSUME_NONNULL_END
