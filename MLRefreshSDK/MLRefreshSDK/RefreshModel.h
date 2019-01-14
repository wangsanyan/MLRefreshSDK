//
//  RefreshModel.h
//  MJRefresh
//
//  Created by 王三 on 2019/1/11.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    /**默认刷新样式。文案，图片使用SDK自带**/
    RefreshStateWithNomarl,
    /**更改刷新文案**/
    RefreshStateWithChangedContent,
    /**更改刷新样式为整屏图片**/
    RefreshStateWithChangedImage,
    /**更改刷新样式为图片+文字**/
    RefreshStateWithChangedContentAndImage,
    /**更改刷新样式为GIF图片**/
    RefreshStateWithChangedGifImage,
    /**更改刷新样式为GIF图片、文字**/
    RefreshStateWithChangedContentAndGifImage
} RefreshState;

@interface RefreshModel : NSObject
///普通限制状态文案(选中状态不赋值则使用默认文案)
@property (nonatomic, copy) NSString *idleTitle;
///松开就可以进行刷新的状态文案(选中状态不赋值则使用默认文案)
@property (nonatomic, copy) NSString *pullingTitle;
///正在刷新中的状态文案(选中状态不赋值则使用默认文案)
@property (nonatomic, copy) NSString *refreshingTitle;
///即将刷新的状态文案(选中状态不赋值则使用默认文案)
@property (nonatomic, copy) NSString *willRefreshTitle;
///没有更多的数据状态文案(选中状态不赋值则使用默认文案)
@property (nonatomic, copy) NSString *noMoreDataTitle;
///gif图片
@property (nonatomic, strong) NSData *gifData;
///gif图片数组
@property (nonatomic, strong) NSArray *gifArray;


+ (NSBundle *)mlhBundle:(NSString *)bundleName class:(Class)aClass;
@end
