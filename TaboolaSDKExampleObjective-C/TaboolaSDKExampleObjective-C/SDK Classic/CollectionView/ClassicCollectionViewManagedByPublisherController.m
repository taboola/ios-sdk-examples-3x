//
//  ClassicCollectionViewManagedByPublisherController.m
//  TaboolaSDKExampleObjective-C
//
//  Created by Liad Elidan on 17/05/2020.
//  Copyright © 2020 Liad Elidan. All rights reserved.
//

#import "ClassicCollectionViewManagedByPublisherController.h"
#import <TaboolaSDK/TaboolaSDK.h>
#import "RandomColor.h"

@interface ClassicCollectionViewManagedByPublisherController () <TBLClassicPageDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

// TBLClassicPage holds Taboola Widgets/Feed for a specific view
@property (nonatomic, strong) TBLClassicPage* classicPage;
// TBLClassicUnit object represnting Widget/Feed
@property (nonatomic, strong) TBLClassicUnit* taboolaWidgetPlacement;
@property (nonatomic, strong) TBLClassicUnit* taboolaFeedPlacement;

@end

@implementation ClassicCollectionViewManagedByPublisherController

#pragma mark - ViewController lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
     [self taboolaInit];
}

-(void)taboolaInit {
    _classicPage = [[TBLClassicPage alloc]initWithPageType:@"article" pageUrl:@"http://www.example.com" delegate:self scrollView:_collectionView];
    
    _taboolaWidgetPlacement = [_classicPage createUnitWithPlacementName:@"Below Article" mode:@"alternating-widget-without-video-1x4" placementType:PlacementTypeWidget];
     [_taboolaWidgetPlacement fetchContent];
    
    _taboolaFeedPlacement = [_classicPage createUnitWithPlacementName:@"Feed without video" mode:@"thumbs-feed-01" placementType:PlacementTypeFeed];
    [_taboolaFeedPlacement fetchContent];
}


#pragma mark - UICollectionViewDatasource
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == taboolaWidgetSection){
        UICollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"TaboolaCollectionViewCell" forIndexPath:indexPath];
        [self clearTaboolaInReusedCell:cell];
        [cell.contentView addSubview:_taboolaWidgetPlacement];
        return cell;
    } else if (indexPath.section == taboolaFeedSection){
        UICollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"TaboolaCollectionViewCell" forIndexPath:indexPath];
        [self clearTaboolaInReusedCell:cell];
        [cell.contentView addSubview:_taboolaFeedPlacement];
        return cell;
    } else {
        UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"RandomCell" forIndexPath:indexPath];
        cell.contentView.backgroundColor = [RandomColor setRandomColor];
        return cell;
    }
    
}

-(void)clearTaboolaInReusedCell:(UICollectionViewCell*)cell {
    for (UIView *view in [cell.contentView subviews]) {
        [view removeFromSuperview];
    }
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return totalSections;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 1;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == taboolaWidgetSection) {
        return CGSizeMake(self.view.frame.size.width, _taboolaWidgetPlacement.placementHeight);
    }
    else if (indexPath.section == taboolaFeedSection) {
        return CGSizeMake(self.view.frame.size.width, _taboolaFeedPlacement.placementHeight);
    }
    return CGSizeMake(self.view.frame.size.width, 200);
}

-(void)dealloc {
    [_taboolaWidgetPlacement reset];
    [_taboolaFeedPlacement reset];
}

#pragma mark - TBLClassicPageDelegate

-(void)taboolaView:(UIView *)taboolaView didLoadOrChangeHeightOfPlacementNamed:(NSString *)placementName withHeight:(CGFloat)height {
    NSLog(@"%@", placementName);
    
    if ([placementName containsString:widgetPlacement]) {
        [_taboolaWidgetPlacement setFrame:CGRectMake(0, 0, self.view.frame.size.width, _taboolaWidgetPlacement.placementHeight)];
    } else {
        [_taboolaFeedPlacement setFrame:CGRectMake(_taboolaFeedPlacement.frame.origin.x, _taboolaFeedPlacement.frame.origin.y, self.view.frame.size.width, _taboolaFeedPlacement.placementHeight)];
    }
    [self.collectionView.collectionViewLayout invalidateLayout];
}

- (void)taboolaView:(UIView *)taboolaView didFailToLoadPlacementNamed:(NSString *)placementName withErrorMessage:(NSString *)error {
    NSLog(@"%@", error);
}

- (BOOL)onItemClick:(NSString *)placementName withItemId:(NSString *)itemId withClickUrl:(NSString *)clickUrl isOrganic:(BOOL)organic {
    if (!organic) {
        return NO;
    }
    return YES;
}

@end
