//
//  RefreshModel.m
//  MJRefresh
//
//  Created by 王三 on 2019/1/11.
//

#import "RefreshModel.h"

@implementation RefreshModel

+ (NSBundle *)mlhBundle:(NSString *)bundleName class:(Class)aClass
{
    NSString *mainBundlePath = [NSBundle mainBundle].bundlePath;
    NSString *bundlePath = [NSString stringWithFormat:@"%@/%@.bundle",mainBundlePath,bundleName];
    NSBundle *bundle = [NSBundle bundleWithPath:bundlePath];
    if (bundle == nil) {
        bundlePath = [[NSBundle bundleForClass:aClass].resourcePath
                      stringByAppendingPathComponent:[NSString stringWithFormat:@"/%@.bundle",bundleName]];
        bundle = [NSBundle bundleWithPath:bundlePath];
    }
    return bundle;
}

@end
