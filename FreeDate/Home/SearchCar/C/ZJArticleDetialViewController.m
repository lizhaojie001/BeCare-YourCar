//
//  ZJArticleDetialViewController.m
//  FreeDate
//
//  Created by macbook pro on 2018/4/3.
//  Copyright © 2018年 macbook pro. All rights reserved.
//

#import "ZJArticleDetialViewController.h"
#import <WebKit/WebKit.h>
#import <SafariServices/SFSafariViewController.h>
@interface ZJArticleDetialViewController ()<WKNavigationDelegate,WKUIDelegate>

@end

@implementation ZJArticleDetialViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.data.title;
    WKWebViewConfiguration * config = [[WKWebViewConfiguration alloc]init];
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    CGRect rect   = CGRectMake(0, 0, screenSize.width, screenSize.height);
    WKWebView * web = [[WKWebView alloc]initWithFrame:rect configuration:config];
    web.UIDelegate = self;
    web.navigationDelegate = self;
    [self.view  addSubview:web];



    NSURLSessionConfiguration * config1 = [NSURLSessionConfiguration defaultSessionConfiguration];
    [config1 setHTTPAdditionalHeaders:@{@"Host":@"cont.app.autohome.com.cn"}];
    NSURLSession * session = [NSURLSession sessionWithConfiguration:config1];
    NSURLSessionTask *task =    [ session dataTaskWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://61.240.128.76/cont_v8.8.5/content/news/newscontent-pm1-n%ld-t0-rct1-ish1-ver.json",self.data.id]] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            return ;
        }else{
            NSString * str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
            NSLog(@"%@",str);
            dispatch_async(dispatch_get_main_queue(), ^{
                [web loadHTMLString:str baseURL:nil];
            });

        }

    }]   ;
    [task resume];
    // Do any additional setup after loading the view from its nib.
}


-(void)webView:(WKWebView *)webView didReceiveAuthenticationChallenge:(nonnull NSURLAuthenticationChallenge *)challenge completionHandler:(nonnull void (^)(NSURLSessionAuthChallengeDisposition, NSURLCredential * _Nullable))completionHandler{



//    if ([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust]) {
//
//        NSURLCredential *card = [[NSURLCredential alloc]initWithTrust:challenge.protectionSpace.serverTrust];
//
//        completionHandler(NSURLSessionAuthChallengeUseCredential,card);
//
//    }
//
//    return;

    if([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust]) {

        if([challenge previousFailureCount] ==0){

        NSURLCredential*credential = [NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust];

            completionHandler(NSURLSessionAuthChallengeUseCredential, credential);

        }else{

            completionHandler(NSURLSessionAuthChallengeCancelAuthenticationChallenge,nil);

        }
    }else{
        completionHandler(NSURLSessionAuthChallengeCancelAuthenticationChallenge,nil);
    }

}


@end
