//
//  CustomCell.m
//  ZZLinkageScrollView
//
//  Created by Zhang on 2018/1/29.
//  Copyright © 2018年 Zhang. All rights reserved.
//

#import "CustomCell.h"

@implementation CustomCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        //
        _customImageView = [[UIImageView alloc] init];
        [self.contentView addSubview:_customImageView];
        //
        _customLabel = [[UILabel alloc] init];
        _customLabel.text = @"";
        _customLabel.font = [UIFont systemFontOfSize:14];
        _customLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
        _customLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_customLabel];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    //
    CGFloat hw = 330.0 / 600.0;
    _customImageView.frame = CGRectMake(25, 10, self.bounds.size.width - 50, hw * (self.bounds.size.width - 50));
    //
    _customLabel.frame = CGRectMake(0, 10 + _customImageView.bounds.size.height, self.bounds.size.width, [[self class] customCellHeight] - _customImageView.bounds.size.height - 10);
}

+ (CGFloat)customCellHeight {
    return 240;
}

@end
