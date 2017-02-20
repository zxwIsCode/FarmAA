//
//  FAAllOrderViewController.m
//  FarmAndAnimal
//
//  Created by 郑州动力无限科技 on 2017/1/10.
//  Copyright © 2017年 DaviD. All rights reserved.
//

#import "FAAllOrderViewController.h"
#import "FAAllOrderTableViewCell.h"
#define kCellHeight  223
@interface FAAllOrderViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (strong,nonatomic)NSMutableArray * listArray;
@property (strong,nonatomic)UITableView * tableView;

@end

@implementation FAAllOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.tableView];
}
#pragma mark - －－－－－行数－－－－－
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kCellHeight;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.listArray.count;
}
- ( UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0,self.tableView.frame.origin.y, SCREEN_WIDTH,self.tableView.frame.size.height/2)];
    if (self.listArray.count == 0) {
        UILabel * footerLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,0, SCREEN_WIDTH,view.frame.size.height)];
        footerLabel.text =@"还没有订单哦";
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
    FAAllOrderTableViewCell *cell =[FAAllOrderTableViewCell updateWithTableView:tableView];
    if (cell) {
        
    }
    return cell;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
        _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0.0,0, SCREEN_WIDTH,SCREEN_HEIGHT-NavigationBar_BarHeight) style:UITableViewStylePlain];
        [_tableView setDelegate:self];
        [_tableView setDataSource:self];
        [_tableView setBounces:NO];
        [_tableView setScrollEnabled:NO];
        [_tableView setSectionIndexBackgroundColor:[UIColor clearColor]];
        [_tableView setSectionIndexColor:[UIColor darkGrayColor]];
        [_tableView setBackgroundColor:RGB(244, 245, 246)];
    }
    return _tableView;
}

@end
