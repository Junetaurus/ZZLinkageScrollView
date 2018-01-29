//
//  ViewController.m
//  ZZLinkageScrollView
//
//  Created by Zhang on 2018/1/26.
//  Copyright © 2018年 Zhang. All rights reserved.
//

#import "ViewController.h"
#import "CustomCell.h"

@interface ViewController ()

@property (nonatomic, strong) NSMutableArray *cellDataImageArray;

@end

static NSString *cellID = @"cell";

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.titleArray = @[@"推荐",@"原创",@"热门",@"美食",@"生活",@"设计感",@"家居",@"礼物",@"阅读",@"运动健身",@"旅行户外"];
    
    NSMutableArray *imageArray = [NSMutableArray arrayWithCapacity:8];
    for (NSInteger i = 1; i < 9; i++) {
        UIImage *image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"cycle_0%ld",i] ofType:@"jpg"]];
        [imageArray addObject:image];
    }
    self.localizationImageNamesGroup = [imageArray copy];
    
    [self registerClass:[CustomCell class] forCellReuseIdentifier:cellID];
    // Do any additional setup after loading the view, typically from a nib.
}

- (NSMutableArray *)cellDataImageArray {
    if (!_cellDataImageArray) {
        _cellDataImageArray = [NSMutableArray array];
        for (NSInteger i = 1; i < 10; i++) {
            UIImage *image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"recomand_%02ld",i] ofType:@"jpg"]];
            [_cellDataImageArray
             addObject:image];
        }
    }
    return _cellDataImageArray;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 8;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CustomCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    cell.customImageView.image = self.cellDataImageArray[arc4random() % self.cellDataImageArray.count];
    cell.customLabel.text = [NSString stringWithFormat:@"XXXXX%ldXXXXX",indexPath.item];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [CustomCell customCellHeight];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
