//
//  FAIntegralViewController.m
//  FarmAndAnimal
//
//  Created by 郑州动力无限科技 on 2017/2/18.
//  Copyright © 2017年 DaviD. All rights reserved.
//

#import "FAIntegralViewController.h"
#import "MJRefresh.h"
#import "FABalanceView.h"
#import "FAIntegralTableViewCell.h"
@interface FAIntegralViewController ()<UITableViewDataSource,UITableViewDelegate,FABalanceViewDelegate>
{
    MJRefreshNormalHeader *_header;
    MJRefreshAutoNormalFooter *_footer;
    NSInteger  _loadPage;
    NSInteger  _currentSelectIndex;
    FAUserModel * _userModel;
}
@property (strong,nonatomic)NSMutableArray * listArray;
@property (strong,nonatomic)UITableView * tableView;
@property (strong,nonatomic)FABalanceView * balanceView;

@end

@implementation FAIntegralViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _userModel = [FAUserTools UserAccount];
    [self.view addSubview:self.balanceView];
    [self.view addSubview:self.tableView];
    [self initMJRefresh];
    //    [self getListRequest:2];

}
#pragma mark   FABalanceViewDelegate
- (void)chooseSection:(NSInteger)index
{
    DDLog(@"---------%ld--------",(long)index);
}
#pragma mark   initMJRefresh
-(void)initMJRefresh{
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadNewData方法）
    _header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    
    // 设置自动切换透明度(在导航栏下面自动隐藏)
    _header.automaticallyChangeAlpha = YES;
    
    // 隐藏时间
    _header.lastUpdatedTimeLabel.hidden = YES;
    // 设置header
    self.tableView.mj_header = _header;
    
    _footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    
    // 当上拉刷新控件出现50%时（出现一半），就会自动刷新。这个值默认是1.0（也就是上拉刷新100%出现时，才会自动刷新）
    _footer.triggerAutomaticallyRefreshPercent = 0.2;
    _footer.automaticallyChangeAlpha = YES;
    // 隐藏刷新状态的文字
    _footer.refreshingTitleHidden = YES;
    
    // 设置footer
    self.tableView.mj_footer = _footer;
}
#pragma mark   下拉刷新数据
- (void)loadNewData
{
    self.tableView.userInteractionEnabled = NO;
    _loadPage = 1;
    [self getListRequest:1];
}

#pragma mark   上拉加载更多数据
- (void)loadMoreData
{
    self.tableView.userInteractionEnabled = NO;
    _loadPage ++;
    [self getListRequest:2];
}
-(void)getListRequest:(NSInteger)currentType{
    CMHttpRequestModel *model =[[CMHttpRequestModel alloc]init];
    model.appendUrl = kGood_GetGoodListData;
    NSMutableDictionary *params =[NSMutableDictionary dictionary];
    //    [params setValue:self.classid forKey:@"classid"];
    [params setValue:@(1) forKey:@"userid"];
    [params setValue:[NSNumber numberWithInteger:_loadPage] forKey:@"page"];
    model.paramDic =params;
    WS(ws);
    [[DisplayHelper shareDisplayHelper]showLoading:self.view];
    
    model.callback = ^(CMHttpResponseModel * result, NSError *error) {
        if (result.state ==CMReponseCodeState_Success) {
            if (!result.data) {
                [DisplayHelper displaySuccessAlert:@"没有数据哦!"];
                return ;
            }
            if (currentType == 1) {
                [self.listArray removeAllObjects];
            }
        }else {  // 失败的情况
            [CMHttpStateTools showHtttpStateView:result.state];
        }
        [self endTransition];
        [[DisplayHelper shareDisplayHelper]hideLoading:ws.view];
    };
    
    [[CMHTTPSessionManager sharedHttpSessionManager] sendHttpRequestParam:model];
}
-(void)endTransition{
    self.tableView.userInteractionEnabled = YES;
    [_header endRefreshing];
    [_footer endRefreshing];
}
#pragma mark - －－－－－行数－－－－－
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
    
    return cell.frame.size.height;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //    return self.listArray.count;
    return 5;
}
- ( UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0,self.tableView.frame.origin.y, SCREEN_WIDTH,NavigationBar_HEIGHT)];
    if (self.listArray.count == 0) {
        UILabel * footerLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,0, SCREEN_WIDTH,view.frame.size.height)];
        footerLabel.text =@"没有数据哦";
        footerLabel.textColor = RGBCOLOR(251, 58, 47);
        footerLabel.textAlignment = NSTextAlignmentCenter ;
        footerLabel.font = [UIFont systemFontOfSize:16];
        [view addSubview:footerLabel];
    }
    return view;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (self.listArray.count == 0) {
        return (SCREEN_WIDTH-NavigationBar_BarHeight)/2;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentify = @"FAIntegralTableViewCell";
    
    FAIntegralTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentify];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"FAIntegralTableViewCell" owner:nil options:nil] lastObject];
        cell.selectionStyle =UITableViewCellSelectionStyleNone;
    }
    return cell;
}
-(NSMutableArray *)listArray{
    if (!_listArray) {
        _listArray = [[NSMutableArray alloc] init];
        _listArray = (NSMutableArray *)@[@"1",@"2",@"3"];
    }
    return _listArray;
}
// 懒加载tableview
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0.0,CGRectGetMaxY(self.balanceView.frame), SCREEN_WIDTH,SCREEN_HEIGHT-NavigationBar_BarHeight-NavigationBar_HEIGHT-45) style:UITableViewStylePlain];
        [_tableView setDelegate:self];
        [_tableView setDataSource:self];
        [_tableView setBounces:NO];
        [_tableView setScrollEnabled:NO];
        [_tableView setSectionIndexBackgroundColor:[UIColor clearColor]];
        [_tableView setSectionIndexColor:[UIColor clearColor]];
        [_tableView setBackgroundColor:RGB(244, 245, 246)];
    }
    return _tableView;
}
-(FABalanceView *)balanceView{
    if (!_balanceView) {
        _balanceView = [[FABalanceView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, NavigationBar_HEIGHT+45)];
        _balanceView.titleArr = @[@"全部",@"已领完",@"未领完"];
    }
    return _balanceView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
