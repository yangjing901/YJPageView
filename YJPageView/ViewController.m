//
//  ViewController.m
//  YJPageView
//
//  Created by YangJing on 2018/3/28.
//  Copyright © 2018年 YangJing. All rights reserved.
//

#import "ViewController.h"
#import "YJPageView.h"

@interface ViewController ()

@property (nonatomic, strong) YJPageView *pageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self addSubViews];
}

- (void)addSubViews {
    self.navigationItem.title = @"PageView";
    
    [self.view addSubview:self.pageView];
    
    UIView *view1 = [UIView new];
    view1.backgroundColor = [UIColor brownColor];
    [self.pageView addItemsView:view1 title:@"Item1"];

    UIView *view2 = [UIView new];
    view2.backgroundColor = [UIColor purpleColor];
    [self.pageView addItemsView:view2 title:@"Item2"];
    
    UIView *view3 = [UIView new];
    view3.backgroundColor = [UIColor orangeColor];
    [self.pageView addItemsView:view3 title:@"Item3"];
}

//MARK: - getter
- (YJPageView *)pageView {
    if (!_pageView) {
        _pageView = [[YJPageView alloc] initWithFrame:CGRectMake(0, 64, CGRectGetWidth([UIScreen mainScreen].bounds), CGRectGetHeight([UIScreen mainScreen].bounds)-64)];
        _pageView.pageShowCount = 3;
        _pageView.themeColor = [UIColor whiteColor];
        _pageView.normalColor = [UIColor lightGrayColor];
        _pageView.hightLightColor = [UIColor blackColor];
        _pageView.lineView.backgroundColor = [UIColor blackColor];
    }
    return _pageView;
}
@end
