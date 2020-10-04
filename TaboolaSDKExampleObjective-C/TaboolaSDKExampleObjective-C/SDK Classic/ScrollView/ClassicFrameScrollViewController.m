//
//  ClassicScrollViewController.m
//  TaboolaSDKExampleObjective-C
//
//  Created by Liad Elidan on 02/06/2020.
//  Copyright © 2020 Liad Elidan. All rights reserved.
//

#import "ClassicFrameScrollViewController.h"
#import <TaboolaSDK/TaboolaSDK.h>
#import "RandomColor.h"

@interface ClassicFrameScrollViewController () <TBLClassicPageDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (nonatomic, strong) UILabel *topText;
@property (nonatomic, strong) UILabel* midText;

// TBLClassicPage holds Taboola Widgets/Feed for a specific view
@property (nonatomic, strong) TBLClassicPage* classicPage;
// TBLClassicUnit object represnting Widget/Feed
@property (nonatomic, strong) TBLClassicUnit* taboolaWidgetPlacement;
@property (nonatomic, strong) TBLClassicUnit* taboolaFeedPlacement;

@end

@implementation ClassicFrameScrollViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.frame = [UIScreen mainScreen].bounds;
    
    _topText = [[UILabel alloc] initWithFrame:self.view.bounds];
    [_scrollView addSubview:_topText];
    _topText.text = textToAdd;

    _topText.numberOfLines=0;
    _topText.lineBreakMode=NSLineBreakByWordWrapping;
    
    [_topText sizeToFit];
    
    [self taboolaInit];
}

-(void)taboolaInit {
    _classicPage = [[TBLClassicPage alloc]initWithPageType:@"article" pageUrl:@"http://www.example.com" delegate:self scrollView:_scrollView];
    
    _taboolaFeedPlacement = [_classicPage createUnitWithPlacementName:@"Feed without video" mode:@"thumbs-feed-01 video" placementType:PlacementTypeFeed];
    [_taboolaFeedPlacement setFrame:CGRectMake(0, _topText.frame.size.height, self.view.frame.size.width, 200)];
    [_scrollView addSubview:_taboolaFeedPlacement];

    _scrollView.contentSize = CGSizeMake(self.view.frame.size.width, _taboolaFeedPlacement.placementHeight + _topText.frame.size.height);
    [self.view addSubview:_scrollView];
    
    [_taboolaFeedPlacement fetchContent];
}

- (void)dealloc {
    NSLog(@"Dealloc");
    [_taboolaFeedPlacement reset];
}

#pragma mark - TBLClassicPageDelegate

- (void)taboolaView:(UIView *)taboolaView didLoadOrChangeHeightOfPlacementNamed:(NSString *)placementName withHeight:(CGFloat)height {
    NSLog(@"%@", placementName);

    _scrollView.contentSize = CGSizeMake(self.view.frame.size.width, _taboolaFeedPlacement.placementHeight + _topText.frame.size.height);
    [_taboolaFeedPlacement setFrame:CGRectMake(0, _topText.frame.size.height, self.view.frame.size.width, _taboolaFeedPlacement.placementHeight)];
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
