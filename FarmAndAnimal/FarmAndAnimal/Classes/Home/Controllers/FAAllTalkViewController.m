//
//  FAAllTalkViewController.m
//  FarmAndAnimal
//
//  Created by 郑州动力无限科技 on 2017/2/15.
//  Copyright © 2017年 DaviD. All rights reserved.
//

#import "FAAllTalkViewController.h"
#import "MJRefresh.h"
#import "FATalkTableViewCell.h"
@interface FAAllTalkViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSInteger _loadPage;
    MJRefreshNormalHeader *_header;
    MJRefreshAutoNormalFooter *_footer;
}
@property (strong,nonatomic)NSMutableArray * listArray;
@property (strong,nonatomic)UITableView * tableView;


@end

@implementation FAAllTalkViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _loadPage= 1;
    [self initMJRefresh];
    [self getRateRequest:2];
}

// 获取评价列表
-(void)getRateRequest:(NSInteger)currentType
{
    CMHttpRequestModel *model =[[CMHttpRequestModel alloc]init];
    model.appendUrl = kSelling_GetRate;
    model.type = CMHttpType_GET;
    NSMutableDictionary *params =[NSMutableDictionary dictionary];
    [params setValue:self.gid forKey:@"godsid"];
    [params setValue:@(_loadPage) forKey:@"page"];
    model.paramDic =params;
    WS(ws);
    if (_loadPage ==1) {
        [[DisplayHelper shareDisplayHelper]showLoading:self.view noteText:@"加载中..."];
    }
    model.callback = ^(CMHttpResponseModel * result, NSError *error) {
        if (result.state ==CMReponseCodeState_Success) {
            if (!result.data) {
                [DisplayHelper displaySuccessAlert:@"请求没有数据哦!"];
                return ;
            }
            if (currentType == 1) {
                [ws.listArray removeAllObjects];
            }

             ws.listArray =result.data;
            [ws.tableView reloadData];
        }else {  // 失败的情况
            _loadPage--;
            [CMHttpStateTools showHtttpStateView:result.state];
        }
        [self endTransition];
    };
    
    [[CMHTTPSessionManager sharedHttpSessionManager] sendHttpRequestParam:model];
}

-(void)endTransition{
    self.tableView.userInteractionEnabled=YES;
    [_header endRefreshing];
    [_footer endRefreshing];
}

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
#pragma mark －－－－－下拉刷新数据－－－－－
- (void)loadNewData
{
    self.tableView.userInteractionEnabled = NO;
    _loadPage = 1;
    [self getRateRequest:1];
}
#pragma mark －－－－－上拉加载更多数据－－－－－
- (void)loadMoreData
{
    self.tableView.userInteractionEnabled = NO;
    _loadPage ++;
    [self getRateRequest:2];
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
    return self.listArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentify = @"FATalkTableViewCell";
    
    FATalkTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentify];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"FATalkTableViewCell" owner:nil options:nil] lastObject];
        cell.selectionStyle =UITableViewCellSelectionStyleNone;
    }
    cell.phoneLabel.text = [[self.listArray objectAtIndex:indexPath.row] objectForKey:@"phe"];
    cell.dateLabel.text = [[self.listArray objectAtIndex:indexPath.row] objectForKey:@"ratetime"];
    cell.infoLabel.text = [[self.listArray objectAtIndex:indexPath.row] objectForKey:@"rateinfo"];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}
- ( UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0,_tableView.frame.origin.y, SCREEN_WIDTH,SCREEN_HEIGHT-64 -(84 -30)*kAppScale)];
    if (self.listArray.count == 0) {
        UILabel * footerLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,0, SCREEN_WIDTH,view.frame.size.height)];
        footerLabel.text =@"暂无评价,快去评价吧";
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
        return (SCREEN_HEIGHT-NavigationBar_HEIGHT)/2;
    }
    return 0;
}
-(NSMutableArray *)listArray{
    if (!_listArray) {
        _listArray = [[NSMutableArray alloc] init];
    }
    return _listArray ;
}
-(UITableView *)tableView{
    if (!_tableView) {
        self.tableView=[[UITableView alloc]initWithFrame:CGRectMake(0,0, SCREEN_WIDTH,SCREEN_HEIGHT-NavigationBar_BarHeight) style:UITableViewStylePlain];
        [_tableView setDelegate:self];
        [_tableView setDataSource:self];
        [_tableView setBounces:NO];
        [_tableView setSectionIndexBackgroundColor:[UIColor clearColor]];
        [_tableView setSectionIndexColor:[UIColor darkGrayColor]];
        [_tableView setBackgroundColor:RGB(240, 240, 240)];
        //cell无数据时，不显示间隔线
        UIView *v = [[UIView alloc] initWithFrame:CGRectZero];
        [_tableView setTableFooterView:v];
    }
    return _tableView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
