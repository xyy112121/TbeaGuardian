//
//  MyWiringDiagramViewController.m
//  TbeaGuardian
//
//  Created by xyy on 2017/9/18.
//  Copyright © 2017年 xyy. All rights reserved.
//

#import "MyWiringDiagramViewController.h"

@interface MyWiringDiagramViewController ()

@end

@implementation MyWiringDiagramViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)])
    {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(2, 2, 60, 40)];
    UIButton *button = [[UIButton alloc] initWithFrame:contentView.bounds];
    button.layer.borderColor = [UIColor clearColor].CGColor;
    [button setImage:LOADIMAGE(@"returnback", @"png") forState:UIControlStateNormal];
    button.imageEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
    [button addTarget:self action: @selector(returnback) forControlEvents: UIControlEventTouchUpInside];
    [contentView addSubview:button];
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:contentView];
    self.navigationItem.leftBarButtonItem = barButtonItem;
    
    [self initview];
    
    // Do any additional setup after loading the view.
}

-(void)initview
{
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"全部图片";
    
    imageviewno = [[UIImageView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-60)/2, (SCREEN_HEIGHT-89-64)/2, 60, 89)];
    imageviewno.image = LOADIMAGE(@"暂无图片", @"png");
    imageviewno.alpha = 0;
    [self.view addSubview:imageviewno];
}

-(void)picarrment
{
    float rithgleftspace = 20; //左右间隔
    float picspace = 10;
    float widthnow = (SCREEN_WIDTH-rithgleftspace*2-picspace*3)/4;
    int counth = 0;
    int countv = 0;
    int countspecifi = (int)[FCarraydata count];
    counth = (countspecifi%4==0?countspecifi/4:countspecifi/4+1);
    
    for(int i=0;i<counth;i++)
    {
        if(i<counth-1)
        {
            countv = 4;
        }
        else
        {
            countv = countspecifi%4==0?4:countspecifi%4;
        }
        
        for(int j=0;j<countv;j++)
        {
            NSDictionary *dictemp = [FCarraydata objectAtIndex:i*4+j];
            UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(20+(widthnow+10)*j, 20+(widthnow+10)*i, widthnow, widthnow)];
            imageview.tag = EnWaterMettingPicArrmentImageViewTag+i*4+j;
            NSString *strpic = [dictemp objectForKey:@"thumbpicture"];
            [imageview setImageWithURL:[NSURL URLWithString:strpic] placeholderImage:LOADIMAGE(@"testpic", @"png")];
            imageview.contentMode = UIViewContentModeScaleAspectFill;
            imageview.clipsToBounds = YES;
            imageview.userInteractionEnabled = YES;
            UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(photoTappedAd:)];
            [imageview addGestureRecognizer:singleTap];
            [self.view addSubview:imageview];
        }
    }
}


-(void)viewWillAppear:(BOOL)animated
{
    [self getpiclist];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.navigationController.navigationBar.translucent = NO;
    [self.navigationController.navigationBar  setBackgroundImage:[[UIImage alloc] init] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    [self.navigationController.navigationBar setBarTintColor:COLORNOW(0, 170, 238)];
    UIColor* color = [UIColor whiteColor];
    NSDictionary* dict=[NSDictionary dictionaryWithObject:color forKey:NSForegroundColorAttributeName];
    self.navigationController.navigationBar.titleTextAttributes= dict;
}
#pragma mark IBAction

-(void)returnback
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)photoTappedAd:(UIGestureRecognizer*)sender
{
    UIImageView *imageview = (UIImageView *)[sender view];
    NSDictionary *dictemp = [FCarraydata objectAtIndex:imageview.tag -EnWaterMettingPicArrmentImageViewTag];
 //   UITableViewCell *cell = [tableview cellForRowAtIndexPath:indexpath];
 //   CGRect rectInTableView = [scrollview rectForRowAtIndexPath:indexpath];//获取cell在tableView中的位置
 //   CGRect rectInSuperview = [scrollview convertRect:imageview.frame toView:app.window];
    CGRect rectPicView = [scrollview convertRect:imageview.frame toView:app.window];
 //   DLog(@"size==%f,%f,%f,%f",rectInSuperview.origin.x,rectInSuperview.origin.y,rectPicView.origin.x,rectPicView.origin.y);
    BrokeDisplayPicView *brokedisplay = [[BrokeDisplayPicView alloc] initWithFrame:CGRectMake(rectPicView.origin.x, rectPicView.origin.y, 100, 150) PicPath:[dictemp objectForKey:@"largepicture"] FromImage:imageview.image];
    [app.window addSubview:brokedisplay];
    [UIView transitionWithView:brokedisplay duration:0.3 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        brokedisplay.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    } completion:^(BOOL finished) {
        //finished判断动画是否完成
        if (finished) {
            
        }
    }];

}


#pragma mark 接口
-(void)getpiclist
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"meetingid"] = self.FCmettingid;
    
    [RequestInterface doGetJsonWithParametersNoAn:params App:app RequestCode:RQMyWiringDiagramPicListCode ReqUrl:InterfaceRequestUrl ShowView:app.window alwaysdo:^{
        
    } Success:^(NSDictionary *dic) {
        DLog(@"dic====%@",dic);
        if([[dic objectForKey:@"success"] isEqualToString:@"true"])
        {
            NSArray *arraypic = [[dic objectForKey:@"data"] objectForKey:@"picturelist"];
            FCarraydata = [[NSMutableArray alloc] initWithArray:arraypic];
            if([FCarraydata count]==0)
            {
                imageviewno.alpha = 1;
            }
            else
            {
                imageviewno.alpha = 0;
                [self picarrment];
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
