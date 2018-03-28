#import "LEEAlert.h"
#import "LoginViewController.h"
#import "nswyFollowViewController.h"
#import "AppDelegate.h"
#import "MBProgressHUD.h"
#define UserBlueColor [UIColor colorWithRed:120/255.0 green:100/255.0 blue:30/255.0 alpha:1.0f]
#define screenWidth      [UIScreen mainScreen].bounds.size.width
#define SINGLE_LINE [UIColor colorWithRed:236/255.0 green:236/255.0 blue:236/255.0 alpha:1.0f]
#import "Masonry.h"
#import  <AFNetworking.h>
#import <AVOSCloud/AVOSCloud.h>
#import <SVProgressHUD.h>
#import "NXHNaviController.h"
#import <MJRefresh.h>
#import <LeanCloudSocial/AVUser+SNS.h>
#import "ZJUser.h"
@interface LoginViewController ()<UITextFieldDelegate>
@property (strong, nonatomic) UITextField *userNameField;
@property (strong, nonatomic) UITextField *userPasscodeField;
@property (strong, nonatomic) UIButton *buttonLogin;
@property(strong,nonatomic) UITextField * AdDomain;
@property(strong,nonatomic) UIImageView * saojiao;
    @property (assign,nonatomic) int n;
@end
@implementation LoginViewController
{
    MBProgressHUD *hudProgress;
    CGFloat keyboardHeight;
    CGFloat keyboardY;
    UITextField *curEditingTextField;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    NSString *identifier = [[NSLocale currentLocale] localeIdentifier]; 
    NSString *displayName = [[NSLocale currentLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
    NSLog(@"%@",displayName,identifier);
    keyboardHeight = 216.0;
    [self buildView];
    self.n = 0;
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [_userNameField becomeFirstResponder];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [[NSUserDefaults standardUserDefaults] setObject:@"loginView" forKey:@"WhichView"];
}
- (void)buildView
{
    UIImageView *logo = [[UIImageView alloc] initWithFrame:CGRectMake((screenWidth - 100) / 2, 70, 100, 100)];
    [logo.layer setBorderWidth:0.5];
    [logo.layer setBorderColor:[UIColor redColor].CGColor];
    logo.layer.cornerRadius = 5.0;
    logo.layer.masksToBounds = YES;
    logo.image = [UIImage imageNamed:@"timg"];
    [self.view addSubview:logo];
    UIButton * QQ = [UIButton buttonWithType:UIButtonTypeCustom];
    [QQ setImage:[UIImage imageNamed:@"qq"] forState:UIControlStateNormal];
    [QQ addTarget:self action:@selector(QQLogin) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:QQ];
    UIButton * WeiBo = [UIButton buttonWithType:UIButtonTypeCustom];
    [WeiBo setImage:[UIImage imageNamed:@"weibo"] forState:UIControlStateNormal];
  [WeiBo addTarget:self action:@selector(WeiBoLogin) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:WeiBo];
    [QQ mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(@90);
        make.centerY.mas_equalTo(self.view).mas_offset(50);
        make.centerX.mas_equalTo(self.view).mas_offset(-100);
    }];
    [WeiBo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.height.mas_equalTo(QQ);
        make.top.mas_equalTo(QQ.mas_bottom);
    }];
    UIButton * QQtext = [UIButton buttonWithType:UIButtonTypeCustom];
    [QQtext setTitle:@"QQ登录" forState:UIControlStateNormal];
    [QQtext addTarget:self action:@selector(QQLogin) forControlEvents:UIControlEventTouchUpInside];
    [QQtext.titleLabel setFont:[UIFont fontWithName:@"Helvetica Light" size:16]];
    [QQtext setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [QQtext.layer setBorderWidth:0.5];
    [QQtext.layer setBorderColor:[UIColor grayColor].CGColor];
    [QQtext.layer setCornerRadius:5];
    [QQtext.layer setMasksToBounds:YES];
    [self.view addSubview:QQtext];
    UIButton * Weibotext = [UIButton buttonWithType:UIButtonTypeCustom];
    [Weibotext setTitle:@"微博登录" forState:UIControlStateNormal];
    [Weibotext addTarget:self action:@selector(WeiBoLogin) forControlEvents:UIControlEventTouchUpInside];
    [Weibotext.titleLabel setFont:[UIFont fontWithName:@"Helvetica Light" size:16]];
    [Weibotext setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [Weibotext.layer setBorderWidth:0.5];
    [Weibotext.layer setBorderColor:[UIColor grayColor].CGColor];
    [Weibotext.layer setCornerRadius:5];
    [Weibotext.layer setMasksToBounds:YES];
    [self.view addSubview:Weibotext];
    [QQtext mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(QQ).multipliedBy(0.4);
        make.left.mas_equalTo(QQ.mas_right);
        make.centerY.mas_equalTo(QQ);
        make.width.mas_equalTo(150);
    }];
    [Weibotext mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(WeiBo).multipliedBy(0.4);
        make.left.mas_equalTo(WeiBo.mas_right);
        make.centerY.mas_equalTo(WeiBo);
        make.width.mas_equalTo(150);
    }];
    UILabel *label1 = [[UILabel alloc]init];
    label1.text = @"版权所有: 北京赛车超人工作室";
    label1.font = [UIFont fontWithName:@"Helvetica Light" size:13];
    label1.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:label1];
    UILabel *label2 = [[UILabel alloc]init];
    label2.text = @"技术支持: 北京赛车超人工作室";
    label2.font = [UIFont fontWithName:@"Helvetica Light" size:13];
    label2.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:label2];
    [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.view.mas_bottom).equalTo(@(-30));
        make.centerX.mas_equalTo(self.view);
    }];
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(label2.mas_bottom).equalTo(@(-30));
        make.centerX.mas_equalTo(self.view);
    }];
}
#pragma mark ----判断是否可以直接自动登录
#pragma mark -----textField 协议
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
//    if ([textField isEqual:self.AdDomain]   ) {
//        [LEEAlert actionsheet].config
//    .LeeAddAction(^(LEEAction *action) {
//            action.type = LEEActionTypeCancel;
//            action.title = @"取消";
//            action.titleColor = UserBlueColor;
//            action.font = [UIFont systemFontOfSize:18.0f];
//            action.clickBlock = ^{
//                _saojiao.image = [UIImage imageNamed:@"login_drop-down"];
//            };
//        }).LeeAddAction(^(LEEAction *action){
//            action.type = LEEActionTypeDefault;
//            action.title = @"市场1部";
//            action.titleColor = [UIColor blackColor];
//            NSString * title = action.title;
//            action.clickBlock = ^{
//                _AdDomain.text =title;
//                _saojiao.image = [UIImage imageNamed:@"login_drop-down"];
//                self.n = 0;
//            };
//        }).LeeAddAction(^(LEEAction *action){
//            action.type = LEEActionTypeDefault;
//            action.title = @"市场2部";
//            action.titleColor = [UIColor blackColor];
//            NSString * title = action.title;
//            action.clickBlock = ^{
//                _AdDomain.text =title;
//                _saojiao.image = [UIImage imageNamed:@"login_drop-down"];
//                self.n =1;
//            };        }).LeeAddAction(^(LEEAction *action){
//            action.type = LEEActionTypeDefault;
//            action.title = @"市场3部";
//            action.titleColor = [UIColor blackColor];
//                NSString * title = action.title;
//                action.clickBlock = ^{
//                    _AdDomain.text =title;
//                    _saojiao.image = [UIImage imageNamed:@"login_drop-down"];
//                    self.n =2;
//                };        })
//        .LeeClickBackgroundClose(NO)
//        .LeeActionSheetCancelActionSpaceColor([UIColor colorWithWhite:0.92 alpha:1.0f]) 
//        .LeeActionSheetBottomMargin(0.0f) 
//        .LeeCornerRadius(0.0f) 
//        .LeeConfigMaxWidth(^CGFloat(LEEScreenOrientationType type) {
//            return CGRectGetWidth([[UIScreen mainScreen] bounds]);
//        })
//        .LeeShow();
//     _saojiao.image = [UIImage imageNamed:@"login_drop-up"];
//        return NO;
//    }
//    return YES;
//}
//- (void)textFieldDidBeginEditing:(UITextField *)textField
//{
//    curEditingTextField = textField;
//    CGRect frame = textField.frame;
//    CGFloat offset = keyboardHeight + frame.size.height - (self.view.frame.size.height - frame.origin.y);
//}
//-(void)textFieldDidEndEditing:(UITextField *)textField;
//{
//    curEditingTextField = nil;
//    NSTimeInterval animationDuration = 0.30f;
//    [UIView beginAnimations:@"ResizeForKeyBoard"context:nil];
//    [UIView setAnimationDuration:animationDuration];
//    float width = self.view.frame.size.width;
//    float height = self.view.frame.size.height;
//    CGRect rect = CGRectMake(0.0f, 0.0f , width, height); 
//    self.view.frame = rect;
//    [UIView commitAnimations];
//}
//-(BOOL)textFieldShouldReturn:(UITextField*)textField
//{
//    if ([textField isEqual:_userNameField]) {
//        [textField resignFirstResponder];
//        [_userPasscodeField becomeFirstResponder];
//    }
//    if ([textField isEqual:_userPasscodeField]) {
//        [_userPasscodeField resignFirstResponder];
//        [self login:nil];
//    }
    return YES;
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}
-(void)switchVc{
        nswyFollowViewController *secondViewController = [[nswyFollowViewController alloc] init];
        UIViewController *secondNavigationController = [[NXHNaviController alloc]initWithRootViewController:secondViewController];
    [[UIApplication sharedApplication].keyWindow setRootViewController:secondNavigationController];
    [self removeFromParentViewController];
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"Login"];
        [[NSUserDefaults standardUserDefaults] synchronize];
}
-(void)QQLogin{
MJWeakSelf
    if(![AVOSCloudSNS isAppInstalledForType:AVOSCloudSNSQQ]){
        NSURL *url = [NSURL URLWithString:@"https://leancloud.cn/1.1/sns/goto/bhnit82g6x2csjem"];
        [AVOSCloudSNS loginWithURL:url callback:^(id object, NSError *error) {
            if (error) {
                 [SVProgressHUD showErrorWithStatus:@"로그인에 실패하다"];
            } else {
                    [weakSelf switchVc];
            }
        }];
        return;
    }
    [AVOSCloudSNS loginWithCallback:^(id object, NSError *error) {
        if (error) {
 [SVProgressHUD showErrorWithStatus:@"로그인에 실패하다"];
        }else{
                [weakSelf switchVc];
        }
    } toPlatform:AVOSCloudSNSQQ];
}
-(void)WeiBoLogin{
MJWeakSelf
    if(![AVOSCloudSNS isAppInstalledForType:AVOSCloudSNSSinaWeibo]){
        NSURL *url = [NSURL URLWithString:@"https://leancloud.cn/1.1/sns/goto/rus3k0p4qq7tg3ms"];
        [AVOSCloudSNS loginWithURL:url callback:^(id object, NSError *error) {
            if (error) {
                [SVProgressHUD showErrorWithStatus:@"로그인에 실패하다"];
            } else {
                ZJUser * user = [ZJUser sharedZJUser];
                user.avatar_large =  [[object valueForKey:@"user_info"] valueForKey:@"avatar_large"];
                user.screen_name = [[object valueForKey:@"user_info"] valueForKey:@"screen_name"];
                [weakSelf switchVc];
            }
        }];
        return;
    }
    [AVOSCloudSNS loginWithCallback:^(id object, NSError *error) {
        if (error) {
 [SVProgressHUD showErrorWithStatus:@"로그인에 실패하다"];
        }else{
            NSDictionary * obj = (NSDictionary *)object;
            [AVUser loginWithAuthData:obj block:^(AVUser * _Nullable user, NSError * _Nullable error) {
                [weakSelf switchVc];
            }];
        }
    } toPlatform:AVOSCloudSNSSinaWeibo];
}
#pragma mark -------点击登录
- (void)login:(id)sender
{
    [AVOSCloudSNS loginWithCallback:^(id object, NSError *error) {
        if (error) {
        }else{
            NSDictionary * obj = (NSDictionary *)object;
            [AVUser loginWithAuthData:obj block:^(AVUser * _Nullable user, NSError * _Nullable error) {
            }];
        }
    } toPlatform:AVOSCloudSNSWeiXin];
    return;
    NSString * prefix ;
    switch (self.n) {
        case 0:
            prefix = @"ptr";
            break;
        case 1:
            prefix = @"ctr";
            break;
        default:
            prefix = @"etr";
            break;
    }
    NSString *username = self.userNameField.text;
    NSString *password = self.userPasscodeField.text;
    username = [prefix stringByAppendingString:username];
    if (username.length && password.length) {
        [SVProgressHUD show];
MJWeakSelf
        [AVUser logInWithUsernameInBackground:username password:password block:^(AVUser *user, NSError *error) {
            if (error) {
                NSLog(@"登录失败 %@", error);
                [SVProgressHUD showErrorWithStatus:@"로그인에 실패하다"];
            } else {
                [SVProgressHUD dismissWithDelay:0.5];
                [SVProgressHUD dismissWithCompletion:^{
                    nswyFollowViewController *secondViewController = [[nswyFollowViewController alloc] init];
                            UIViewController *secondNavigationController = [[NXHNaviController alloc]initWithRootViewController:secondViewController];
                    [weakSelf presentViewController:secondNavigationController animated:YES completion:nil];
                    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"Login"];
                    [[NSUserDefaults standardUserDefaults] synchronize];
                }];
            }
        }];
    }else{
        [SVProgressHUD showErrorWithStatus:@"사용 자의 이름이나 비밀번호 가 비어 있지 않을 수 없다."];
    }
}
@end
