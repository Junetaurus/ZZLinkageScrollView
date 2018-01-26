//
//  ZZLinkageScrollViewController.m
//  ZZLinkageScrollView
//
//  Created by Zhang on 2018/1/26.
//  Copyright © 2018年 Zhang. All rights reserved.
//

#import "ZZLinkageScrollViewController.h"
#import "ZZLinkageScrollHeaderView.h"
#import "ZZLinkageScrollTableView.h"

@interface ZZLinkageScrollViewController () <ZZLinkageScrollHeaderViewDelegate, UIScrollViewDelegate>

@property (nonatomic, strong) ZZLinkageScrollHeaderView *scrollHeaderView;
@property (nonatomic, strong) UIScrollView *mainScrollView;

@property (nonatomic, strong) NSMutableArray <ZZLinkageScrollTableView *> *tableViewArray;

@end

@implementation ZZLinkageScrollViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //
    [self.view addSubview:self.mainScrollView];
    //
    [self.view addSubview:self.scrollHeaderView];
    // Do any additional setup after loading the view.
}

- (NSMutableArray *)tableViewArray {
    if (!_tableViewArray) {
        _tableViewArray = [NSMutableArray arrayWithCapacity:0];
    }
    return _tableViewArray;
}

- (ZZLinkageScrollHeaderView *)scrollHeaderView {
    if (!_scrollHeaderView) {
        _scrollHeaderView = [[ZZLinkageScrollHeaderView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, [ZZLinkageScrollHeaderView linkageScrollHeaderViewHeight])];
        _scrollHeaderView.delegate = self;
    }
    return _scrollHeaderView;
}

- (UIScrollView *)mainScrollView {
    if (!_mainScrollView) {
        _mainScrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
        _mainScrollView.backgroundColor = [UIColor whiteColor];
        _mainScrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _mainScrollView.showsVerticalScrollIndicator = NO;
        _mainScrollView.showsHorizontalScrollIndicator = NO;
        _mainScrollView.pagingEnabled = YES;
        _mainScrollView.delegate = self;
    }
    return _mainScrollView;
}

- (void)setImageURLStringsGroup:(NSArray *)imageURLStringsGroup {
    _imageURLStringsGroup = imageURLStringsGroup;
    //
    self.scrollHeaderView.cycleScrollView.imageURLStringsGroup = imageURLStringsGroup;
}

- (void)setTitlesGroup:(NSArray *)titlesGroup {
    _titlesGroup = titlesGroup;
    //
    self.scrollHeaderView.cycleScrollView.titlesGroup = _titlesGroup;
}

- (void)setLocalizationImageNamesGroup:(NSArray *)localizationImageNamesGroup {
    _localizationImageNamesGroup = localizationImageNamesGroup;
    //
    self.scrollHeaderView.cycleScrollView.localizationImageNamesGroup = _localizationImageNamesGroup;
}

- (void)setTitleArray:(NSArray<NSString *> *)titleArray {
    _titleArray = titleArray;
    //
    self.scrollHeaderView.titleArray = _titleArray;
    //
    if (_titleArray) {
        [self.tableViewArray removeAllObjects];
        __weak ZZLinkageScrollViewController *this = self;
        [_titleArray enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            CGFloat tableViewWidth = this.mainScrollView.bounds.size.width;
            CGFloat tableViewHeight = this.mainScrollView.bounds.size.height;
            ZZLinkageScrollTableView *tableView = [[ZZLinkageScrollTableView alloc] initWithFrame:CGRectMake(tableViewWidth * idx, 0, tableViewWidth, tableViewHeight) style:UITableViewStylePlain];
            tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
            [this.mainScrollView addSubview:tableView];
            [this.tableViewArray addObject:tableView];
            if (idx == _titleArray.count - 1) this.mainScrollView.contentSize = CGSizeMake(tableViewWidth * _titleArray.count, tableViewHeight);
        }];
    }
}

#pragma mark - ZZLinkageScrollHeaderViewDelegate
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
    
}

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didScrollToIndex:(NSInteger)index {
    
}

- (void)titleScrollView:(UIScrollView *)titleScrollView didSelectItemAtIndex:(NSInteger)index {
    [self.mainScrollView setContentOffset:CGPointMake(index * _mainScrollView.bounds.size.width, 0) animated:YES];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (scrollView == _mainScrollView) {
        NSInteger index = scrollView.contentOffset.x / scrollView.bounds.size.width + 0.5;
        [self.scrollHeaderView linkageScrollTableViewScrollToIndex:index];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
