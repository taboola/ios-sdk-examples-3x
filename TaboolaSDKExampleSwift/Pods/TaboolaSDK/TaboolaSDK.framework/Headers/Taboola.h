//
//  Taboola.h
//  TaboolaView
//
//  Created by Tzufit Lifshitz on 3/5/19.
//  Copyright © 2019 Taboola. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TBLPublisherInfo.h"
#import "TBLEvent.h"
#import "TBLLoggerLevel.h"

NS_ASSUME_NONNULL_BEGIN

@interface Taboola : NSObject

+(void)initWithPublisherInfo:(TBLPublisherInfo*)publisherInfo;

/**************
 * Event Handler *
 **************/

/** Sends events to server.
 * @param events - like MobileEvent.
 **/
+(void)reportTBLMobileEvent:(NSDictionary *)events eventType:(TaboolaEventType)eventType;

+(void)setGlobalExtraProperties:(NSDictionary*)extraProperties;

+(void)setLogLevel:(LogLevel)logLevel;

+(TBLPublisherInfo *)getPublisherInfo;

+(LogLevel)getLogLevel;

+ (NSString *)version;

@end

NS_ASSUME_NONNULL_END
