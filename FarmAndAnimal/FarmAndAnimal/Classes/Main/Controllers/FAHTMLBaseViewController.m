//
//  FAHTMLBaseViewController.m
//  FarmAndAnimal
//
//  Created by 郑州动力无限科技 on 2017/1/9.
//  Copyright © 2017年 DaviD. All rights reserved.
//

#import "FAHTMLBaseViewController.h"

@interface FAHTMLBaseViewController ()
<UIWebViewDelegate,UIScrollViewDelegate>
{
    UIWebView *_webview;
    NSString *_htmlStr;
    NSString *_webUrl;
    NSString *_htmlFilePath;
}

@end

@implementation FAHTMLBaseViewController
@synthesize titleStr;

-(void)viewWillDisappear:(BOOL)animated
{
     _webview.delegate=nil;
    [super viewWillDisappear:animated];
}
#pragma mark -
#pragma mark -----public function-----
- (void)setHtmlFilePath:(NSString *)path
{
    _htmlFilePath = path;
}
- (void)setHtmlStr:(NSString *)htmlStr
{
    _htmlStr = htmlStr;
}
- (void)setUrl:(NSString *)url
{
    _webUrl = url;
}

- (void)loadWebview
{
    if (_webUrl)
    {
        NSURL *url=[NSURL URLWithString:_webUrl];
        NSURLRequest *request=[NSURLRequest requestWithURL:url];
        [_webview loadRequest:request];
    }
    else if (_htmlStr)
    {
        [_webview loadHTMLString:_htmlStr baseURL:nil];
    }
    else if (_htmlFilePath)
    {
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL fileURLWithPath:_htmlFilePath]];
        [_webview loadRequest:request];
    }
    
}
#pragma mark -
#pragma mark -----draw-----
- (void)drawWebView
{
    _webview=[[UIWebView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64)];
    _webview.scrollView.delegate = self;
    _webview.scrollView.bounces=NO;
    _webview.delegate =self;
    _webview.backgroundColor=[UIColor clearColor];
    
    NSString *meta = [NSString stringWithFormat:@"document.getElementsByName(\"viewport\")[0].content = \"width=%f, initial-scale=2.0, minimum-scale=3.0, maximum-scale=5.0, user-scalable=no\"", _webview.frame.size.width];
    [_webview stringByEvaluatingJavaScriptFromString:meta];
    [_webview setUserInteractionEnabled:YES];
    [_webview setScalesPageToFit:YES];
    [self.view addSubview:_webview];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = titleStr;
    [self drawWebView];
    [self loadWebview];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
