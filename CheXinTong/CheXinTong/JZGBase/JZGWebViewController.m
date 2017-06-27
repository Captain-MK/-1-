 //
//  PLWebViewController.m
//  PLTP_M_CARRIERS
//
//  Created by Lucas on 14/12/12.
//  Copyright (c) 2014年 Jack. All rights reserved.
//

#import "JZGWebViewController.h"

@interface JZGWebViewController ()<WKNavigationDelegate,WKUIDelegate>{
}

@end

@implementation JZGWebViewController

- (void)dealloc{
}

- (instancetype)init{
    self = [super init];
    if (self) {
        _webView = [[WKWebView alloc] initWithFrame:CGRectMake(0.0f, NAVIGATION_BAR_HEIGHT, kScreenWidth, kScreenHeight-NAVIGATION_BAR_HEIGHT)];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _webView.navigationDelegate = self;
    _webView.UIDelegate = self;
    _webView.scrollView.showsVerticalScrollIndicator = YES;
    _webView.scrollView.showsHorizontalScrollIndicator = NO;
    _webView.autoresizingMask =  UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    if (_url) {
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:_url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:60];
        [request addValue:@"app" forHTTPHeaderField:@"agent"];
        [_webView loadRequest:request];
        [self.view addSubview:_webView];
    }
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.webView.frame = self.view.bounds;
    
    if (!_url) {
        [MBProgressHUD showError:@"链接地址错误" toView:self.view];
        return;
    }
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - WKNavigationDelegate
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    // 类似 UIWebView 的 -webView: shouldStartLoadWithRequest: navigationType:
    NSString *url = [navigationAction.request.URL.absoluteString stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    decisionHandler(WKNavigationActionPolicyAllow);
    if ([url isContainSubString:@"tel:"]) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
    }
    NSLog(@"VVVV %@",url);
}

- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    // 类似UIWebView的 -webViewDidStartLoad:
    [[JZGHudManager share] showHUDWithTitle:@"正在加载..."
                                     inView:self.view
                              isPenetration:NO];
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    // 类似 UIWebView 的 －webViewDidFinishLoad:
    [self webViewDidFinished:webView];
}

- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error{
    // 类似 UIWebView 的- webView:didFailLoadWithError:
    [[JZGHudManager share] hide];
    if([error code] == NSURLErrorCancelled)
    {
        
    }else
    {
//        [MBProgressHUD showError:@"加载失败" toView:self.view];
    }
}

-(void)webViewDidFinished:(WKWebView *)webView
{
    [[JZGHudManager share] hide];
    if (webView.title.length > 0) {
        [self setRootNavigationTitle:webView.title];
    }
}

- (void)leftButtonMethod{
//    if ([_webView canGoBack]) {
//        [_webView goBack];
//    }
//    else{
        [super leftButtonMethod];
//    }
}

@end
