//
//  FACommodityCollectionReusableView.m
//  FarmAndAnimal
//
//  Created by 郑州动力无限科技 on 2017/1/12.
//  Copyright © 2017年 DaviD. All rights reserved.
//

#import "FACommodityCollectionReusableView.h"
#import "FATalkTableViewCell.h"

@implementation FACommodityCollectionReusableView
{
    CGFloat  _indexHeight;
}
-(void)dealloc{
    self.webView.delegate = nil;
}
-(void)drawRect:(CGRect)rect{
  
    _indexHeight = 0.0f;
    /*
     价格视图
     */
    UIView * moneyView = [[UIView alloc] initWithFrame:CGRectMake(0,kScrollHeight, SCREEN_WIDTH, 110)];
    moneyView.backgroundColor = [UIColor whiteColor];
    [self addSubview:moneyView];
    
    
    UILabel * commodityLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 0,SCREEN_WIDTH, 44)];
    commodityLabel.text = self.commodityName;
    commodityLabel.numberOfLines = 0;
    commodityLabel.textAlignment = NSTextAlignmentLeft ;
    commodityLabel.textColor = [UIColor blackColor];
    commodityLabel.font = [UIFont boldSystemFontOfSize:16.0f];
    [moneyView addSubview:commodityLabel];
    
    UILabel * moneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(5,commodityLabel.frame.origin.y+commodityLabel.frame.size.height, 100, 30)];
    moneyLabel.text = [NSString stringWithFormat:@"¥%@",self.money];
    moneyLabel.textAlignment = NSTextAlignmentLeft ;
    moneyLabel.textColor = RGB(255,69,0);
    moneyLabel.font = [UIFont boldSystemFontOfSize:18.0f];
    [moneyView addSubview:moneyLabel];
    
    
    UILabel * realMoneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(moneyLabel.frame.origin.x,moneyLabel.frame.origin.y+moneyLabel.frame.size.height,150, 30)];
    realMoneyLabel.text = [NSString stringWithFormat:@"积分¥%@",self.uniprice];
    realMoneyLabel.textAlignment = NSTextAlignmentLeft;
    realMoneyLabel.font = [UIFont systemFontOfSize:13.0f];
    realMoneyLabel.textColor = [UIColor grayColor];
    [moneyView addSubview:realMoneyLabel];
    
    
    UILabel * saleNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(commodityLabel.frame.origin.x+commodityLabel.frame.size.width- moneyLabel.frame.size.width,realMoneyLabel.frame.origin.y,SCREEN_WIDTH-CGRectGetMaxX(realMoneyLabel.frame), 30)];
    saleNumLabel.text = [NSString stringWithFormat:@"月销量%@",self.saleNum];
    saleNumLabel.textAlignment = NSTextAlignmentLeft;
    saleNumLabel.font = [UIFont systemFontOfSize:13.0f];
    saleNumLabel.textColor = [UIColor grayColor];
    [moneyView addSubview:saleNumLabel];
    
    
    /*
     评价
     */
    UILabel * bussinessLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,moneyView.frame.origin.y+moneyView.frame.size.height +5,SCREEN_WIDTH, 30)];
    bussinessLabel.text = @"  宝贝评价(0)";
    bussinessLabel.tag = 10;
    bussinessLabel.backgroundColor = [UIColor whiteColor];
    bussinessLabel.textAlignment = NSTextAlignmentLeft ;
    bussinessLabel.textColor = [UIColor grayColor];
    bussinessLabel.font = [UIFont systemFontOfSize:15.0f];
    [self addSubview:bussinessLabel];
    
    _indexHeight = CGRectGetMaxY(bussinessLabel.frame);
    
    [self addSubview:self.tableView];
    
    /*
     商品详情
     */
    
    UILabel * commoditykindsLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,CGRectGetMaxY(self.tableView.frame)+5,SCREEN_WIDTH, 30)];
    commoditykindsLabel.tag = 20;
    commoditykindsLabel.text = @"  商品详情";
    commoditykindsLabel.backgroundColor = [UIColor whiteColor];
    commoditykindsLabel.textAlignment = NSTextAlignmentLeft ;
    commoditykindsLabel.textColor = [UIColor grayColor];
    commoditykindsLabel.font = [UIFont systemFontOfSize:15.0f];
    [self addSubview:commoditykindsLabel];
    
    _indexHeight = CGRectGetMaxY(commoditykindsLabel.frame);
    [self addSubview:self.webView];
}
-(void)reloadRate{
    if (self.listArray.count>0) {
        UILabel * bussinessLabel = (UILabel *)[self viewWithTag:10];
        bussinessLabel.text = [NSString stringWithFormat:@"  宝贝评价(%@)",self.talkcount];
        self.tableView.frame = CGRectMake(0.0,CGRectGetMaxY(bussinessLabel.frame), SCREEN_WIDTH,self.listArray.count*80+NavigationBar_BarHeight);
        [self.tableView reloadData];
        UILabel * commoditykindsLabel = (UILabel *)[self viewWithTag:20];
        commoditykindsLabel.frame = CGRectMake(0,CGRectGetMaxY(self.tableView.frame)+5,SCREEN_WIDTH, 30);
        _indexHeight = CGRectGetMaxY(commoditykindsLabel.frame);
        self.webView.frame = CGRectMake(0,_indexHeight, SCREEN_WIDTH,300);
    }
}

-(NSMutableArray *)listArray{
    if (!_listArray) {
        _listArray = [[NSMutableArray alloc] init];
    }
    return _listArray;
}
// 懒加载tableview
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0.0,_indexHeight, SCREEN_WIDTH,NavigationBar_BarHeight) style:UITableViewStylePlain];
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
-(UIWebView *)webView{
    if (!_webView) {
        _webView=[[UIWebView alloc] initWithFrame:CGRectMake(0,_indexHeight, SCREEN_WIDTH,500)];
        _webView.scrollView.delegate = self;
        _webView.scrollView.bounces=NO;
        _webView.scrollView.scrollEnabled = NO;
        _webView.delegate =self;
        _webView.backgroundColor=[UIColor whiteColor];
        NSString *meta = [NSString stringWithFormat:@"document.getElementsByName(\"viewport\")[0].content = \"width=%f, initial-scale=2.0, minimum-scale=3.0, maximum-scale=5.0, user-scalable=no\"", _webView.frame.size.width];
        [_webView stringByEvaluatingJavaScriptFromString:meta];
        [_webView setUserInteractionEnabled:YES];
        [_webView setScalesPageToFit:YES];
        NSURL *url=[NSURL URLWithString:self.webUrl];
        NSURLRequest *request=[NSURLRequest requestWithURL:url];
        [_webView loadRequest:request];
    }
    return _webView;
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
- ( UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0,_tableView.frame.origin.y, SCREEN_WIDTH,_tableView.frame.size.height/2)];
    view.backgroundColor = [UIColor whiteColor];
    if (self.listArray.count == 0) {
        UILabel * footerLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,0, SCREEN_WIDTH,view.frame.size.height)];
        footerLabel.text =@"还没有评价的订单哦";
        footerLabel.textColor = RGB(175, 175, 175);
        footerLabel.textAlignment = NSTextAlignmentCenter ;
        footerLabel.font = [UIFont systemFontOfSize:16];
        [view addSubview:footerLabel];
    }else{
        UIButton * readTalkButton = [CMCustomViewFactory createButton:CGRectMake(SCREEN_WIDTH/2-150/2, NavigationBar_BarHeight/2-30/2, 150, 30) title:@"查看全部评价" Image:nil];
        readTalkButton.titleLabel.font = [UIFont systemFontOfSize:16.0f*kAppScale];
        [readTalkButton setTitleColor:RGBCOLOR(251, 58, 47) forState:UIControlStateNormal];
        readTalkButton.layer.cornerRadius = YES;
        [readTalkButton addTarget:self action:@selector(readAllTalk) forControlEvents:UIControlEventTouchUpInside];
        readTalkButton.layer.borderColor = RGBCOLOR(251, 58, 47).CGColor;
        readTalkButton.layer.borderWidth = 1.0f;
        [view addSubview:readTalkButton];
    }
    return view;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return NavigationBar_BarHeight;
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
//查看全部评价
-(void)readAllTalk{
    if ([self.delegate respondsToSelector:@selector(enterReadAllTalk)]) {
          [_delegate enterReadAllTalk];
    }
}

@end
