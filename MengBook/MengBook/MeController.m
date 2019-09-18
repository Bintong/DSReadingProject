//
//  MeController.m
//  MengBook
//
//  Created by BinTong on 2017/8/7.
//  Copyright © 2017年 TongBin. All rights reserved.
//

#import "MeController.h"
#import "SaveItem.h"
#import "BookShelfCell.h"


@interface MeController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic, strong)NSMutableArray *listDatas;
@property(nonatomic, strong)NSMutableArray *splitDatas;
@property(nonatomic, strong)UITableView *listView;
@property(nonatomic, strong)HBWebController *webviewctr;
@end

@implementation MeController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.listDatas = [NSMutableArray array];
    self.splitDatas = [NSMutableArray array];
    self.webviewctr = [[HBWebController alloc] init];
    [self createListView]; 
}

- (void)createListView {
    self.listView = [[UITableView alloc] initWithFrame:SCREEN_BOUNDS style:UITableViewStylePlain];
    self.listView.backgroundColor = [UIColor clearColor];
    self.listView.delegate = self;
    self.listView.dataSource = self;
    
    self.listView.height = SCREEN_HEIGHT - 64;
    [self.view addSubview:self.listView];
    UIView *vi = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
    self.listView.tableFooterView = vi;
    
    self.listView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(readDB)];
    [self.listView.mj_header beginRefreshing];
}

- (void)readDB {
    
    [self.splitDatas removeAllObjects];
    [self.listDatas removeAllObjects];
    [self.listView.mj_header endRefreshing];

    
    NSString *path = [TTFileUtils filePathInDocumentDirectoryWithComponents:@[@"save",@"items.db"]];
    FMDatabase *db=[FMDatabase databaseWithPath: path];
    [db open];
    FMResultSet *resultSet = [db executeQuery:@"SELECT * FROM t_items"];
    
    while ([resultSet next]) {
        SaveItem *left = [[SaveItem alloc] init];
        left.bookTitle= [resultSet stringForColumn:@"title"];
        left.bookSubTitle  = [resultSet stringForColumn:@"subtitle"];
        left.bookImg = [resultSet stringForColumn:@"imgUrl"];
        left.bookHref = [resultSet stringForColumn:@"url"];
        [self.listDatas addObject:left];
    }
    [db close];
    [self splitArray:self.listDatas];
    [self.listView reloadData];

}

- (void)splitArray:(NSArray *)array {
    NSArray *iArr = [NSArray arrayWithArray:array];
    for (int i = 0; i < iArr.count/3 +1 ; i++ ) {
        NSMutableArray *arr = [NSMutableArray arrayWithCapacity:3];
        [arr addObject:([self.listDatas objectAtIndexCheck:0] == nil ? @"":[self.listDatas objectAtIndexCheck:0])];
        [arr addObject:([self.listDatas objectAtIndexCheck:1] == nil ? @"":[self.listDatas objectAtIndexCheck:1])];
        [arr addObject:([self.listDatas objectAtIndexCheck:2] == nil ? @"":[self.listDatas objectAtIndexCheck:2])];
        
        if (self.listDatas.count > 2) {
            [self.listDatas removeObjectAtIndex:0];
            [self.listDatas removeObjectAtIndex:0];
            [self.listDatas removeObjectAtIndex:0];
        }
        else if (self.listDatas.count > 1) {
            [self.listDatas removeObjectAtIndex:0];
            [self.listDatas removeObjectAtIndex:0];
        }
        
        else if (self.listDatas.count > 0) {
            [self.listDatas removeObjectAtIndex:0];
        }
        [self.splitDatas addObject:arr];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 162;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.splitDatas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *renren_CellIdentifier = @"mCell";
    BookShelfCell *cell = (BookShelfCell *)[tableView dequeueReusableCellWithIdentifier:renren_CellIdentifier];
    if (!cell)
    {
        [tableView registerNib:[UINib nibWithNibName:@"BookShelfCell" bundle:nil] forCellReuseIdentifier:renren_CellIdentifier];
        cell = (BookShelfCell *)[tableView dequeueReusableCellWithIdentifier:renren_CellIdentifier];
    }
   
    [self loadButtonWebImg:cell index:indexPath];
    return cell;
}


- (void)loadButtonWebImg:(BookShelfCell *)cell  index:(NSIndexPath *)indexPath{
    NSArray *arr  =  [self.splitDatas objectAtIndex:indexPath.row];
    
    SaveItem *item_0 = [arr objectAtIndexCheck:0];
    SaveItem *item_1 = [arr objectAtIndexCheck:1];
    SaveItem *item_2 = [arr objectAtIndexCheck:2];
    __weak typeof(self) weakSelf = self;
    if (item_0 && [item_0 isKindOfClass:[SaveItem class]]) {
        cell.label1.text = item_0.bookTitle;
        [cell.button1 sd_setBackgroundImageWithURL:[NSURL URLWithString:item_0.bookImg] forState:UIControlStateNormal completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        }];
        cell.block= ^(void){
            _webviewctr.webUrl = item_0.bookHref;
            [_webviewctr refreshWeb];
            [weakSelf.navigationController pushViewController:weakSelf.webviewctr animated:YES];
        };
        
    }else{
        cell.button1.hidden = YES;
        cell.label1.hidden = YES;
    }
    if (item_1 && [item_1 isKindOfClass:[SaveItem class]]) {
        cell.label2.text = item_1.bookTitle;

        [cell.button2 sd_setBackgroundImageWithURL:[NSURL URLWithString:item_1.bookImg] forState:UIControlStateNormal completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        }];
        cell.block= ^(void){
            _webviewctr.webUrl = item_1.bookHref;
            [_webviewctr refreshWeb];
            [weakSelf.navigationController pushViewController:weakSelf.webviewctr animated:YES];
        };
    }else{
        cell.button2.hidden = YES;
        cell.label2.hidden = YES;
    }
    if (item_2 && [item_2 isKindOfClass:[SaveItem class]]) {
        cell.label3.text = item_2.bookTitle;

        [cell.button3 sd_setBackgroundImageWithURL:[NSURL URLWithString:item_2.bookImg] forState:UIControlStateNormal completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        }];
    
        cell.block= ^(void){
            _webviewctr.webUrl = item_2.bookHref;
            [_webviewctr refreshWeb];
            [weakSelf.navigationController pushViewController:weakSelf.webviewctr animated:YES];
        };
    }else{
        cell.button3.hidden = YES;
        cell.label3.hidden = YES;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    HBWebController *web = [[HBWebController alloc] init];
//    LeftItem *left = [self.listDatas objectAtIndex:indexPath.row];
//    web.webUrl = left.leftUrl;
//    web.webTitle = left.leftTitle;
//    web.itemTitle = left.leftTitle;
//    LeftTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
//    web.shareLittleImg = cell.leftImg.image;
//    [self.navigationController pushViewController:web animated:YES];
}


@end
