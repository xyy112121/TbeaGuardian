//
//  NearByWaterElecPersonViewController.m
//  TbeaGuardian
//
//  Created by xyy on 2017/10/9.
//  Copyright © 2017年 xyy. All rights reserved.
//

#import "NearByWaterElecPersonViewController.h"

@interface NearByWaterElecPersonViewController ()

@end

@implementation NearByWaterElecPersonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)])
    {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    [self initview];
    
//    UILabel *labelbg = [AddCustomView CusViewLabel:CGRectMake(0, 0, SCREEN_WIDTH, StatusHeight+44) BGColor:COLORNOW(0, 170, 238)];
//    [self.view addSubview:labelbg];
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(20, StatusHeight+2, 40, 40)];
    [button setImage:LOADIMAGE(@"returnback", @"png") forState:UIControlStateNormal];
    [button addTarget:self action: @selector(returnback) forControlEvents: UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    
    
    
    // Do any additional setup after loading the view.
}

#pragma mark 页面布局
-(void)initview
{
    self.view.backgroundColor = [UIColor whiteColor];
    app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    [self getwateruserhome];
}

-(void)addtabviewheader
{
    NearByWaterPersonHeaderView *waterheader = [[NearByWaterPersonHeaderView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 240) DicFrom:FCdicdata];
    waterheader.delegate1 = self;
    [self.view insertSubview:waterheader atIndex:0];
}

-(void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

#pragma mark ActionDelegate
-(void)DGCLickWaterPersonHeader:(id)sender
{
    NearByWaterPersonInfoViewController *storedetail = [[NearByWaterPersonInfoViewController alloc] init];
    storedetail.FCelectricianid = _FCelectricianid;
    [self.navigationController pushViewController:storedetail animated:YES];
}

#pragma mark IBaction
-(void)gotopersonmanger:(id)sender
{
//    WaterPersonHpViewController *waterperson = [[WaterPersonHpViewController alloc] init];
//    waterperson.FCelectricianid = self.FCelectricianid;
//    [self.navigationController pushViewController:waterperson animated:YES];
}

-(void)returnback
{
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark 接口
-(void)getwateruserhome
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"electricianid"]= self.FCelectricianid;
    [RequestInterface doGetJsonWithParametersNoAn:params App:app RequestCode:RQWaterElecPersonInfo ReqUrl:InterfaceRequestUrl ShowView:app.window alwaysdo:^{

    } Success:^(NSDictionary *dic) {
        DLog(@"dic====%@",dic);
        if([[dic objectForKey:@"success"] isEqualToString:@"true"])
        {
            FCdicdata = [dic objectForKey:@"data"];
            [self addtabviewheader];
//
//            NSString *strurlnow = [NSString stringWithFormat:@"%@%@",Interfacehtmlurlheader,HtmlUrlUserPersoninfo];
//            UIView  *view = [[WkWebViewCustomView alloc] initWithFrame:CGRectMake(0, 240, SCREEN_WIDTH, SCREEN_WIDTH-240) StrUrl:strurlnow];
//            [self.view addSubview:view];

        }
        else
        {
            [MBProgressHUD showError:[dic objectForKey:@"msg"] toView:app.window];
        }
    } Failur:^(NSString *strmsg) {
        [MBProgressHUD showError:@"请求失败,请检查网络" toView:self.view];

    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
