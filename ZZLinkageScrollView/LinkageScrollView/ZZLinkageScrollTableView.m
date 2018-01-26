//
//  ZZLinkageScrollTableView.m
//  ZZLinkageScrollView
//
//  Created by Zhang on 2018/1/26.
//  Copyright © 2018年 Zhang. All rights reserved.
//

#import "ZZLinkageScrollTableView.h"
#import "ZZLinkageScrollHeaderView.h"

@implementation ZZLinkageScrollTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, [ZZLinkageScrollHeaderView linkageScrollHeaderViewHeight])];
    }
    return self;
}

@end
