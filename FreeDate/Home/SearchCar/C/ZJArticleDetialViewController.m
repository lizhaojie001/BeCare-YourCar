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
    // 根据JS字符串初始化WKUserScript对象
    NSString *js = @"var images = document.getElementsByTagName('img') ; var count = document.images.length;for (var i = 0; i < count; i++) {var image = document.images[i];var a = image.getAttribute(\"data-original\") ; if(a!=null){ image.setAttribute(\"src\",a)} };";
    WKUserScript *script = [[WKUserScript alloc] initWithSource:js injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:YES];
    // 根据生成的WKUserScript对象，初始化WKWebViewConfiguration
    [config.userContentController addUserScript:script];
    NSURLSessionConfiguration * config1 = [NSURLSessionConfiguration defaultSessionConfiguration];

    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    CGRect rect   = CGRectMake(0, 0, screenSize.width, screenSize.height);
    WKWebView * web = [[WKWebView alloc]initWithFrame:rect configuration:config];
    web.UIDelegate = self;
    web.navigationDelegate = self;
    [self.view  addSubview:web];

    NSString * url = [NSString stringWithFormat:@"http://61.240.128.76/cont_v8.8.5/content/news/newscontent-pm1-n%ld-t0-rct1-ish1-ver.json",self.data.id];



    [config1 setHTTPAdditionalHeaders:@{@"Host":@"cont.app.autohome.com.cn"}];
    NSURLSession * session = [NSURLSession sessionWithConfiguration:config1];


    [config.userContentController addUserScript:script];
    NSURLSessionTask *task =    [ session dataTaskWithURL:[NSURL URLWithString:url] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            return ;
        }else{
            NSString * str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
//            [str stringByReplacingOccurrencesOfString:@"</title>" withString:@"</title>\n<script src=\"https://www.imooc.com/static/lib/jquery/1.9.1/jquery.js\"></script>"];

            dispatch_async(dispatch_get_main_queue(), ^{

                [web loadHTMLString:str baseURL:nil];
            });

        }

    }]   ;
    [task resume];
    // Do any additional setup after loading the view from its nib.
}


-(void)webView:(WKWebView *)webView didReceiveAuthenticationChallenge:(nonnull NSURLAuthenticationChallenge *)challenge completionHandler:(nonnull void (^)(NSURLSessionAuthChallengeDisposition, NSURLCredential * _Nullable))completionHandler{

ZJlogFunction

    if ([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust]) {

        NSURLCredential *card = [[NSURLCredential alloc]initWithTrust:challenge.protectionSpace.serverTrust];

        completionHandler(NSURLSessionAuthChallengeUseCredential,card);

    }

    return;

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
#pragma mark - WKNavigationDelegate
// 页面开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
ZJlogFunction
}
// 当内容开始返回时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation{
ZJlogFunction
}
// 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
ZJlogFunction
}
// 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation{
ZJlogFunction
}
// 接收到服务器跳转请求之后调用
- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation{
    
ZJlogFunction
}
// 在收到响应后，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler{
ZJlogFunction
    NSLog(@"%@",navigationResponse.response.URL.absoluteString);
    //允许跳转
    decisionHandler(WKNavigationResponsePolicyAllow);
    //不允许跳转
    //decisionHandler(WKNavigationResponsePolicyCancel);
}
// 在发送请求之前，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
ZJlogFunction
    NSString *url = navigationAction.request.URL.absoluteString;
    NSLog(@"%@",navigationAction.request.URL.absoluteString);
    if ([url hasPrefix:@"targetimg:"]) {

    }
    if ([url hasPrefix:@"insidebrowser:"]) {
        decisionHandler(WKNavigationActionPolicyCancel);
        return;
    }
    //允许跳转
    decisionHandler(WKNavigationActionPolicyAllow);
    //不允许跳转
//    decisionHandler(WKNavigationActionPolicyCancel);
}
#pragma mark - WKUIDelegate
// 创建一个新的WebView
- (WKWebView *)webView:(WKWebView *)webView createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration forNavigationAction:(WKNavigationAction *)navigationAction windowFeatures:(WKWindowFeatures *)windowFeatures{
    ZJlogFunction
    return [[WKWebView alloc]init];
}
// 输入框
- (void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(nullable NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString * __nullable result))completionHandler{
    ZJlogFunction
    completionHandler(@"http");
}
// 确认框
- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL result))completionHandler{
    ZJlogFunction
    completionHandler(YES);
}
// 警告框
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler{
    NSLog(@"%@",message);
    ZJlogFunction
    completionHandler();
}


@end
