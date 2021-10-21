//
//  TBLNativeItem.h
//  TaboolaView
//
//  Copyright © 2017 Taboola. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TBLImageView.h"
#import "TBLTitleLabel.h"
#import "TBLBrandingLabel.h"
#import "TBLDescriptionLabel.h"

@interface TBLNativeItem : NSObject

//create UIViews manually
- (TBLImageView *)thumbnailView;
- (TBLImageView *)thumbnailViewCompleted:(void (^)(NSError *, UIImage *))completed;
- (TBLTitleLabel *)titleView;
- (TBLBrandingLabel *)brandingView;
- (TBLDescriptionLabel *)descriptionView;
- (NSDictionary *)extraDataDictionary;


//create UIViews from storyboard
- (void)initTitleView:(TBLTitleLabel *)titleLabel;
- (void)initBrandingView:(TBLBrandingLabel *)brandingLabel;
- (void)initDescriptionView:(TBLDescriptionLabel *)descriptionLabel;
- (void)initThumbnailView:(TBLImageView *)imageView;
- (void)initThumbnailView:(TBLImageView *)imageView completed:(void (^)(NSError *, UIImage *))completed;

- (void)notifyVisibleEvent;
- (void)handleClickEvent;
@end
