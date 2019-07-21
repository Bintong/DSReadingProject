//
//  MostViewController.m
//  MengBook
//
//  Created by BinTong on 2017/8/16.
//  Copyright © 2017年 TongBin. All rights reserved.
//

#import "MostViewController.h"


#import "WorldViewController.h"
#import "WordModel.h"
#import "WordCell.h"
#import "WordJson.h"

@interface MostViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic, strong)UITableView *listView;
@property(nonatomic, strong)NSMutableArray *listDatas;
@property(nonatomic, strong)WordModel *wordModel;

@end

@implementation MostViewController

- (void)buildListView {
    self.listView = [[UITableView alloc] initWithFrame:SCREEN_BOUNDS style:UITableViewStylePlain];
    self.listView.backgroundColor = [UIColor clearColor];
    self.listView.delegate = self;
    self.listView.dataSource = self;
    self.listView.rowHeight = 46;
    
    self.listView.height = SCREEN_HEIGHT - 64;
    [self.view addSubview:self.listView];
    self.listView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    [self.listView.mj_header beginRefreshing];
    self.listView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
}

- (void)loadNewData {
    NSDictionary *par = @{@"pageNum":@(0)};
    self.pageNum = 0;
    [self.wordModel requestMostDataParameters:par result:^(id result) {
        NSLog(@"count --->>%@",result);
        self.listDatas = result;
        [self.listView reloadData];
        [self.listView.mj_header endRefreshingWithCompletionBlock:^{
        }];
    } fail:^(NSError *error) {
        [self.listView.mj_header endRefreshing];
    }];
}

- (void)loadMoreData {
    self.pageNum += 1;
    NSDictionary *par = @{@"pageNum":@(self.pageNum)};
    [self.wordModel requestMostDataParameters:par result:^(id result) {
        NSLog(@"count --->>%@",result);
        if ([result isKindOfClass:[NSArray class]]) {
            NSArray *ar = [NSArray arrayWithArray:result];
            if (ar.count == 0) {
                [TTHudHelper showTip:@"没有更多啦"];
            }
        }
        [self.listDatas addObjectsFromArray:result];
        [self.listView reloadData];
        [self.listView.mj_footer endRefreshingWithCompletionBlock:^{
        }];
    } fail:^(NSError *error) {
        [self.listView.mj_footer endRefreshing];
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.pageNum = 0;
    self.wordModel = [[WordModel alloc] init];
    [self buildListView];
    
    // Do any additional setup after loading the view from its nib.
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 159;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.listDatas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Mcell";
    WordCell *cell = (WordCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell)
    {
        [tableView registerNib:[UINib nibWithNibName:@"WordCell" bundle:nil] forCellReuseIdentifier:CellIdentifier];
        cell = (WordCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    }
    if (self.listDatas.count > 0) {
        WordJson  *jsModel =  [self.listDatas objectAtIndex:indexPath.row];
        [cell.img sd_setImageWithURL:[NSURL URLWithString:jsModel.img]];
        cell.titleLabel.text = jsModel.title;
        cell.authorLabel.text = jsModel.author;
        cell.bookNameLabel.text = jsModel.bookname;
        cell.wordsLabel.text = jsModel.articl;
    }
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    HBWebController *web = [[HBWebController alloc] init];
    WordJson *bookInfo =  [self.listDatas objectAtIndex:indexPath.row];
    web.webUrl = bookInfo.href;
    web.webTitle = bookInfo.title;
    web.itemTitle = bookInfo.title;
    web.imgUrl = bookInfo.img;
    WordCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    web.shareLittleImg = cell.img.image;
    [self.navigationController pushViewController:web animated:YES];
    
    //    HBWebController *web = [[HBWebController alloc] init];
    //
    //    IFanrJsonModel *jsModel =  [self.listDatas objectAtIndex:indexPath.row];
    //    web.webUrl = jsModel.ifanr_toUrl;
    //    web.webTitle = jsModel.ifanr_title;
    //    web.itemTitle = jsModel.ifanr_title;
    //
    //    web.imgUrl = jsModel.ifanr_header_img;
    //    IFanrTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    //    web.shareLittleImg = cell.img.image;
    //    [self.navigationController pushViewController:web animated:YES];
    
}



@end
