//
//  ScrollViewController.m
//  MasonryDemo
//
//  Created by 闲人 on 15/12/27.
//  Copyright © 2015年 闲人. All rights reserved.
//

#import "ScrollViewController.h"
#import "Masonry.h"

#define kCCColor(r,g,b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0]
#define kCCRandomColor kCCColor(arc4random_uniform(256),arc4random_uniform(256),arc4random_uniform(256))

@interface ScrollViewController ()
@property (nonatomic, strong) UIScrollView *scrollView;

@end

@implementation ScrollViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout = NO;
    
    self.scrollView = [[UIScrollView alloc] init];
    self.scrollView.pagingEnabled = NO;
    [self.view addSubview:self.scrollView];
    self.scrollView.backgroundColor = [UIColor lightGrayColor];

    UILabel *lastLabel = nil;
    for (NSUInteger i = 0; i < 20; ++i) {
        UILabel *label = [[UILabel alloc] init];
        label.numberOfLines = 0;
        label.layer.borderColor = [UIColor greenColor].CGColor;
        label.layer.borderWidth = 2.0;
        label.text = [self randomText];
        
        label.textAlignment = NSTextAlignmentLeft;
        label.textColor = kCCRandomColor;
        [self.scrollView addSubview:label];
        
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.right.mas_equalTo(self.view).offset(-15);
            
            if (lastLabel) {
                make.top.mas_equalTo(lastLabel.mas_bottom).offset(20);
            } else {
                make.top.mas_equalTo(self.scrollView).offset(20);
            }
        }];
        
        lastLabel = label;
    }
    
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
        
        // 让scrollview的contentSize随着内容的增多而变化
        make.bottom.mas_equalTo(lastLabel.mas_bottom).offset(20);
    }];
}

- (NSString *)randomText {
    CGFloat length = arc4random() % 50 + 5;
    
    NSMutableString *str = [[NSMutableString alloc] init];
    for (NSUInteger i = 0; i < length; ++i) {
        [str appendString:@"测试数据很长，"];
    }
    
    return str;
}

@end
