//
//  ZZLinkageScrollHeaderView.m
//  ZZLinkageScrollView
//
//  Created by Zhang on 2018/1/26.
//  Copyright © 2018年 Zhang. All rights reserved.
//

#import "ZZLinkageScrollHeaderView.h"
#import "UIView+SDExtension.h"

@interface ZZLinkageScrollHeaderView () <SDCycleScrollViewDelegate, UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *titleScrollView;
@property (nonatomic, strong) UIButton *lastSelectedBtn;
@property (nonatomic, strong) UIView *line;

@property (nonatomic, strong) NSMutableArray <UIButton *> *titleBtnArray;

@end

static inline CGFloat cycleScrollViewHeight() {
    return [UIScreen mainScreen].bounds.size.width * (330.0/600.0);
}

typedef enum : NSUInteger {
    ButtonNormal,
    ButtonSelected
} ButtonState;

static inline UIColor * btnTitleColor(ButtonState state) {
    if (state == ButtonNormal) {
        return [UIColor colorWithRed:51.0/255.0f green:51.0/255.0f blue:51.0/255.0f alpha:1.0];
    }
    return [UIColor colorWithRed:236.0f/255.0f green:74.0f/255.0f blue:68.0f/255.0f alpha:1.0];
}

static inline UIFont * btnTitleFontSize(ButtonState state) {
    if (state == ButtonNormal) {
        return [UIFont systemFontOfSize:14.0];
    }
    return [UIFont systemFontOfSize:15.0];
}

static CGFloat titleScrollViewHeight = 40.0f;
static CGFloat lineHeight = 1;
static CGFloat lineAnimationTime = 0.3;
static NSInteger basisBtnTag = 50;
static CGFloat btnSpacing = 20.0;

@implementation ZZLinkageScrollHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        //
        [self addSubview:self.cycleScrollView];
        //
        [self addSubview:self.titleScrollView];
        //
        [self.titleScrollView addSubview:self.line];
    }
    return self;
}

- (SDCycleScrollView *)cycleScrollView {
    if (!_cycleScrollView) {
        _cycleScrollView = [[SDCycleScrollView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, cycleScrollViewHeight())];
        _cycleScrollView.placeholderImage = [UIImage imageNamed:@""];
        _cycleScrollView.delegate = self;
    }
    return _cycleScrollView;
}

- (UIScrollView *)titleScrollView {
    if (!_titleScrollView) {
        _titleScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, cycleScrollViewHeight(), self.bounds.size.width, titleScrollViewHeight)];
        _titleScrollView.showsVerticalScrollIndicator = NO;
        _titleScrollView.showsHorizontalScrollIndicator = NO;
        _titleScrollView.delegate = self;
    }
    return _titleScrollView;
}

- (UIView *)line {
    if (!_line) {
        _line = [[UIView alloc] initWithFrame:CGRectMake(btnSpacing/2, titleScrollViewHeight - lineHeight, 0, lineHeight)];
        _line.backgroundColor = btnTitleColor(ButtonSelected);
        [self.titleScrollView addSubview:_line];
    }
    return _line;
}

- (NSMutableArray *)titleBtnArray {
    if (!_titleBtnArray) {
        _titleBtnArray = [NSMutableArray arrayWithCapacity:0];
    }
    return _titleBtnArray;
}

- (void)setTitleArray:(NSArray<NSString *> *)titleArray {
    _titleArray = titleArray;
    //
    if (_titleArray) {
        [self.titleBtnArray removeAllObjects];
        __weak ZZLinkageScrollHeaderView *this = self;
        __block CGFloat btnTotalWidth = 0;
        [_titleArray enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            UIButton *btn = [this createBtnWithTag:idx + basisBtnTag];
            [btn setTitle:obj forState:UIControlStateNormal];
            CGSize btnSize = [btn sizeThatFits:CGSizeMake(CGFLOAT_MAX, titleScrollViewHeight - lineHeight)];
            btnTotalWidth += btnSize.width + btnSpacing;
            if (idx == _titleArray.count - 1) this.titleScrollView.contentSize = CGSizeMake(btnTotalWidth, 0);
            [this.titleScrollView addSubview:btn];
            [this.titleBtnArray addObject:btn];
        }];
        
        __block UIButton *lastBtn = nil;
        [_titleBtnArray enumerateObjectsUsingBlock:^(UIButton * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            CGSize btnSize = [obj sizeThatFits:CGSizeMake(CGFLOAT_MAX, titleScrollViewHeight - lineHeight)];
            if (btnTotalWidth > _titleScrollView.sd_width) {
                if (idx == 0) {
                    obj.frame = CGRectMake(0, 0, btnSize.width + btnSpacing, titleScrollViewHeight - lineHeight);
                    obj.selected = YES;
                    this.lastSelectedBtn = obj;
                    this.line.sd_width = btnSize.width;
                } else {
                    obj.frame = CGRectMake(lastBtn.sd_x + lastBtn.sd_width, 0, btnSize.width + btnSpacing, titleScrollViewHeight - lineHeight);
                }
            } else {
                if (idx == 0) {
                    obj.frame = CGRectMake(0, 0, _titleScrollView.sd_width/_titleArray.count, btnSize.height);
                    obj.selected = YES;
                    this.lastSelectedBtn = obj;
                    this.line.sd_width = btnSize.width;
                } else {
                    obj.frame = CGRectMake(lastBtn.sd_x + lastBtn.sd_width, 0, _titleScrollView.sd_width/_titleArray.count, btnSize.height);
                }
            }
            lastBtn = obj;
        }];
    }
}

- (UIButton *)createBtnWithTag:(NSInteger)tag {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.tag = tag;
    btn.titleLabel.font = btnTitleFontSize(ButtonNormal);
    [btn setTitleColor:btnTitleColor(ButtonNormal) forState:UIControlStateNormal];
    [btn setTitleColor:btnTitleColor(ButtonNormal) forState:UIControlStateHighlighted];
    [btn setTitleColor:btnTitleColor(ButtonSelected) forState:UIControlStateSelected];
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    return btn;
}

- (void)btnClick:(UIButton *)btn {
    [self changeBtnState:btn];
}

- (void)changeBtnState:(UIButton *)btn {
    if (_lastSelectedBtn == btn) return;
    
    if (_lastSelectedBtn) {
        _lastSelectedBtn.selected = NO;
        _lastSelectedBtn.titleLabel.font = btnTitleFontSize(ButtonNormal);
    }
    
    btn.selected = YES;
    btn.titleLabel.font = btnTitleFontSize(ButtonSelected);
    
    _lastSelectedBtn = btn;
    
    [UIView animateWithDuration:lineAnimationTime animations:^{
        _line.sd_x = btn.sd_x + btnSpacing/2;
        _line.sd_width = btn.sd_width - btnSpacing;
    }];
    //
    if (_titleScrollView.contentSize.width > _titleScrollView.sd_width) {
        CGFloat needOffsetX = btn.sd_x - .5 * _titleScrollView.sd_width + .5 * btn.sd_width;
        if (needOffsetX < 0 ) needOffsetX = 0;
        if (needOffsetX > _titleScrollView.contentSize.width - _titleScrollView.sd_width) {
            needOffsetX = _titleScrollView.contentSize.width - _titleScrollView.sd_width;
        }
        [_titleScrollView setContentOffset:CGPointMake(needOffsetX, 0) animated:YES];
    }
    //
    if (_delegate && [_delegate respondsToSelector:@selector(titleScrollView:didSelectItemAtIndex:)]) {
        [_delegate titleScrollView:_titleScrollView didSelectItemAtIndex:btn.tag - basisBtnTag];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
}

/** 点击图片回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
    if (_delegate && [_delegate respondsToSelector:@selector(cycleScrollView:didSelectItemAtIndex:)]) {
        [_delegate cycleScrollView:cycleScrollView didSelectItemAtIndex:index];
    }
}

/** 图片滚动回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didScrollToIndex:(NSInteger)index {
    if (_delegate && [_delegate respondsToSelector:@selector(cycleScrollView:didScrollToIndex:)]) {
        [_delegate cycleScrollView:cycleScrollView didScrollToIndex:index];
    }
}

- (void)linkageScrollTableViewScrollToIndex:(NSInteger)index {
    if (index >= self.titleBtnArray.count) return;
    [self changeBtnState:_titleBtnArray[index]];
}

+ (CGFloat)linkageScrollHeaderViewHeight {
    return cycleScrollViewHeight() + titleScrollViewHeight;
}

@end
