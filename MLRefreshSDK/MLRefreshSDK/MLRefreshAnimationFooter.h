//
//  MLRefreshAutoFooter.h
//  MJRefresh
//
//  Created by 王三 on 2018/12/29.
//

#import <MJRefresh/MJRefresh.h>
#import "RefreshModel.h"

typedef RefreshModel *(^ChangedContentBlock)(RefreshState state);

@interface MLRefreshAnimationFooter : MJRefreshAutoGifFooter

/**
 **  refreshState  刷新控件样式
 **  changedContentBlock  刷新控件更换的数据
 **  refrshingBlock  刷新控件的刷新事件
 **/
+ (instancetype)footerWithRefreshState:(RefreshState)refreshState
                   changedContentBlock:(ChangedContentBlock)changedContentBlock
                        refrshingBlock:(MJRefreshComponentRefreshingBlock)refrshingBlock;

@end
