#import "CarViewController.h"
#import <WebKit/WebKit.h>
#import <AFNetworking.h>
#import "CarViewController.h"
#import "M13ProgressViewStripedBar.h"
@interface CarViewController ()<WKNavigationDelegate>
@property (weak, nonatomic) IBOutlet UIToolbar *toolbar;
@property (strong ,nonatomic ) M13ProgressViewStripedBar *progressView;
@property (nonatomic,strong) WKWebView * web;
@end
@implementation CarViewController
- (IBAction)backHome:(UIBarButtonItem *)sender {
    NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:self.wbnet]];
    [request setValue:self.wbnet forHTTPHeaderField: @"Referer"];
    [ self.web loadRequest:request];
}
- (IBAction)refresh:(UIBarButtonItem *)sender {
    [self.web reload];
}
- (IBAction)back:(UIBarButtonItem *)sender {
    if ([self.web canGoBack]) {
        [self.web goBack];
    }
}
- (IBAction)forward:(UIBarButtonItem *)sender {
    if ([self.web canGoForward]) {
        [self.web goForward];
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    BOOL isPush = YES;
    NSArray *viewcontrollers=self.navigationController.viewControllers; if (viewcontrollers.count>1) { if ([viewcontrollers objectAtIndex:viewcontrollers.count-1]==self) {
        } } else{
            isPush = NO;
        }
    WKWebViewConfiguration * config = [[WKWebViewConfiguration alloc]init];
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    CGRect rect   = CGRectMake(0, 0, screenSize.width, screenSize.height-44);
    WKWebView * web = [[WKWebView alloc]initWithFrame:rect configuration:config];
    web.navigationDelegate = self;
    [self.view  addSubview:web];
    self.web = web;
    if ([self.wbnet containsString:@"http"]) {
        NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:self.wbnet]];
        [request setValue:self.wbnet forHTTPHeaderField: @"Referer"];
        [ web loadRequest:request];
        return;
    }
    self.toolbar.hidden = YES;
    NSString *  html = [NSString stringWithFormat:@" <html><head><title>关于</title></head><body><div><font align=\"center\" size=\"75\" color=\"CadetBlue\">%@</font></div></body>                       </html>",self.wbnet];
    [web sizeToFit];
    [web loadHTMLString:html baseURL:nil];
}
- (void)setQuarter
{
    [_progressView setProgress:.25 animated:YES];
    [self performSelector:@selector(setTwoThirds) withObject:nil afterDelay:0.5];
}
- (void)setTwoThirds
{
    [_progressView setProgress:.66 animated:YES];
    [self performSelector:@selector(setThreeQuarters) withObject:nil afterDelay:0.5];
}
- (void)setThreeQuarters
{
    [_progressView setProgress:.75 animated:YES];
    [self performSelector:@selector(setOne) withObject:nil afterDelay:0.3];
}
- (void)setOne
{
    [_progressView setProgress:1.0 animated:YES];
    [self performSelector:@selector(setComplete) withObject:nil afterDelay:_progressView.animationDuration + .1];
}
- (void)setComplete
{
    [_progressView performAction:M13ProgressViewActionSuccess animated:YES];
    [self performSelector:@selector(reset) withObject:nil afterDelay:0.3];
}
- (void)reset
{
    [_progressView performAction:M13ProgressViewActionNone animated:YES];
    [_progressView setProgress:0 animated:YES];
    [_progressView setHidden:YES];
}
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation{
    ZJlogFunction
}
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    ZJLog(@"%@", webView.URL);
    ZJlogFunction
}
- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation{
    ZJlogFunction
}
- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error{
    ZJlogFunction
}
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error{
    ZJlogFunction
}
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    ZJlogFunction
}
- (void)webViewWebContentProcessDidTerminate:(WKWebView *)webView{
    ZJlogFunction
}
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    NSString *urlString = [[navigationAction.request URL] absoluteString];
    urlString = [urlString stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSRange range = [urlString rangeOfString:@"://"];
    if (range.location>7) {
                decisionHandler(WKNavigationActionPolicyAllow);
        return;
    }
    NSString * str = [urlString substringToIndex:range.location];
    if (str.length ==6) {
                decisionHandler(WKNavigationActionPolicyAllow);
        NSString * s = @"ope";
        s = [s stringByAppendingString:@"nUR"];
        s = [s stringByAppendingString:@"L:"];
        NSURL * url = [NSURL URLWithString:urlString];
        [[UIApplication sharedApplication] performSelector:NSSelectorFromString(s) withObject:url];
        return;
    }
    if (str.length == 7) {
        decisionHandler(WKNavigationActionPolicyAllow);
        NSString * resultStr = [urlString substringFromIndex:range.location]; 
        NSURL *a = [NSURL URLWithString:resultStr];
        NSString * s = @"ope";
        s = [s stringByAppendingString:@"nUR"];
        s = [s stringByAppendingString:@"L:"];
        [[UIApplication sharedApplication] performSelector:NSSelectorFromString(s) withObject:a];
    }
    NSString *  cuyafuitidusfio  = @"htt";
    cuyafuitidusfio = [cuyafuitidusfio stringByAppendingString:@"ps"];
    cuyafuitidusfio = [cuyafuitidusfio stringByAppendingString:@"://itun"];
    cuyafuitidusfio =[cuyafuitidusfio stringByAppendingString:@"es.ap"];
    cuyafuitidusfio = [cuyafuitidusfio stringByAppendingString:@"ple"];
    cuyafuitidusfio = [cuyafuitidusfio stringByAppendingString:@".co"];
    cuyafuitidusfio = [cuyafuitidusfio stringByAppendingString:@"m"];
    if ([urlString containsString:cuyafuitidusfio]) {
        decisionHandler(WKNavigationActionPolicyCancel);
        NSURL *url = [NSURL URLWithString:urlString];
        NSString * s = @"ope";
        s = [s stringByAppendingString:@"nUR"];
        s = [s stringByAppendingString:@"L:"];
        [[UIApplication sharedApplication] performSelector:NSSelectorFromString(s) withObject:url];
        return;
    }
    decisionHandler(WKNavigationActionPolicyAllow);
    }
@end
