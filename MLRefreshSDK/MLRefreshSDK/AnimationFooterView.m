//
//  AnimationFooterView.m
//  MJRefreshExample
//
//  Created by 辉建荣 on 16/4/14.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "AnimationFooterView.h"
#import "RefreshModel.h"
 
@interface AnimationFooterView()
{
    UIImageView *centerImageView;
    
    UIImageView *noMoreDataImageView;
    
    NSMutableArray *rightPointArray;
    NSMutableArray *leftPointArray;
}

@property (nonatomic, strong) UILabel *textLabel;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) NSInteger count;

@end

@implementation AnimationFooterView

#pragma mark -
- (void)dealloc
{
    
}

- (instancetype)init
{
    self = [super init];
    if (self)
    {
//        NSArray *views = nil;//[[NSBundle mainBundle] loadNibNamed:@"AnimationFooterView" owner:self options:nil];
//        UIView *view = [views lastObject];
//        [self addSubview:view];
        
        rightPointArray = [[NSMutableArray alloc] init];
        leftPointArray = [[NSMutableArray alloc] init];
        self.backgroundColor = [UIColor whiteColor];
        [self setUpImagesContentView];
        [self setUpNoMoreDataView];
        [self setUpTextLabel];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    //============ 正在加载的动画视图
    _imagesContentView.frame = CGRectMake(0, 2, self.frame.size.width, 28);
    _textLabel.frame = CGRectMake(0, CGRectGetMaxY(_imagesContentView.frame), self.frame.size.width, 20);
    // 中间的大图标
    centerImageView.bounds = CGRectMake(0, 0, 34, 20);
    centerImageView.center = _imagesContentView.center;
    
    // 点
    for (NSInteger i = 0; i < rightPointArray.count; i++)
    {
        UIImageView *rightPoint = rightPointArray[i];
        UIImageView *leftPoint = leftPointArray[i];
        
        rightPoint.frame = CGRectMake(centerImageView.frame.origin.x + centerImageView.frame.size.width + 20 + 20*i,_imagesContentView.center.y-1 , 2, 2);
        leftPoint.frame = CGRectMake(centerImageView.frame.origin.x-20-20*i,_imagesContentView.center.y-1 , 2, 2);
    }
    
    //============ 没有更多内容视图
    _noMoreDataView.frame = CGRectMake(0, 2, self.frame.size.width, 28);
    noMoreDataImageView.frame = CGRectMake((_noMoreDataView.frame.size.width-132)/2.0, (_noMoreDataView.frame.size.height-18)/2.0, 132, 18);
}

#pragma mark - UI
- (void)setUpImagesContentView
{
    //============ 正在加载的动画视图
    _imagesContentView = [UIView new];
    [self addSubview:_imagesContentView];
    // 大图标
    centerImageView = [UIImageView new];
    centerImageView.image = [UIImage imageNamed:@"refresh_iamge" inBundle:[RefreshModel mlhBundle:@"MLRefreshSDK" class:[AnimationFooterView class]] compatibleWithTraitCollection:nil];
    
    [_imagesContentView addSubview:centerImageView];
    
    for (NSInteger i = 0; i < 3; i++) {
        UIImageView *rightPointImageView = [UIImageView new];
        UIImageView *leftPointImageView = [UIImageView new];
        rightPointImageView.image =  [UIImage imageNamed:@"refresh_point" inBundle:[RefreshModel mlhBundle:@"MLRefreshSDK" class:[AnimationFooterView class]] compatibleWithTraitCollection:nil];
        leftPointImageView.image = [UIImage imageNamed:@"refresh_point" inBundle:[RefreshModel mlhBundle:@"MLRefreshSDK" class:[AnimationFooterView class]] compatibleWithTraitCollection:nil];
        
        [rightPointArray addObject:rightPointImageView];
        [leftPointArray addObject:leftPointImageView];
        [_imagesContentView addSubview:rightPointImageView];
        [_imagesContentView addSubview:leftPointImageView];
    }
}

- (void)setUpNoMoreDataView
{
    //============ 没有更多内容视图
    _noMoreDataView = [UIView new];
    [self addSubview:_noMoreDataView];
    
    noMoreDataImageView = [UIImageView new];
    noMoreDataImageView.image = [UIImage imageNamed:@"moreNewStore"];
    [_noMoreDataView addSubview:noMoreDataImageView];
}

- (void)setUpTextLabel
{
    _textLabel = [UILabel new];
    _textLabel.textColor = [UIColor lightGrayColor];
    _textLabel.font = [UIFont systemFontOfSize:13];
    _textLabel.textAlignment = NSTextAlignmentCenter;
    _textLabel.text = @"加载中";
    [self addSubview:_textLabel];
}

#pragma mark - public method
- (void)startAnimation
{
  self.timer = [NSTimer scheduledTimerWithTimeInterval:0.5
                                     target:self
                                   selector:@selector(timerEvent:)
                                   userInfo:nil
                                    repeats:YES];
    
}


- (void)stopAnimation
{
    [self.timer invalidate];
    self.timer = nil;
}

#pragma mark - setter
- (void)setNotiText:(NSString *)notiText
{
    if (notiText) {
        _textLabel.text = notiText;
    }
}

#pragma mark - pravite
- (void)timerEvent:(NSTimer *)timer
{
    UIView *leftPoint1 = leftPointArray[0];
    UIView *leftPoint2 = leftPointArray[1];
    UIView *leftPoint3 = leftPointArray[2];
    
    UIView *rightPoint1 = rightPointArray[0];
    UIView *rightPoint2 = rightPointArray[1];
    UIView *rightPoint3 = rightPointArray[2];
    
    if (_count%4 == 1) {
        rightPoint1.hidden = NO;
        leftPoint1.hidden = NO;
    } else if (_count%4 == 2) {
        rightPoint2.hidden = NO;
        leftPoint2.hidden = NO;
    } else if (_count%4 == 3) {
        rightPoint3.hidden = NO;
        leftPoint3.hidden = NO;
    } else {
        rightPoint1.hidden = YES;
        rightPoint2.hidden = YES;
        rightPoint3.hidden = YES;
        
        leftPoint1.hidden = YES;
        leftPoint2.hidden = YES;
        leftPoint3.hidden = YES;
    }
    _count++;
}

@end
