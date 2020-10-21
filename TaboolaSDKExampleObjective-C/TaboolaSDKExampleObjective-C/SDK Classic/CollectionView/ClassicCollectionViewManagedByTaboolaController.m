//
//  ClassicCollectionViewManagedByTaboolaController.m
//  TaboolaSDKExampleObjective-C
//
//  Created by Liad Elidan on 17/05/2020.
//  Copyright © 2020 Liad Elidan. All rights reserved.
//

#import "ClassicCollectionViewManagedByTaboolaController.h"
#import <TaboolaSDK/TaboolaSDK.h>
#import "RandomColor.h"

@interface ClassicCollectionViewManagedByTaboolaController () <TBLClassicPageDelegate>

#pragma mark - Properties

@property (weak, nonatomic) IBOutlet UICollectionView *collectionViewManagedByTaboola;

// TBLClassicPage holds Taboola Widgets/Feed for a specific view
@property (nonatomic, strong) TBLClassicPage *classicPage;
// TBLClassicUnit object represnting Widget/Feed
@property (nonatomic, strong) TBLClassicUnit *taboolaWidgetPlacement;
@property (nonatomic, strong) TBLClassicUnit *taboolaFeedPlacement;

@end

@implementation ClassicCollectionViewManagedByTaboolaController

#pragma mark - ViewController lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self taboolaInit];
}

-(void)taboolaInit {
    _classicPage = [[TBLClassicPage alloc]initWithPageType:@"article" pageUrl:@"http://www.example.com" delegate:self scrollView:_collectionViewManagedByTaboola];
    
    _taboolaWidgetPlacement = [_classicPage createUnitWithPlacementName:@"Below Article" mode:@"alternating-widget-without-video-1x4"];
     [_taboolaWidgetPlacement fetchContent];
    
    _taboolaFeedPlacement = [_classicPage createUnitWithPlacementName:@"Feed without video" mode:@"thumbs-feed-01"];
    [_taboolaFeedPlacement fetchContent];
}

#pragma mark - UICollectionViewDatasource

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == taboolaWidgetSection) {
        return [_taboolaWidgetPlacement collectionView:collectionView cellForItemAtIndexPath:indexPath withBackground:nil];
    }
    else if (indexPath.section == taboolaFeedSection) {
        return [_taboolaFeedPlacement collectionView:collectionView cellForItemAtIndexPath:indexPath withBackground:nil];
    }
    else {
        UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"RandomCell" forIndexPath:indexPath];
        cell.contentView.backgroundColor = [RandomColor setRandomColor];
        return cell;
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
        return [_taboolaWidgetPlacement collectionView:collectionView layout:collectionViewLayout sizeForItemAtIndexPath:indexPath withUIInsets:UIEdgeInsetsMake(10, 10, 10, 10)];
    } else if (indexPath.section == taboolaFeedSection) {
        return [_taboolaFeedPlacement collectionView:collectionView layout:collectionViewLayout sizeForItemAtIndexPath:indexPath withUIInsets:UIEdgeInsetsMake(10, 10, 10, 10)];
    }
    return CGSizeMake(self.view.frame.size.width, 200);
}

-(void)dealloc {
    [_taboolaWidgetPlacement reset];
    [_taboolaFeedPlacement reset];
}

#pragma mark - TBLClassicPageDelegate

- (void)taboolaView:(UIView *)taboolaView didLoadOrResizePlacement:(NSString *)placementName withHeight:(CGFloat)height placementType:(PlacementType)placementType{
    NSLog(@"%@", placementName);
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
