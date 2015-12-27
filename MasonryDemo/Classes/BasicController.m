//
//  BasicController.m
//  MasonryDemo
//
//  Created by 闲人 on 15/12/26.
//  Copyright © 2015年 闲人. All rights reserved.
//

#import "BasicController.h"
#import "Masonry.h"


@implementation BasicController
// 放一个300*300的视图到中间
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor redColor];
    // 必须先添加到视图才能添加约束
    [self.view addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(300, 300));
    }];
    
}
@end
