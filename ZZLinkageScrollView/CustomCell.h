//
//  CustomCell.h
//  ZZLinkageScrollView
//
//  Created by Zhang on 2018/1/29.
//  Copyright © 2018年 Zhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomCell : UITableViewCell

@property (nonatomic, strong) UIImageView *customImageView;
@property (nonatomic, strong) UILabel *customLabel;

+ (CGFloat)customCellHeight;

@end
