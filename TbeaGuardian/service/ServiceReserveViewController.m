//
//  ServiceReserveViewController.m
//  TbeaGuardian
//
//  Created by xyy on 2017/9/8.
//  Copyright © 2017年 xyy. All rights reserved.
//

#import "ServiceReserveViewController.h"

@interface ServiceReserveViewController ()

@end

@implementation ServiceReserveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)])
    {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    
//    UIView *contentViewright = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 64, 44)];
//    UIButton *buttonright = [[UIButton alloc] initWithFrame:contentViewright.bounds];
//    [buttonright setTitle:@"发布任务" forState:UIControlStateNormal];
//    buttonright.titleLabel.font = FONTN(15.0f);
//    [buttonright setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [buttonright addTarget:self action: @selector(clicksendtask:) forControlEvents: UIControlEventTouchUpInside];
//    [contentViewright addSubview:buttonright];
//    buttonright.imageEdgeInsets = UIEdgeInsetsMake(0,0, 0, -20);
//    UIBarButtonItem *barButtonItemright = [[UIBarButtonItem alloc] initWithCustomView:contentViewright];
//    self.navigationItem.rightBarButtonItem = barButtonItemright;
    // Do any additional setup after loading the view.
}

-(void)initview
{
    self.view.backgroundColor  = [UIColor whiteColor];
    app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    UIView *viewtop = [self viewtopicon:CGRectMake(0, 0, SCREEN_WIDTH, 220)];
    [self.view addSubview:viewtop];
    
    UIView *viewbottom = [self viewdescript:CGRectMake(0, 280, SCREEN_WIDTH, 360)];
    [self.view addSubview:viewbottom];
    
    
    UIButton *buttonright = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-60-20, StatusBarHeight, 64, 44)];
    [buttonright setTitle:@"发布任务" forState:UIControlStateNormal];
    buttonright.titleLabel.font = FONTN(15.0f);
    [buttonright setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [buttonright addTarget:self action: @selector(clicksendtask:) forControlEvents: UIControlEventTouchUpInside];
    [self.view addSubview:buttonright];
    [self getupdateversion];
    
    [self getURLPrefix];
}

-(UIView *)viewtopicon:(CGRect)frame
{
    UIView *viewblue = [[UIView alloc] initWithFrame:frame];
    viewblue.backgroundColor = COLORNOW(0, 170, 238);
    
    UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-195)/2, 50, 195, 132)];
    imageview.image = LOADIMAGE(@"预约top", @"png");
    [viewblue addSubview:imageview];
    return viewblue;
}

-(UIView *)viewtips:(CGRect)frame
{
    UIView *viewmid = [[UIView alloc] initWithFrame:frame];
    viewmid.backgroundColor = [UIColor whiteColor];
    NSDictionary *dicmessage;
    if([FCsystemmessagelistt count]>0)
        dicmessage = [FCsystemmessagelistt objectAtIndex:0];
    
    UIImageView *imageline = [AddCustomView CusViewLine:CGRectMake(0,XYViewHeight(viewmid)-10, SCREEN_WIDTH, 10) BGColor:COLORNOW(235, 235, 235)];
    [viewmid addSubview:imageline];
    
    UIImageView *imageview = [AddCustomView CusViewImageViewForRadius:CGRectMake(20, 15, 20, 20) Image:LOADIMAGE(@"testpic", @"png") FRadius:15.0f];
    [imageview setImageWithURL:[NSURL URLWithString:[dicmessage objectForKey:@"icon"]] placeholderImage:LOADIMAGE(@"testpic", @"png")];
    imageline.contentMode = UIViewContentModeScaleToFill;
    [viewmid addSubview:imageview];
    
    
    UILabel *labins = [AddCustomView CusViewLabelForStyle:CGRectMake(XYViewR(imageview)+10, XYViewTop(imageview)+5, SCREEN_WIDTH-80, 20) BGColor:[UIColor clearColor] Title:[dicmessage objectForKey:@"title"] TColor:COLORNOW(72, 72, 72) Font:FONTN(14.0f) LineNumber:1];
    [viewmid addSubview:labins];
    
    return viewmid;
}

-(UIView *)viewdescript:(CGRect)frame
{
    UIView *viewbottom = [[UIView alloc] initWithFrame:frame];
    viewbottom.backgroundColor = [UIColor whiteColor];
    
    UIImageView *imageviewicon = [AddCustomView CusViewImageView:CGRectMake(20, 10, 20, 20) Image:LOADIMAGE(@"service_说明", @"png")];
    [viewbottom addSubview:imageviewicon];
    
    [viewbottom addSubview:[AddCustomView CusViewLabelForStyle:CGRectMake(XYViewR(imageviewicon)+10, 10, 100, 20) BGColor:[UIColor clearColor] Title:@"说明" TColor:[UIColor blackColor] Font:FONTN(15.0f) LineNumber:1]];
    
    UIImageView *imageline = [AddCustomView CusViewLine:CGRectMake(0, 40, SCREEN_WIDTH, 1) BGColor:COLORNOW(240, 240, 240)];
    [viewbottom addSubview:imageline];
    
    CGSize size = [AddInterface getlablesize:@"【免费服务】凡在正规渠道购买的特变电工相关产品并索取服务凭证后都可享受免费上门专业检测服务。" Fwidth: SCREEN_WIDTH-40 Fheight:80 Sfont:FONTN(15.0f)];
    UILabel *label1 = [AddCustomView CusViewLabelForStyle:CGRectMake(XYViewL(imageviewicon), XYViewBottom(imageline)+10, SCREEN_WIDTH-40, size.height) BGColor:[UIColor clearColor] Title:@"【免费服务】凡在正规渠道购买的特变电工相关产品并索取服务凭证后都可享受免费上门专业检测服务。" TColor:[UIColor blackColor] Font:FONTN(15.0f) LineNumber:0];
    [viewbottom addSubview:label1];
    
    CGSize size1 = [AddInterface getlablesize:@"【付费服务】您可以发布线路维修、改造任务，设定您的预算费用，等待您附近水电工报价接单。" Fwidth: SCREEN_WIDTH-40 Fheight:80 Sfont:FONTN(15.0f)];
    UILabel *label2 = [AddCustomView CusViewLabelForStyle:CGRectMake(XYViewL(label1), XYViewBottom(label1)+10, SCREEN_WIDTH-40, size1.height) BGColor:[UIColor clearColor] Title:@"【付费服务】您可以发布线路维修、改造任务，设定您的预算费用，等待您附近水电工报价接单。" TColor:[UIColor blackColor] Font:FONTN(15.0f) LineNumber:0];
    [viewbottom addSubview:label2];
    
    UIButton *button = [AddCustomView CusViewButtonForRadius:CGRectMake(20, XYViewBottom(label2)+30, SCREEN_WIDTH-40, 40) BGColor:COLORNOW(0, 170, 238) Title:@"免费检测预约" TitleColor:[UIColor whiteColor] FRadius:3.0f];
    [button addTarget:self action:@selector(clickdetectapply:) forControlEvents:UIControlEventTouchUpInside];
    [viewbottom addSubview:button];
    return viewbottom;
}

-(void)loginview
{
    LoginPageViewController *login = [[LoginPageViewController alloc] init];
    login.delegate1 = self;
    UINavigationController *nctl = [[UINavigationController alloc] initWithRootViewController:login];
    [self.navigationController presentViewController:nctl animated:NO completion:nil];
}

#pragma mark IBAction
-(void)clickdetectapply:(id)sender
{
    DetectApplyNewViewController *dect = [[DetectApplyNewViewController alloc] init];
    dect.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:dect animated:YES];
}

-(void)clicksendtask:(id)sender
{
    TaskSendNewViewController *tasknew = [[TaskSendNewViewController alloc] init];
    tasknew.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:tasknew animated:YES];
}

#pragma mark ActionDelegate
-(void)DGLoginSuccess:(id)sender
{
    [self initview];
}

#pragma mark UIviewcontrollerdelegate
-(void)viewWillAppear:(BOOL)animated
{
    if(![AddInterface judgeislogin])
        [self loginview];
    else
    {
        [self gethppage];
        [self initview];
    }
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    [[self.navigationController.navigationBar viewWithTag:EnHpNavigationViewTag] removeFromSuperview];
    self.navigationController.navigationBar.translucent = NO;
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    [self.navigationController.navigationBar setBarTintColor:COLORNOW(0, 170, 238)];
    UIColor* color = [UIColor whiteColor];
    NSDictionary* dict=[NSDictionary dictionaryWithObject:color forKey:NSForegroundColorAttributeName];
    self.navigationController.navigationBar.titleTextAttributes= dict;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark接口
//获取url前缀
-(void)getURLPrefix
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"terminaltype"] = @"ios";
    
    [RequestInterface doGetJsonWithParametersNoAn:params App:app RequestCode:RQGetURLHeaderFrontCode ReqUrl:InterfaceRequestUrl ShowView:app.window alwaysdo:^{
        
    } Success:^(NSDictionary *dic) {
        DLog(@"dic====%@",dic);
        if([[dic objectForKey:@"success"] isEqualToString:@"true"])
        {
            app.GBURLPreFix = [[dic objectForKey:@"data"] objectForKey:@"url"];
        }
        else
        {
            [MBProgressHUD showError:[dic objectForKey:@"msg"] toView:app.window];
        }
    } Failur:^(NSString *strmsg) {
        [MBProgressHUD showError:@"请求失败,请检查网络" toView:self.view];
        
    }];
}



-(void)getupdateversion
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"terminaltype"] = @"ios";
    
    [RequestInterface doGetJsonWithParametersNoAn:params App:app RequestCode:RQUpdateNewVersionCode ReqUrl:InterfaceRequestUrl ShowView:app.window alwaysdo:^{
        
    } Success:^(NSDictionary *dic) {
        DLog(@"dic====%@",dic);
        if([[dic objectForKey:@"success"] isEqualToString:@"true"])
        {
            NSDictionary *versioninfo = [[dic objectForKey:@"data"] objectForKey:@"versioninfo"];
            NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary];
            NSString *currentVersion = [infoDic objectForKey:@"CFBundleVersion"];
            NSString *serversion = [NSString stringWithFormat:@"%@",[versioninfo objectForKey:@"versionname"]];
            NSString *verswitch = [NSString stringWithFormat:@"%@",[versioninfo objectForKey:@"tipswitch"]];
            NSString *jumpurl = [NSString stringWithFormat:@"%@",[versioninfo objectForKey:@"jumpurl"]];
            NSString *mustupgrade = [versioninfo objectForKey:@"mustupgrade"];
            if([verswitch isEqualToString:@"off"])
            {
                return ;
            }
            else if([serversion isEqualToString:@"0.0"])
            {
                return ;
            }
            else if([jumpurl length]==0)
            {
                return ;
            }
            else if([mustupgrade isEqualToString:@"YES"])
            {
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"有新版本,你确定要更新吗？" message:nil preferredStyle:UIAlertControllerStyleAlert];
                
                UIAlertAction *otherAction = [UIAlertAction actionWithTitle:@"现在更新" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                    
                    NSString *postUrl = jumpurl;
                    
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:postUrl] options:@{} completionHandler:nil];
               //     [[UIApplication sharedApplication] openURL:[NSURL URLWithString:postUrl]];
                    DLog(@"posturl===%@",postUrl);
                    
                }];
                
                // Add the actions.
                [alertController addAction:otherAction];
                
                [self presentViewController:alertController animated:YES completion:nil];
            }
            else if(![serversion isEqualToString:currentVersion])
            {
                
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"有新版本,你确定要更新吗？" message:nil preferredStyle:UIAlertControllerStyleAlert];
                
                UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"稍后再更新" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
                    
                }];
                
                UIAlertAction *otherAction = [UIAlertAction actionWithTitle:@"现在更新" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                    
                    NSString *postUrl = jumpurl;
                   [[UIApplication sharedApplication] openURL:[NSURL URLWithString:postUrl] options:@{} completionHandler:nil];
                    DLog(@"posturl===%@",postUrl);
                    
                }];
                
                // Add the actions.
                [alertController addAction:cancelAction];
                [alertController addAction:otherAction];
                
                [self presentViewController:alertController animated:YES completion:nil];
                
            }
        }
        else
        {
            [MBProgressHUD showError:[dic objectForKey:@"msg"] toView:app.window];
        }
    } Failur:^(NSString *strmsg) {
        [MBProgressHUD showError:@"请求失败,请检查网络" toView:self.view];
        
    }];
}


-(void)gethppage
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    [RequestInterface doGetJsonWithParametersNoAn:params App:app RequestCode:RQReserverServiceHpCode ReqUrl:InterfaceRequestUrl ShowView:app.window alwaysdo:^{
        
    } Success:^(NSDictionary *dic) {
        DLog(@"dic====%@",dic);
        if([[dic objectForKey:@"success"] isEqualToString:@"true"])
        {
            FCsystemmessagelistt = [[dic objectForKey:@"data"] objectForKey:@"systemmessagelist"];
            [FCviewmiddle removeFromSuperview];
            FCviewmiddle = [self viewtips:CGRectMake(0, 220, SCREEN_WIDTH, 60)];
            [self.view addSubview:FCviewmiddle];
        }
        else
        {
            [MBProgressHUD showError:[dic objectForKey:@"msg"] toView:app.window];
        }
    } Failur:^(NSString *strmsg) {
        [MBProgressHUD showError:@"请求失败,请检查网络" toView:self.view];
        
    }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
