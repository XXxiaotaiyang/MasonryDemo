//
//  TestModel.h
//  MasonryDemo
//
//  Created by 闲人 on 15/12/27.
//  Copyright © 2015年 闲人. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TestModel : NSObject
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *desc;
@property (nonatomic, assign) BOOL isExpanded;

@end

typedef void (^TestBlock)(NSIndexPath *indexPath);

@interface TestCell : UITableViewCell

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *descLabel;
@property (nonatomic, strong) NSIndexPath *indexPath;

@property (nonatomic, copy) TestBlock block;

- (void)configCellWithModel:(TestModel *)model;

+ (CGFloat)heightWithModel:(TestModel *)model;
@end
