//
//  ZZLinkageScrollHeaderView.h
//  ZZLinkageScrollView
//
//  Created by Zhang on 2018/1/26.
//  Copyright © 2018年 Zhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SDCycleScrollView.h"

@protocol ZZLinkageScrollHeaderViewDelegate <NSObject>

@optional

/** 点击图片回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index;

/** 图片滚动回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didScrollToIndex:(NSInteger)index;

/** 点击滑动文字回调 */
- (void)titleScrollView:(UIScrollView *)titleScrollView didSelectItemAtIndex:(NSInteger)index;

@end

@interface ZZLinkageScrollHeaderView : UIView

@property (nonatomic, weak) id <ZZLinkageScrollHeaderViewDelegate> delegate;

@property (nonatomic, strong) SDCycleScrollView *cycleScrollView;
@property (nonatomic, strong) NSArray <NSString *> *titleArray;

- (void)linkageScrollTableViewScrollToIndex:(NSInteger)index;

+ (CGFloat)linkageScrollHeaderViewHeight;

@end
