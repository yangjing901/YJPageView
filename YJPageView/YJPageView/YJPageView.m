//
//  YJPageView.m
//  YJPageView
//
//  Created by YangJing on 2018/3/28.
//  Copyright © 2018年 YangJing. All rights reserved.
//

#import "YJPageView.h"

@interface YJPageView () <UIScrollViewDelegate>

@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, strong) NSMutableArray *itemsArray;

@property (nonatomic, strong) UIScrollView *itemsScrollView;

@property (nonatomic, strong) UIScrollView *pagesScrollView;

@end

@implementation YJPageView {
    UIButton *_selectedBtn;
}


- (instancetype)init {
    self = [super init];
    if (self) {
        self.pageShowCount = 2;
        self.themeColor = [UIColor whiteColor];
        self.normalColor = [UIColor lightGrayColor];
        self.hightLightColor = [UIColor blackColor];
        self.itemHeight = 41;
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.pageShowCount = 2;
        self.themeColor = [UIColor whiteColor];
        self.normalColor = [UIColor lightGrayColor];
        self.hightLightColor = [UIColor blackColor];
        self.itemHeight = 41;
    }
    return self;
}

- (void)addItemsView:(UIView *)view title:(NSString *)title {
    
    CGFloat itemWidth = CGRectGetWidth(self.frame)/self.pageShowCount;
    
    UIButton *itemBtn = ({
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:title forState:UIControlStateNormal];
        [btn setTitleColor:self.normalColor forState:UIControlStateNormal];
        [btn setTitleColor:self.hightLightColor forState:UIControlStateDisabled];
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        btn;
    });
    [self.itemsScrollView addSubview:itemBtn];
    itemBtn.frame = CGRectMake(itemWidth*self.dataArray.count, 0, itemWidth, self.itemHeight);
    [itemBtn addTarget:self action:@selector(selectedAction:) forControlEvents:UIControlEventTouchUpInside];
    
    if (self.dataArray.count == 0) {
        itemBtn.enabled = NO;
        _selectedBtn = itemBtn;
    }
    
    [self.pagesScrollView addSubview:view];
    view.frame = CGRectMake(CGRectGetWidth(self.frame)*self.dataArray.count, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame) - self.itemHeight);
    
    [self.dataArray addObject:view];
    [self.itemsArray addObject:itemBtn];
    
    self.itemsScrollView.contentSize = CGSizeMake(itemWidth*self.itemsArray.count, 0);
    self.pagesScrollView.contentSize = CGSizeMake(CGRectGetWidth(self.frame)*self.dataArray.count, 0);
    
}

- (void)selectedAction:(UIButton *)btn {
    _selectedBtn.enabled = YES;
    btn.enabled = NO;
    _selectedBtn = btn;
    
    [UIView animateWithDuration:0.25 animations:^{
        self.lineView.center = CGPointMake(btn.center.x, self.itemHeight-3);
        
    }];
    
    NSInteger index = [self.itemsArray indexOfObject:btn];
    [self.pagesScrollView setContentOffset:CGPointMake(CGRectGetWidth(self.frame)*index, 0) animated:YES];
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSInteger index = scrollView.contentOffset.x/CGRectGetWidth(self.frame);
    
    UIButton *item = self.itemsArray[index];
    if ([_selectedBtn isEqual:item]) return;
    
    _selectedBtn.enabled = YES;
    item.enabled = NO;
    _selectedBtn = item;
    
    [UIView animateWithDuration:0.25 animations:^{
        self.lineView.center = CGPointMake(item.center.x, self.itemHeight-3);
        
    }];
    
}

//MARK: - subviews
- (void)configSubview {
    CGFloat itemWidth = CGRectGetWidth(self.frame)/self.pageShowCount;
    
    self.itemsScrollView = ({
        UIScrollView *view = [[UIScrollView alloc] init];
        view.backgroundColor = self.themeColor;
        view.bounces = YES;
        view;
    });
    [self addSubview:self.itemsScrollView];
    self.itemsScrollView.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), self.itemHeight);
    self.itemsScrollView.contentSize = CGSizeMake(itemWidth*self.itemsArray.count, 0);
    
    [self.itemsScrollView addSubview:self.lineView];
    self.lineView.frame = CGRectMake(0, self.itemHeight-4, 58, 2);
    self.lineView.center = CGPointMake(itemWidth/2, self.itemHeight-3);
    
    self.pagesScrollView = ({
        UIScrollView *view = [[UIScrollView alloc] init];
        view.backgroundColor = [UIColor whiteColor];
        view.pagingEnabled = YES;
        view;
    });
    [self addSubview:self.pagesScrollView];
    self.pagesScrollView.frame = CGRectMake(0, self.itemHeight, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame) - self.itemHeight);
    self.pagesScrollView.contentSize = CGSizeMake(CGRectGetWidth(self.frame)*self.dataArray.count, 0);
    self.pagesScrollView.delegate = self;
    
}

//MARK: - setter
- (void)setSelectedIndex:(NSInteger)selectedIndex {
    if (selectedIndex > self.dataArray.count-1) return;
    
    _selectedIndex = selectedIndex;
    
    UIButton *item = self.itemsArray[selectedIndex];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self selectedAction:item];
        
    });
}

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    
    [self configSubview];
}

- (void)setPageShowCount:(NSInteger)pageShowCount {
    _pageShowCount = pageShowCount;
    
    CGFloat itemWidth = CGRectGetWidth(self.frame)/self.pageShowCount;
    self.lineView.center = CGPointMake(itemWidth/2, self.itemHeight-3);
    self.itemsScrollView.contentSize = CGSizeMake(itemWidth*self.itemsArray.count, 0);
    
}

- (void)setThemeColor:(UIColor *)themeColor {
    _themeColor = themeColor;
    
    if (!self.itemsScrollView || !self.pagesScrollView) return;
    
    self.itemsScrollView.backgroundColor = themeColor;
    self.lineView.backgroundColor = themeColor;
}

- (void)setItemHeight:(CGFloat)itemHeight {
    _itemHeight = itemHeight;
    
    if (!self.itemsScrollView || !self.pagesScrollView) return;
    
    self.itemsScrollView.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), self.itemHeight);
    
    self.lineView.frame = CGRectMake(0, self.itemHeight-4, 58, 2);
    CGFloat itemWidth = CGRectGetWidth(self.frame)/self.pageShowCount;
    self.lineView.center = CGPointMake(itemWidth/2, self.itemHeight-3);
    
    self.pagesScrollView.frame = CGRectMake(0, self.itemHeight, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame) - self.itemHeight);
    
}

//MARK: - getter
- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = self.themeColor;
    }
    return _lineView;
}

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}

- (NSMutableArray *)itemsArray {
    if (!_itemsArray) {
        _itemsArray = [[NSMutableArray alloc] init];
    }
    return _itemsArray;
}

- (NSArray<UIView *> *)childViews {
    return self.dataArray;
}


@end
