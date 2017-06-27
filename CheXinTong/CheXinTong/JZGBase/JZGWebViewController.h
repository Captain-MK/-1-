//
//  PLWebViewController.h
//  PLTP_M_CARRIERS
//
//  Created by Lucas on 14/12/12.
//  Copyright (c) 2014年 Jack. All rights reserved.
//

#import "JZGBaseViewController.h"
#import <WebKit/WebKit.h>

@interface JZGWebViewController : JZGBaseViewController

@property (nonatomic,readonly)WKWebView *webView;
@property (nonatomic,strong)NSURL *url;

//完成回调方法 如需修改 子类重写该方法
-(void)webViewDidFinished:(WKWebView *)webView;


@end
