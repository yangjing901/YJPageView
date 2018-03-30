//
//  YJPageView.h
//  YJPageView
//
//  Created by YangJing on 2018/3/28.
//  Copyright © 2018年 YangJing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YJPageView : UIView

/**
 *  选中页签
 */
@property (nonatomic, assign) NSInteger selectedIndex;


/**
 *  每屏展示标签数
 *  默认为2
 */
@property (nonatomic, assign) NSInteger pageShowCount;

/**
 *  标签下选中横线
 */
@property (nonatomic, strong) UIView *lineView;

/**
 *  主题颜色
 */
@property (nonatomic, strong) UIColor *themeColor;

/**
 *  标签默认颜色
 */
@property (nonatomic, strong) UIColor *normalColor;

/**
 *  标签选中颜色
 */
@property (nonatomic, strong) UIColor *hightLightColor;

/**
 *  标签高度
 *  默认 52*kFitHeightScale
 */
@property (nonatomic, assign) CGFloat itemHeight;

/**
 *  所包含的标签
 */
@property (nonatomic, strong, readonly) NSArray <UIView *>*childViews;

/**
 *  添加标签
 */
- (void)addItemsView:(UIView *)view title:(NSString *)title;

@end
