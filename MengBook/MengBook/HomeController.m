//
//  HomeController.m
//  MengBook
//
//  Created by BinTong on 2017/8/7.
//  Copyright © 2017年 TongBin. All rights reserved.
//

#import "HomeController.h"
#import "XLCycleView.h"
#import "HomeCell.h"
#import "HomeModel.h"
#import "HomeJson.h"

@interface HomeController () <XLCycleViewDelegate, UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *listView;
@property(nonatomic, strong) XLCycleView *cycleView;
@property(nonatomic, strong) HomeModel *homeModel;
@property(nonatomic, strong)NSMutableArray *listDatas;
@property(nonatomic, strong) IBOutlet UIView *remenView;

@end

@implementation HomeController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createListView];

    self.homeModel = [[HomeModel alloc] init];
    [self loadNet];
}

- (void)loadNet {
    NSDictionary *par = @{@"pageNum":@(0)};
    self.pageNum = 0;
    [self.homeModel requestHomeDataParameters:par result:^(id result) {
        HomeJson *homejson = result;
        
        self.listDatas = [NSMutableArray arrayWithArray:homejson.items];
        [self.listView reloadData];
        [self.listView.mj_header endRefreshing];
    } fail:^(NSError *error) {
        [self.listView.mj_header endRefreshing];
    }];
}

- (void)createListView {
    self.listView = [[UITableView alloc] initWithFrame: CGRectMake(0,0,SCREEN_WIDTH,SCREEN_HEIGHT-44) style:UITableViewStylePlain];
    self.listView.backgroundColor = [UIColor clearColor];
    self.listView.delegate = self;
    self.listView.dataSource = self;
    self.listView.rowHeight = 46;
    [self.view addSubview:self.listView];
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0,0,SCREEN_WIDTH,200+ 30)];
    self.remenView.frame = CGRectMake(0, 210, SCREEN_WIDTH, 20);
    
    headerView.backgroundColor = [UIColor clearColor];
    [headerView addSubview:self.remenView];
    self.listView.tableHeaderView = headerView;
    
    CGRect rect = CGRectMake(0,0,SCREEN_WIDTH,200);
    self.cycleView = [XLCycleView XLCycleView:rect bitmap:nil];
    self.cycleView.backgroundColor = self.navigationController.navigationBar.barTintColor;
    self.cycleView.delegate = self;
    [self.cycleView reloadData:3.0f number:2];
    
    [self.listView.tableHeaderView addSubview:self.cycleView];
    self.listView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNet)];
    [self.listView.mj_header beginRefreshing];
    self.listView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    
}

- (void)loadMoreData {
    self.pageNum += 1;
    NSDictionary *par = @{@"pageNum":@(self.pageNum)};
    [self.homeModel requestHomeDataParameters:par result:^(id result) {
        HomeJson *homejson = result;
        if ([result isKindOfClass:[NSArray class]] || homejson.items.count == 0) {
            NSArray *ar = [NSArray arrayWithArray:homejson.items];
            if (ar.count == 0) {
                [TTHudHelper showTip:@"没有更多啦"];
                [self.listView.mj_footer endRefreshingWithCompletionBlock:^{
                }];
            }
        }else {
            [self.listDatas addObjectsFromArray:homejson.items];
            [self.listView reloadData];
            [self.listView.mj_footer endRefreshingWithCompletionBlock:^{}];
        }
        
        
    } fail:^(NSError *error) {
        [self.listView.mj_footer endRefreshing];
    }];
}

- (UILabel *)labelWithFontSize:(CGFloat)fontSize FontColor:(UIColor *)fontColor  frame:(CGRect)frame Text:(NSString *)text{
    UILabel *lbTitle = [[UILabel alloc] initWithFrame:frame];
    lbTitle.backgroundColor = [UIColor clearColor];
    lbTitle.font = [UIFont systemFontOfSize:fontSize];
    lbTitle.textColor = fontColor;
    lbTitle.textAlignment = NSTextAlignmentCenter;
    lbTitle.text = text;
    return lbTitle;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 120;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.listDatas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    HomeCell *cell = (HomeCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell)
    {
        [tableView registerNib:[UINib nibWithNibName:@"HomeCell" bundle:nil] forCellReuseIdentifier:CellIdentifier];
        cell = (HomeCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    }
    
    BookInfo *book  = [self.listDatas objectAtIndex:indexPath.row];
    cell.name.text = book.title;
    cell.attri.text = book.abstract;
    cell.author.text = book.author;
    [cell.img sd_setImageWithURL:[NSURL URLWithString:book.img] placeholderImage:nil];
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
        HBWebController *web = [[HBWebController alloc] init];
    
        BookInfo *bookInfo =  [self.listDatas objectAtIndex:indexPath.row];
        web.webUrl = bookInfo.href;
        web.webTitle = bookInfo.title;
        web.itemTitle = bookInfo.title;
    
        web.imgUrl = bookInfo.img;
        HomeCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        web.shareLittleImg = cell.img.image;
        [self.navigationController pushViewController:web animated:YES];
    
}

#pragma mark - XLCycleView

- (void)refreshImage:(UIButton *)button withIndex:(NSInteger)index {
    NSArray *ar = self.homeModel.homeJson.banners;
    if (index < ar.count){
        Banner *entity = [ar objectAtIndex:index];
        [button sd_setImageWithURL:[NSURL URLWithString:entity.img_url] forState:UIControlStateNormal];
        button.contentMode = UIViewContentModeScaleAspectFit;
    }
}

- (void)xlcycleView:(XLCycleView *)cycleView didSelectAtIndex:(NSInteger)index {
    NSArray *ar = self.homeModel.homeJson.banners;
    Banner *entity = [ar objectAtIndex:index];
    if (entity.img_url){
        HBWebController *web = [[HBWebController alloc] init];
        web.showAddButton = NO;
        web.webUrl = entity.img_href;
//        web.msgId = entity.msgId;
//        web.refer = @"0";
        
        [self.navigationController pushViewController:web animated:YES];
    }
}

@end
