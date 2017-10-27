//
//  MyDetectDetailYiWanGongViewController.m
//  TbeaGuardian
//
//  Created by xyy on 2017/9/16.
//  Copyright © 2017年 xyy. All rights reserved.
//

#import "MyDetectDetailYiWanGongViewController.h"

@interface MyDetectDetailYiWanGongViewController ()

@end

@implementation MyDetectDetailYiWanGongViewController

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

#pragma mark 页面布局
-(void)initview
{
    self.title = @"免费检测预约";
    self.view.backgroundColor = [UIColor whiteColor];
    app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    
    tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64)];
    tableview.backgroundColor = [UIColor clearColor];
    tableview.delegate = self;
    tableview.dataSource = self;
    [self.view addSubview:tableview];
    [self setExtraCellLineHidden:tableview];
    
    UIView *contentViewright = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 64, 44)];
    UIButton *buttonright = [[UIButton alloc] initWithFrame:contentViewright.bounds];
    [buttonright setTitle:@"评价" forState:UIControlStateNormal];
    buttonright.titleLabel.font = FONTN(15.0f);
    [buttonright setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [buttonright addTarget:self action: @selector(clickgotopingjia:) forControlEvents: UIControlEventTouchUpInside];
    [contentViewright addSubview:buttonright];
    buttonright.imageEdgeInsets = UIEdgeInsetsMake(0,0, 0, -20);
    UIBarButtonItem *barButtonItemright = [[UIBarButtonItem alloc] initWithCustomView:contentViewright];
    self.navigationItem.rightBarButtonItem = barButtonItemright;
}

-(void)viewWillAppear:(BOOL)animated
{
    [self getdetectdetail];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
    self.navigationController.navigationBar.translucent = NO;
    [self.navigationController.navigationBar  setBackgroundImage:[[UIImage alloc] init] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    [self.navigationController.navigationBar setBarTintColor:COLORNOW(0, 170, 238)];
    UIColor* color = [UIColor whiteColor];
    NSDictionary* dict=[NSDictionary dictionaryWithObject:color forKey:NSForegroundColorAttributeName];
    self.navigationController.navigationBar.titleTextAttributes= dict;
}




#pragma mark IBaction
-(void)clickgotopingjia:(id)sender
{
    MyDetectDonePingJiaViewController *pingjia = [[MyDetectDonePingJiaViewController alloc] init];
    pingjia.FCvouchernumber = FCvouchercode;
    pingjia.FCdetectperson = FCdetectperson;
    pingjia.FCCheckResultId = FCcheckresultid;
    [self.navigationController pushViewController:pingjia animated:YES];
}

-(void)returnback
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark tableview delegate
//隐藏那些没有cell的线
-(void)setExtraCellLineHidden: (UITableView *)tableView
{
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
}

-(void)viewDidLayoutSubviews
{
    if ([tableview respondsToSelector:@selector(setSeparatorInset:)]) {
        [tableview setSeparatorInset:UIEdgeInsetsMake(0,0,0,0)];
    }
    
    if ([tableview respondsToSelector:@selector(setLayoutMargins:)]) {
        [tableview setLayoutMargins:UIEdgeInsetsMake(0,0,0,0)];
    }
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if((indexPath.section == 1)&&(indexPath.row == 3))
        return 50;
    return 40;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section == 0)
        return 1;
    else if(section == 1)
        return 4;
    return 2;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    //    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,10)];
    //    view.backgroundColor = COLORNOW(235,235, 235);
    
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if(section == 0)
        return 0.01;
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    static NSString *reuseIdetify = @"cell";
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdetify];
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    for(UIView *view in cell.contentView.subviews)
    {
        [view removeFromSuperview];
    }
    
    cell.backgroundColor = [UIColor whiteColor];
    
    UILabel *labelname = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 80, 20)];
    labelname.backgroundColor = [UIColor clearColor];
    labelname.textColor = [UIColor blackColor];
    labelname.font = FONTN(15.0f);
    
    UITextField *textfield = [[UITextField alloc] initWithFrame:CGRectMake(100, 5, SCREEN_WIDTH-110, 30)];
    textfield.textColor = COLORNOW(117, 117, 117);
    textfield.backgroundColor = [UIColor clearColor];
    textfield.font = FONTN(15.0f);
    textfield.delegate = self;
    textfield.enabled = NO;
    
    
    UIImageView *imageview;
    
    switch (indexPath.section)
    {
        case 0:
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            labelname.text = @"凭证号";
            [cell.contentView addSubview:labelname];
            textfield.textColor = COLORNOW(117, 117, 117);
            textfield.tag = EnDetectApplyNewTextfield1;
            textfield.text = FCvouchercode;
            [cell.contentView addSubview:textfield];
            break;
        case 1:
            switch (indexPath.row)
            {
                case 0:
                    
                    labelname.text = @"预约时间";
                    [cell.contentView addSubview:labelname];
                    
                    textfield.tag = EnDetectApplyNewTextfield2;
                    textfield.text = FCsubscribetime;
                    [cell.contentView addSubview:textfield];
                    break;
                case 1:
                    
                    labelname.text = @"状态";
                    [cell.contentView addSubview:labelname];
                    
                    textfield.tag = EnDetectApplyNewTextfield3;
                    textfield.text = FCstatus;
                    [cell.contentView addSubview:textfield];
                    break;
                case 2:
                    
                    labelname.text = @"完工时间";
                    [cell.contentView addSubview:labelname];
                    
                    textfield.tag = EnDetectApplyNewTextfield3;
                    textfield.text = FCdontime;
                    [cell.contentView addSubview:textfield];
                    break;
                case 3:
                    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                    labelname.text = @"检测人员";
                    labelname.frame = CGRectMake(10, 15, 80, 20);
                    [cell.contentView addSubview:labelname];
                    
                    imageview = [AddCustomView CusViewImageViewForRadius:CGRectMake(100, 10, 30, 30) Image:LOADIMAGE(@"testpic", @"png") FRadius:15.0f];
                    [imageview setImageWithURL:[NSURL URLWithString:[FCdetectperson objectForKey:@"thumbpicture"]] placeholderImage:LOADIMAGE(@"testpic", @"png")];
                    
                    [cell.contentView addSubview:imageview];
                    
                    textfield.frame = CGRectMake(XYViewR(imageview)+5, 10, 170, 30);
                    textfield.text = [FCdetectperson objectForKey:@"electricianname"];
                    [cell.contentView addSubview:textfield];
                    break;
            }
            break;
        case 2:
            switch (indexPath.row)
            {
                case 0:
                    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                    labelname.text = @"检测详情";
                    [cell.contentView addSubview:labelname];
                    
                    
                    break;
                case 1:
                    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                    labelname.text = @"布电线照片";
                    [cell.contentView addSubview:labelname];
                    
                   
                    break;
            }
            break;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if((indexPath.section == 2)&&(indexPath.row == 0))
    {
        MyDetectDetailQualifiedViewController *qualified = [[MyDetectDetailQualifiedViewController alloc] init];
        qualified.FCCheckResultId = FCcheckresultid;
        [self.navigationController pushViewController:qualified animated:YES];
    }
}

#pragma mark 接口
//获得一个预约详情已完工
-(void)getdetectdetail
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"electricalcheckid"] = _FCcheckid;
    
    
    DLog(@"params===%@",params);
    
    [RequestInterface doGetJsonWithParametersNoAn:params App:app RequestCode:RQMyDetectYiWanGongDetailCode ReqUrl:InterfaceRequestUrl ShowView:app.window alwaysdo:^{
        
    } Success:^(NSDictionary *dic) {
        DLog(@"dic====%@",dic);
        if([[dic objectForKey:@"success"] isEqualToString:@"true"])
        {
            FCdetectperson = [[dic objectForKey:@"data"] objectForKey:@"assigninfo"];
            FCvouchercode = [[[dic objectForKey:@"data"] objectForKey:@"electricalcheckinfo"] objectForKey:@"vouchercode"];
            FCsubscribetime = [[[dic objectForKey:@"data"] objectForKey:@"electricalcheckinfo"] objectForKey:@"subscribetime"];
            FCstatus = [[[dic objectForKey:@"data"] objectForKey:@"electricalcheckinfo"] objectForKey:@"checkstatus"];
            FCdontime =  [[[dic objectForKey:@"data"] objectForKey:@"electricalcheckinfo"] objectForKey:@"finishtime"];
            FCcheckresultid = [[[dic objectForKey:@"data"] objectForKey:@"checkresultinfo"] objectForKey:@"checkresultid"];
            tableview.delegate = self;
            tableview.dataSource = self;
            [tableview reloadData];
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
