//
//  MLRefreshAnimationHeader.m
//  MJRefresh
//
//  Created by 王三 on 2018/12/29.
//

#import "MLRefreshAnimationHeader.h"
#import "UIImage+KWTools.h"


@interface MLRefreshAnimationHeader()
@property (nonatomic, assign) RefreshState refreshState;
@property (nonatomic, strong) UIImageView *gifImageView;
@end

@implementation MLRefreshAnimationHeader

+ (instancetype)headerWithRefreshState:(RefreshState)refreshState
                   changedContentBlock:(ChangedContentBlock)changedContentBlock
                        refrshingBlock:(MJRefreshComponentRefreshingBlock)refrshingBlock{
    
    MLRefreshAnimationHeader *header = [self headerWithRefreshingBlock:refrshingBlock];
    if (header) {
        if (refreshState != RefreshStateWithNomarl && changedContentBlock) {
             RefreshModel *model = changedContentBlock(refreshState);
            header.refreshState = refreshState;
            [header setHeaderData:model refreshState:refreshState];
        }
    }
    return header;
}


- (void)setHeaderData:(RefreshModel *)model refreshState:(RefreshState)refreshState{
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
            [self placeSubviews];
        }
            break;
        case RefreshStateWithChangedContentAndGifImage:
        {
            [self setTitleWithModel:model];

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

- (UIImageView *)gifImageView{
    if (!_gifImageView) {
        _gifImageView = [[UIImageView alloc] initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width -56)/2.0, 0, 56, 60)];
        [self addSubview:_gifImageView];
    }
    return _gifImageView;
}

#pragma mark - 实现父类的方法
- (void)prepare
{
    [super prepare];
    
    if (_refreshState == RefreshStateWithChangedGifImage) {
        // 初始化间距
        self.labelLeftInset = 20;
        self.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 70);
//        self.backgroundColor = kBackgroundColor;
    }

}

- (void)placeSubviews
{
    [super placeSubviews];
    if (_refreshState == RefreshStateWithChangedGifImage) {
        self.stateLabel.hidden = YES;
        self.lastUpdatedTimeLabel.hidden = YES;
        self.gifImageView.hidden = NO;
    }
}

- (void)setState:(MJRefreshState)state
{
    MJRefreshCheckState
    if (_refreshState == RefreshStateWithChangedGifImage) {
        // 根据状态做事情
        if (state == MJRefreshStateRefreshing) {
            NSString *filePath = [[RefreshModel mlhBundle:@"MLRefreshSDK" class:[MLRefreshAnimationHeader class]] pathForResource:@"DropDownRefreshDynamicDiagram.gif" ofType:nil];
            NSData *gifData = [NSData dataWithContentsOfFile:filePath];
            self.gifImageView.image = [UIImage animatedGIFWithData:gifData];
        } else{
            self.gifImageView.image = [UIImage imageNamed:@"pullRefresh_bitmap" inBundle:[RefreshModel mlhBundle:@"MLRefreshSDK" class:[MLRefreshAnimationHeader class]] compatibleWithTraitCollection:nil];//[UIImage imageNamed:@"pullRefresh_bitmap"];
        }
    }
}

@end
