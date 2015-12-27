//
//  ViewController.m
//  MasonryDemo
//
//  Created by 闲人 on 15/12/26.
//  Copyright © 2015年 闲人. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource> {
    UITableView *_tableView;
}


@property(nonatomic, strong) NSMutableArray *classNames;
@property(nonatomic, strong) NSMutableArray *titles;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _tableView = [[UITableView alloc] init];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.frame = self.view.bounds;
    self.classNames = @[].mutableCopy;
    self.titles = @[].mutableCopy;
    
    // 利用class的好处，不用导入这么多头文件了
    [self.view addSubview:_tableView];
    [self addCell:@"基本演示" class:@"BasicController"];
    [self addCell:@"更新约束" class:@"UpdateConstraintsController"];
    [self addCell:@"动画重新添加约束" class:@"RemakeContraintsController"];
    [self addCell:@"整体动画更新约束" class:@"TotalUpdateController"];
    [self addCell:@"复合view循环约束" class:@"CompositeController"];
    [self addCell:@"约束百分比" class:@"AspectFitController"];
    [self addCell:@"基本动画" class:@"BasicAnimatedController"];
    [self addCell:@"ScrollView布局" class:@"ScrollViewController"];
    [self addCell:@"TableView布局" class:@"TableViewController"];
}

- (void)addCell:(NSString *)title class:(NSString *)className {
    [self.titles addObject:title];
    [self.classNames addObject:className];
}

#pragma mark - **************** 数据源方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return  self.classNames.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *reuseIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = self.titles[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *className = self.classNames[indexPath.row];
    Class class = NSClassFromString(className);
    if (class) {
        UIViewController *ctrl = [[class alloc] init];
        ctrl.title = self.titles[indexPath.row];
        [self.navigationController pushViewController:ctrl animated:YES];
    }
    [_tableView deselectRowAtIndexPath:indexPath animated:YES];

}


@end
