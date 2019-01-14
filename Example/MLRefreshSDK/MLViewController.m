//
//  MLViewController.m
//  MLRefreshSDK
//
//  Created by wangsanyan on 12/28/2018.
//  Copyright (c) 2018 wangsanyan. All rights reserved.
//

#import "MLViewController.h"
#import "MLRefreshAnimationHeader.h"
#import "MLRefreshAnimationFooter.h"

@interface MLViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *table;

@property (strong, nonatomic) NSMutableArray *dataArr;
@end

@implementation MLViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    __weak typeof(self) weakSelf = self;
    self.table.mj_header = [MLRefreshAnimationHeader headerWithRefreshState:RefreshStateWithChangedGifImage changedContentBlock:^RefreshModel *(RefreshState state) {
        RefreshModel *model = [[RefreshModel alloc] init];
        model.pullingTitle = @"松开就可以进行刷新";
        model.refreshingTitle = @"正在刷新中";
        model.willRefreshTitle = @"即将刷新";
        return model;
    } refrshingBlock:^{
        [weakSelf performSelector:@selector(loadNewData) withObject:nil afterDelay:5];
    }];
    

    

    self.table.mj_footer = [MLRefreshAnimationFooter footerWithRefreshState:RefreshStateWithChangedContentAndGifImage changedContentBlock:^RefreshModel *(RefreshState state) {
        RefreshModel *model = [[RefreshModel alloc] init];
        model.noMoreDataTitle = @"全部加载完成";
        return model;
    } refrshingBlock:^{
        [weakSelf performSelector:@selector(loadMoreData) withObject:nil afterDelay:15];

    }];
}

- (void)loadNewData{
    [_dataArr removeAllObjects];
    _dataArr = nil;
    [self.table reloadData];
    [self.table.mj_header endRefreshing];
}

- (void)loadMoreData{
    NSInteger index = self.dataArr.count;
    if (index >=39){
        [self.table.mj_footer endRefreshingWithNoMoreData];
    }else{
        for (NSInteger i = index; i<index+10; i++) {
            NSString *title = [NSString stringWithFormat:@"测试数据%zi",i];
            [self.dataArr addObject:title];
        }
        
        [self.table reloadData];
        [self.table.mj_footer endRefreshing];
    }

}


- (NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
        for (NSInteger i=0; i<10; i++) {
            NSString *title = [NSString stringWithFormat:@"测试数据%zi",i];
            [_dataArr addObject:title];
        }
    }
    return _dataArr;
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TestCell"];
    UILabel *lable = (UILabel *)[cell viewWithTag:1000];
    lable.text = self.dataArr[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
