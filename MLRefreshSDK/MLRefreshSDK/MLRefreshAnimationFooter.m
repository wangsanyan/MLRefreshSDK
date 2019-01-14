//
//  MLRefreshAutoFooter.m
//  MJRefresh
//
//  Created by 王三 on 2018/12/29.
//

#import "MLRefreshAnimationFooter.h"
#import "AnimationFooterView.h"
@interface MLRefreshAnimationFooter()
@property (nonatomic, strong) AnimationFooterView *footerView;
@property (nonatomic, assign) RefreshState refreshState;
@end

@implementation MLRefreshAnimationFooter

+ (instancetype)footerWithRefreshState:(RefreshState)refreshState
                   changedContentBlock:(ChangedContentBlock)changedContentBlock
                        refrshingBlock:(MJRefreshComponentRefreshingBlock)refrshingBlock{
    
    MLRefreshAnimationFooter *header = [self footerWithRefreshingBlock:refrshingBlock];
    header.refreshState = refreshState;
    if (header) {
        if (refreshState != RefreshStateWithNomarl && changedContentBlock) {
            RefreshModel *model = changedContentBlock(refreshState);
            [header setFooterData:model refreshState:refreshState];
        }
    }
    return header;
}


- (void)setFooterData:(RefreshModel *)model refreshState:(RefreshState)refreshState{
    switch (refreshState) {
        case RefreshStateWithChangedContent:
        {
            [self setTitleWithModel:model];
        }
            break;
        case RefreshStateWithChangedImage:
        {
            
        }
            break;
        case RefreshStateWithChangedContentAndImage:
        {
            [self setTitleWithModel:model];
            
        }
            break;
        case RefreshStateWithChangedGifImage:
        {

        }
            break;
        case RefreshStateWithChangedContentAndGifImage:
        {
            [self prepare];
        }
            break;
        default:
            break;
    }
}

- (void)setTitleWithModel:(RefreshModel *)model{
    if (model.idleTitle.length > 0) {
        [self setTitle:model.idleTitle forState:MJRefreshStateIdle];
    }
    
    if (model.pullingTitle.length > 0) {
        [self setTitle:model.pullingTitle forState:MJRefreshStatePulling];
    }
    
    if (model.refreshingTitle.length > 0) {
        [self setTitle:model.refreshingTitle forState:MJRefreshStateRefreshing];
    }
    
    if (model.willRefreshTitle.length > 0) {
        [self setTitle:model.willRefreshTitle forState:MJRefreshStateWillRefresh];
    }
    
    if (model.noMoreDataTitle.length > 0) {
        [self setTitle:model.noMoreDataTitle forState:MJRefreshStateNoMoreData];
    }
    

}

#pragma mark - 重写方法
#pragma mark 在这里做一些初始化配置（比如添加子控件）
- (void)prepare
{
    [super prepare];
    
    
    if (_refreshState == RefreshStateWithChangedContentAndGifImage) {
        // 设置控件的高度
        self.mj_h = 55;
        
        AnimationFooterView *view = [[AnimationFooterView alloc] init];
        [self addSubview:view];
        self.footerView = view;
    }

}

#pragma mark 在这里设置子控件的位置和尺寸
- (void)placeSubviews
{
    if (_refreshState == RefreshStateWithChangedContentAndGifImage) {
        [super placeSubviews];
        self.footerView.frame = self.bounds;
    }

}


#pragma mark 监听scrollView的contentOffset改变
- (void)scrollViewContentOffsetDidChange:(NSDictionary *)change
{
    [super scrollViewContentOffsetDidChange:change];
    
}

#pragma mark 监听scrollView的contentSize改变
- (void)scrollViewContentSizeDidChange:(NSDictionary *)change
{
    [super scrollViewContentSizeDidChange:change];
    
}

#pragma mark 监听scrollView的拖拽状态改变
- (void)scrollViewPanStateDidChange:(NSDictionary *)change
{
    [super scrollViewPanStateDidChange:change];
    
}


#pragma mark 监听控件的刷新状态
- (void)setState:(MJRefreshState)state
{
    MJRefreshCheckState;
    
    switch (state) {
        case MJRefreshStateIdle:
            if (_refreshState == RefreshStateWithChangedContentAndGifImage) {
                self.footerView.hidden = YES;
                self.footerView.noMoreDataView.hidden = YES;
                self.footerView.imagesContentView.hidden = NO;
                self.footerView.notiText = @"上拉加载更多";
                [self.footerView stopAnimation];
            }
            break;
        case MJRefreshStateRefreshing:
            if (_refreshState == RefreshStateWithChangedContentAndGifImage) {
                self.footerView.hidden = NO;
                self.footerView.noMoreDataView.hidden = YES;
                self.footerView.imagesContentView.hidden = NO;
                self.footerView.notiText = @"刷新中";
                [self.footerView startAnimation];
            }
            break;
        case MJRefreshStateNoMoreData:
        {
            if (_refreshState == RefreshStateWithChangedContentAndGifImage) {
                self.footerView.hidden = NO;
                self.footerView.noMoreDataView.hidden = NO;
                self.footerView.imagesContentView.hidden = YES;
                self.footerView.notiText = @"全部加载完成"; // 没有更多
                [self.footerView stopAnimation];
                //            __weak typeof(self) weakSelf = self;
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    //                weakSelf.state = MJRefreshStateIdle;
                    //                weakSelf.footerView.hidden = YES;
                });
            }
        }
            break;
        default:
            break;
    }
}


@end
