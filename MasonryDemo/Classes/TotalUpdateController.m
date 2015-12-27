//
//  TotalUpdateConrtoller.m
//  MasonryDemo
//
//  Created by 闲人 on 15/12/26.
//  Copyright © 2015年 闲人. All rights reserved.
//

#import "TotalUpdateController.h"
#import "Masonry.h"
// 此例子代码重复了好多，想想看能不能优化，线这样吧
@interface TotalUpdateController ()

@property (nonatomic, weak) UIView *purpleView;
@property (nonatomic, weak) UIView *orangeView;
@property (nonatomic, weak) UILabel *label;
@property (nonatomic, assign) BOOL isExpaned;


@end

@implementation TotalUpdateController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout = NO;
    
    UIView *purpleView = [[UIView alloc] init];
    self.purpleView = purpleView;
    purpleView.backgroundColor = UIColor.purpleColor;
    purpleView.layer.borderColor = UIColor.blackColor.CGColor;
    purpleView.layer.borderWidth = 2;
    [self.view addSubview:purpleView];
    
    UIView *orangeView = UIView.new;
    orangeView.backgroundColor = UIColor.orangeColor;
    orangeView.layer.borderColor = UIColor.blackColor.CGColor;
    orangeView.layer.borderWidth = 2;
    [self.view addSubview:orangeView];
    self.orangeView = orangeView;
    
    UILabel *label = [[UILabel alloc] init];
    self.label = label;
    label.numberOfLines = 0;
    label.textColor = [UIColor redColor];
    label.font = [UIFont systemFontOfSize:16];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"点击purple部分放大，orange部分最大值250，最小值90";
    [self.purpleView addSubview:label];
    
    // 约束
    [self.purpleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(20);
        make.right.mas_equalTo(-20);
        make.bottom.mas_equalTo(-300).priorityLow();
    }];
    
    [self.orangeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.purpleView);
        make.width.height.lessThanOrEqualTo(@250);
        make.width.height.greaterThanOrEqualTo(@90);
    }];
    
    [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(0);
        make.left.right.mas_equalTo(0);
    }];
    
    // 添加点击事件
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(purpleViewTap)];
    [self.purpleView addGestureRecognizer:tap];
    self.isExpaned = NO;
}

- (void)purpleViewTap {
    self.isExpaned = !self.isExpaned;
     [self.view setNeedsUpdateConstraints];
    
//    [self.view updateConstraintsIfNeeded];
//    NSLog(@"%s", __func__);
    [UIView animateWithDuration:0.3 animations:^{
        [self.view layoutIfNeeded];
    }];
}

#pragma mark - **************** updateViewConstraints
// 苹果推荐在uodateVViewConstraints 中更新或者添加约束
- (void)updateViewConstraints {
    if (self.isExpaned) {
        [self.purpleView mas_updateConstraints:^(MASConstraintMaker *make) {
           make.bottom.mas_equalTo(-10).priorityLow();
        }];
    } else {
        [self.purpleView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(-300).priorityLow();
        }];
    }
    
    [self.orangeView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self.purpleView);
        // 这里使用优先级处理
        // 设置其最大值为250，最小值为90
        if (!self.isExpaned) {
            make.width.height.mas_equalTo(100 * 0.5).priorityLow();
        } else {
            make.width.height.mas_equalTo(100 * 3).priorityLow();
        }
    }];

    
    [super updateViewConstraints];
}
@end
