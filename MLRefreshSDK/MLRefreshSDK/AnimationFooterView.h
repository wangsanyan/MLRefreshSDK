//
//  AnimationFooterView.h
//  MJRefreshExample
//
//  Created by 辉建荣 on 16/4/14.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AnimationFooterView : UIView

/// 提示文本
@property (nonatomic, copy) NSString *notiText;
/// 没有数据提示
@property (nonatomic, strong) UIView *noMoreDataView;
/// 加载中的动画视图
@property (nonatomic, strong) UIView *imagesContentView;

- (void)startAnimation;

- (void)stopAnimation;

@end
