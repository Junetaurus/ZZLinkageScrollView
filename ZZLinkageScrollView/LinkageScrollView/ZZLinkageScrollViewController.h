//
//  ZZLinkageScrollViewController.h
//  ZZLinkageScrollView
//
//  Created by Zhang on 2018/1/26.
//  Copyright © 2018年 Zhang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZZLinkageScrollTableView;

@interface ZZLinkageScrollViewController : UIViewController

/** 网络图片 url string 数组 */
@property (nonatomic, strong) NSArray *imageURLStringsGroup;

/** 每张图片对应要显示的文字数组 */
@property (nonatomic, strong) NSArray *titlesGroup;

/** 本地图片数组 */
@property (nonatomic, strong) NSArray *localizationImageNamesGroup;

/** 滑动文字数组 */
@property (nonatomic, strong) NSArray <NSString *> *titleArray;

@property (nonatomic, strong) ZZLinkageScrollTableView *currentTableView;

@end
