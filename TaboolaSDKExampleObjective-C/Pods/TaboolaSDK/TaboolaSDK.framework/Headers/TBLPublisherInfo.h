//
//  TBLPublisherInfo.h
//  TaboolaView
//
//  Created by Karen Shaham Palman on 08/07/2019.
//  Copyright © 2019 Taboola. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TBLPublisherInfo : NSObject

@property(nonatomic, strong) NSString *publisherName;
@property(nonatomic, strong) NSString *apiKey;

-(instancetype)initWithPublisherName:(NSString*)publisherName;

@end

NS_ASSUME_NONNULL_END
