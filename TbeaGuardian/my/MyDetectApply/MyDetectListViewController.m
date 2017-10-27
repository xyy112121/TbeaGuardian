//
//  MyDetectListViewController.m
//  TbeaGuardian
//
//  Created by xyy on 2017/9/16.
//  Copyright © 2017年 xyy. All rights reserved.
//

#import "MyDetectListViewController.h"

@interface MyDetectListViewController ()

@end

@implementation MyDetectListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)])
    {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    [self initview];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(2, 2, 60, 40)];
    UIButton *button = [[UIButton alloc] initWithFrame:contentView.bounds];
    button.layer.borderColor = [UIColor clearColor].CGColor;
    [button setImage:LOADIMAGE(@"returnback", @"png") forState:UIControlStateNormal];
    button.imageEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
    [button addTarget:self action: @selector(returnback) forControlEvents: UIControlEventTouchUpInside];
    [contentView addSubview:button];
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:contentView];
    self.navigationItem.leftBarButtonItem = barButtonItem;
    
    //    UIView *contentViewright = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    //    UIButton *buttonright = [[UIButton alloc] initWithFrame:contentViewright.bounds];
    //    [buttonright setTitle:@"添加" forState:UIControlStateNormal];
    //    buttonright.titleLabel.font = FONTN(15.0f);
    //    [buttonright setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    //    [buttonright addTarget:self action: @selector(ClickAdd:) forControlEvents: UIControlEventTouchUpInside];
    //    [contentViewright addSubview:buttonright];
    //    buttonright.imageEdgeInsets = UIEdgeInsetsMake(0,0, 0, -20);
    //    UIBarButtonItem *barButtonItemright = [[UIBarButtonItem alloc] initWithCustomView:contentViewright];
    //    self.navigationItem.rightBarButtonItem = barButtonItemright;
    
    // Do any additional setup after loading the view.
}

#pragma mark 页面布局
-(void)initview
{
    self.title = @"我的免费检测";
    self.view.backgroundColor = [UIColor whiteColor];
    app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    entaskstatus = EnMyTaskAll;
    FCorderitem = @"";
    FCorderid = @"";
    FCordercode = @"";
    FCorderdate = @"";
    FCorderstatus = @"";
    
    tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64-50)];
    tableview.backgroundColor = [UIColor clearColor];
    tableview.delegate = self;
    tableview.dataSource = self;
    [self.view addSubview:tableview];
    [self setExtraCellLineHidden:tableview];
    
    __weak __typeof(self) weakSelf = self;
    tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf getdetectlist:@"1" PageSize:@"10"];
    }];
    
    tableview.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [weakSelf getdetectlist:@"1" PageSize:[NSString stringWithFormat:@"%d",(int)[FCarraydata count]+10]];
    }];
    // 默认先隐藏footer
    tableview.mj_footer.hidden = YES;
    
    
    [self getdetectstatus];
}

-(void)initheaderview
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableview.frame.size.width,80)];
    view.backgroundColor = [UIColor whiteColor];
    tableview.tableHeaderView = view;
    
    int nowwidth = SCREEN_WIDTH/[FCstatuslist count];
    for(int i=0;i<[FCstatuslist count];i++)
    {
        
        NSDictionary *dictemp = [FCstatuslist objectAtIndex:i];
        
            
        UIButton *button1 = [self initbutton:[dictemp objectForKey:@"name"] Frame:CGRectMake(nowwidth*i,0,nowwidth,40)];
        [button1 addTarget:self action:@selector(clickselectitem:) forControlEvents:UIControlEventTouchUpInside];
        [button1 setTitleColor:COLORNOW(117, 117, 117) forState:UIControlStateNormal];
        if([[dictemp objectForKey:@"id"] isEqualToString:FCcheckstatusid])
            [button1 setTitleColor:COLORNOW(0  , 170, 238) forState:UIControlStateNormal];
        button1.tag = EnMyTaskListTypeSelectItem1+i;
        [view addSubview:button1];
    }
    
    UIImageView *imageline = [[UIImageView alloc] initWithFrame:CGRectMake(0, 39, SCREEN_WIDTH, 1)];
    imageline.backgroundColor = COLORNOW(220, 220, 220);
    [view addSubview:imageline];
    
    
    UIView *viewselectitem =  [self setselectsortselectitem];
    [view addSubview:viewselectitem];
    
    
    tableview.tableHeaderView=view;
    
}

-(UIView *)setselectsortselectitem
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 40, tableview.frame.size.width,40)];
    view.backgroundColor = [UIColor whiteColor];
    
    float nowwidth = (SCREEN_WIDTH-20)/7;
    
    ButtonItemLayoutView *buttonitem1 = [[ButtonItemLayoutView alloc] initWithFrame:CGRectMake(10, 0, nowwidth*3, 40)];
    [buttonitem1.button addTarget:self action:@selector(selectdeteccode:) forControlEvents:UIControlEventTouchUpInside];
    [buttonitem1 updatebuttonitem:EnButtonTextLeft TextStr:@"预约编号" Font:FONTN(14.0f) Color:COLORNOW(117, 117, 117) Image:LOADIMAGE(@"arrawgray", @"png")];
    buttonitem1.tag = EnMyDetectorderitemSelectitem1;
    [view addSubview:buttonitem1];
    
    
    ButtonItemLayoutView *buttonitem2 = [[ButtonItemLayoutView alloc] initWithFrame:CGRectMake(10+nowwidth*3, 0, nowwidth*2, 40)];
    [buttonitem2.button addTarget:self action:@selector(selectdetestatus:) forControlEvents:UIControlEventTouchUpInside];
    [buttonitem2 updatebuttonitem:EnButtonTextCenter TextStr:@"预约状态" Font:FONTN(14.0f) Color:COLORNOW(117, 117, 117) Image:LOADIMAGE(@"arrawgray", @"png")];
    buttonitem2.tag = EnMyDetectorderitemSelectitem2;
    [view addSubview:buttonitem2];
    
    ButtonItemLayoutView *buttonitem3 = [[ButtonItemLayoutView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-10-nowwidth*2, 0, nowwidth*2, 40)];
    [buttonitem3.button addTarget:self action:@selector(selectdetedate:) forControlEvents:UIControlEventTouchUpInside];
    [buttonitem3 updatebuttonitem:EnButtonTextRight TextStr:@"预约日期" Font:FONTN(14.0f) Color:COLORNOW(117, 117, 117) Image:LOADIMAGE(@"arrawgray", @"png")];
    buttonitem3.tag = EnMyDetectorderitemSelectitem3;
    [view addSubview:buttonitem3];
    
    UIImageView *imageline = [[UIImageView alloc] initWithFrame:CGRectMake(0, 39, SCREEN_WIDTH, 1)];
    imageline.backgroundColor = COLORNOW(220, 220, 220);
    [view addSubview:imageline];
    return view;
}

-(void)viewWillAppear:(BOOL)animated
{
    
    
    self.navigationController.navigationBar.translucent = NO;
    [self.navigationController.navigationBar  setBackgroundImage:[[UIImage alloc] init] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    [self.navigationController.navigationBar setBarTintColor:COLORNOW(0, 170, 238)];
    UIColor* color = [UIColor whiteColor];
    NSDictionary* dict=[NSDictionary dictionaryWithObject:color forKey:NSForegroundColorAttributeName];
    self.navigationController.navigationBar.titleTextAttributes= dict;
}

-(UIButton *)initbutton:(NSString *)title Frame:(CGRect)frame
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    
    button.titleLabel.font = FONTN(15.0f);
    
    return button;
}

-(UIView *)viewcelltask:(NSDictionary *)sender Frame:(CGRect)frame
{
    UIView *view = [[UIView alloc] initWithFrame:frame];
    float nowwidth = (SCREEN_WIDTH-20)/7;
    
    UILabel *labeltaskcode = [[UILabel alloc] initWithFrame:CGRectMake(10,15,nowwidth*3+10,20)];
    labeltaskcode.backgroundColor = [UIColor clearColor];
    labeltaskcode.textColor = [UIColor blackColor];
    labeltaskcode.font = FONTN(13.0f);
    labeltaskcode.text = [sender objectForKey:@"subscribecode"];
    [view addSubview:labeltaskcode];
    
    UILabel *labeltaskvalue = [[UILabel alloc] initWithFrame:CGRectMake(10+nowwidth*3,15,nowwidth*2,20)];
    labeltaskvalue.backgroundColor = [UIColor clearColor];
    labeltaskvalue.textColor = [UIColor blackColor];
    labeltaskvalue.font = FONTN(13.0f);
    labeltaskvalue.text = [sender objectForKey:@"checkstatus"];
    labeltaskvalue.textAlignment = NSTextAlignmentCenter;
    [view addSubview:labeltaskvalue];
    
    UILabel *labeltaskdate = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-10-nowwidth*2,15,nowwidth*2,20)];
    labeltaskdate.backgroundColor = [UIColor clearColor];
    labeltaskdate.textColor = [UIColor blackColor];
    labeltaskdate.font = FONTN(13.0f);
    labeltaskdate.text = [sender objectForKey:@"subscribetime"];
    
    labeltaskdate.textAlignment = NSTextAlignmentRight;
    [view addSubview:labeltaskdate];
    
    return view;
}

#pragma mark IBAction
-(void)returnback
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)clickselectitem:(id)sender
{
    for(int i=0;i<[FCstatuslist count];i++)
    {
        UIButton *button1 = [tableview.tableHeaderView viewWithTag:EnMyTaskListTypeSelectItem1+i];
        [button1 setTitleColor:COLORNOW(117, 117, 117) forState:UIControlStateNormal];
    }

    UIButton *button = (UIButton *)sender;
    int tagnow = (int)[button tag]-EnMyTaskListTypeSelectItem1;
    NSDictionary *dictemp = [FCstatuslist objectAtIndex:tagnow];
    [button setTitleColor:COLORNOW(0, 170, 238) forState:UIControlStateNormal];
    FCcheckstatusid = [dictemp objectForKey:@"id"];
    
    ButtonItemLayoutView *buttonitem1 = [self.view viewWithTag:EnMyDetectorderitemSelectitem1];
    ButtonItemLayoutView *buttonitem2 = [self.view viewWithTag:EnMyDetectorderitemSelectitem2];
    ButtonItemLayoutView *buttonitem3 = [self.view viewWithTag:EnMyDetectorderitemSelectitem3];
    [buttonitem1 updatelablecolor:COLORNOW(117, 117, 117)];
    [buttonitem2 updatelablecolor:COLORNOW(117, 117, 117)];
    [buttonitem3 updatelablecolor:COLORNOW(117, 117, 117)];
    [buttonitem1 updateimage:LOADIMAGE(@"arrawgray", @"png")];
    [buttonitem2 updateimage:LOADIMAGE(@"arrawgray", @"png")];
    [buttonitem3 updateimage:LOADIMAGE(@"arrawgray", @"png")];
    FCorderdate = @"";
    FCorderstatus = @"";
    FCordercode= @"";
    FCorderid = @"";
    FCorderitem=@"";
    [self getdetectlist:@"1" PageSize:@"10"];
}

-(void)selectdeteccode:(id)sender
{
    ButtonItemLayoutView *buttonitem1 = [self.view viewWithTag:EnMyDetectorderitemSelectitem1];
    ButtonItemLayoutView *buttonitem2 = [self.view viewWithTag:EnMyDetectorderitemSelectitem2];
    ButtonItemLayoutView *buttonitem3 = [self.view viewWithTag:EnMyDetectorderitemSelectitem3];
    [buttonitem1 updatelablecolor:COLORNOW(117, 117, 117)];
    [buttonitem2 updatelablecolor:COLORNOW(117, 117, 117)];
    [buttonitem3 updatelablecolor:COLORNOW(117, 117, 117)];
    [buttonitem1 updateimage:LOADIMAGE(@"arrawgray", @"png")];
    [buttonitem2 updateimage:LOADIMAGE(@"arrawgray", @"png")];
    [buttonitem3 updateimage:LOADIMAGE(@"arrawgray", @"png")];
    FCorderdate = @"";
    FCorderstatus = @"";
    
    [buttonitem1 updatelablecolor:COLORNOW(0, 170, 236)];
    FCorderitem = @"subscribecode";
    if([FCordercode isEqualToString:@""])
    {
        FCordercode = @"desc";
        [buttonitem1 updateimage:LOADIMAGE(@"arrawgrayblue", @"png")];
    }
    else if([FCordercode isEqualToString:@"desc"])
    {
        FCordercode = @"asc";

        [buttonitem1 updateimage:LOADIMAGE(@"arrawbluegray", @"png")];
    }
    else if([FCordercode isEqualToString:@"asc"])
    {
        FCordercode = @"desc";
        [buttonitem1 updateimage:LOADIMAGE(@"arrawgrayblue", @"png")];
    }
    FCorderid = FCordercode;
    [self getdetectlist:@"1" PageSize:@"10"];
}

-(void)selectdetestatus:(id)sender
{
    ButtonItemLayoutView *buttonitem1 = [self.view viewWithTag:EnMyDetectorderitemSelectitem1];
    ButtonItemLayoutView *buttonitem2 = [self.view viewWithTag:EnMyDetectorderitemSelectitem2];
    ButtonItemLayoutView *buttonitem3 = [self.view viewWithTag:EnMyDetectorderitemSelectitem3];
    [buttonitem1 updatelablecolor:COLORNOW(117, 117, 117)];
    [buttonitem2 updatelablecolor:COLORNOW(117, 117, 117)];
    [buttonitem3 updatelablecolor:COLORNOW(117, 117, 117)];
    [buttonitem1 updateimage:LOADIMAGE(@"arrawgray", @"png")];
    [buttonitem2 updateimage:LOADIMAGE(@"arrawgray", @"png")];
    [buttonitem3 updateimage:LOADIMAGE(@"arrawgray", @"png")];
    FCorderdate = @"";
    FCordercode = @"";
    
    [buttonitem2 updatelablecolor:COLORNOW(0, 170, 236)];
    FCorderitem = @"checkstatus";
    if([FCorderstatus isEqualToString:@""])
    {
        FCorderstatus = @"desc";
        [buttonitem2 updateimage:LOADIMAGE(@"arrawgrayblue", @"png")];
    }
    else if([FCorderstatus isEqualToString:@"desc"])
    {
        FCorderstatus = @"asc";
        
        [buttonitem2 updateimage:LOADIMAGE(@"arrawbluegray", @"png")];
    }
    else if([FCorderstatus isEqualToString:@"asc"])
    {
        FCorderstatus = @"desc";
        [buttonitem2 updateimage:LOADIMAGE(@"arrawgrayblue", @"png")];
    }
    FCorderid = FCorderstatus;
    [self getdetectlist:@"1" PageSize:@"10"];
}

-(void)selectdetedate:(id)sender
{
    ButtonItemLayoutView *buttonitem1 = [self.view viewWithTag:EnMyDetectorderitemSelectitem1];
    ButtonItemLayoutView *buttonitem2 = [self.view viewWithTag:EnMyDetectorderitemSelectitem2];
    ButtonItemLayoutView *buttonitem3 = [self.view viewWithTag:EnMyDetectorderitemSelectitem3];
    [buttonitem1 updatelablecolor:COLORNOW(117, 117, 117)];
    [buttonitem2 updatelablecolor:COLORNOW(117, 117, 117)];
    [buttonitem3 updatelablecolor:COLORNOW(117, 117, 117)];
    [buttonitem1 updateimage:LOADIMAGE(@"arrawgray", @"png")];
    [buttonitem2 updateimage:LOADIMAGE(@"arrawgray", @"png")];
    [buttonitem3 updateimage:LOADIMAGE(@"arrawgray", @"png")];
    FCordercode = @"";
    FCorderstatus = @"";
    
    [buttonitem3 updatelablecolor:COLORNOW(0, 170, 236)];
    FCorderitem = @"subscribecode";
    if([FCorderdate isEqualToString:@""])
    {
        FCorderdate = @"desc";
        [buttonitem3 updateimage:LOADIMAGE(@"arrawgrayblue", @"png")];
    }
    else if([FCorderdate isEqualToString:@"desc"])
    {
        FCorderdate = @"asc";
        
        [buttonitem3 updateimage:LOADIMAGE(@"arrawbluegray", @"png")];
    }
    else if([FCorderdate isEqualToString:@"asc"])
    {
        FCorderdate = @"desc";
        [buttonitem1 updateimage:LOADIMAGE(@"arrawgrayblue", @"png")];
    }
    FCorderid = FCorderdate;
    [self getdetectlist:@"1" PageSize:@"10"];
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
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [FCarraydata count];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
//    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableview.frame.size.width,40)];
//    view.backgroundColor = [UIColor whiteColor];
//    
//    float nowwidth = (SCREEN_WIDTH-20)/7;
//
//    ButtonItemLayoutView *buttonitem1 = [[ButtonItemLayoutView alloc] initWithFrame:CGRectMake(10, 0, nowwidth*3, 40)];
//    [buttonitem1.button addTarget:self action:@selector(selectdeteccode:) forControlEvents:UIControlEventTouchUpInside];
//    [buttonitem1 updatebuttonitem:EnButtonTextLeft TextStr:@"预约编号" Font:FONTN(14.0f) Color:COLORNOW(117, 117, 117) Image:LOADIMAGE(@"arrawgray", @"png")];
//    buttonitem1.tag = EnMyDetectorderitemSelectitem1;
//    [view addSubview:buttonitem1];
//    
//    
//    ButtonItemLayoutView *buttonitem2 = [[ButtonItemLayoutView alloc] initWithFrame:CGRectMake(10+nowwidth*3, 0, nowwidth*2, 40)];
//    [buttonitem2.button addTarget:self action:@selector(selectdetestatus:) forControlEvents:UIControlEventTouchUpInside];
//    [buttonitem2 updatebuttonitem:EnButtonTextCenter TextStr:@"预约状态" Font:FONTN(14.0f) Color:COLORNOW(117, 117, 117) Image:LOADIMAGE(@"arrawgray", @"png")];
//    buttonitem2.tag = EnMyDetectorderitemSelectitem2;
//    [view addSubview:buttonitem2];
//    
//    ButtonItemLayoutView *buttonitem3 = [[ButtonItemLayoutView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-10-nowwidth*2, 0, nowwidth*2, 40)];
//    [buttonitem3.button addTarget:self action:@selector(selectdetedate:) forControlEvents:UIControlEventTouchUpInside];
//    [buttonitem3 updatebuttonitem:EnButtonTextRight TextStr:@"预约日期" Font:FONTN(14.0f) Color:COLORNOW(117, 117, 117) Image:LOADIMAGE(@"arrawgray", @"png")];
//    buttonitem3.tag = EnMyDetectorderitemSelectitem3;
//    [view addSubview:buttonitem3];
//    
//    UIImageView *imageline = [[UIImageView alloc] initWithFrame:CGRectMake(0, 39, SCREEN_WIDTH, 1)];
//    imageline.backgroundColor = COLORNOW(220, 220, 220);
//    [view addSubview:imageline];
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    static NSString *reuseIdetify = @"cell";
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdetify];
        
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    for(UIView *view in cell.contentView.subviews)
    {
        [view removeFromSuperview];
    }
    
    cell.backgroundColor = [UIColor whiteColor];
    
    NSDictionary *dictemp = [FCarraydata objectAtIndex:indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryNone;
    [cell.contentView addSubview:[self viewcelltask:dictemp Frame:CGRectMake(0, 0, 0, 50)]];
    
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dictemp = [FCarraydata objectAtIndex:indexPath.row];
    if([[dictemp objectForKey:@"checkstatusid"] isEqualToString:@"new"])
    {
        MyDetectDetailWeiChuLiViewController *weichuli = [[MyDetectDetailWeiChuLiViewController alloc] init];
        weichuli.FCcheckid = [dictemp objectForKey:@"electricalcheckid"];
        [self.navigationController pushViewController:weichuli animated:YES];
    }
    else if([[dictemp objectForKey:@"checkstatusid"] isEqualToString:@"finishedbutneedappraise"])
    {
        MyDetectDetailYiWanGongViewController *yiwangong = [[MyDetectDetailYiWanGongViewController alloc] init];
        yiwangong.FCcheckid = [dictemp objectForKey:@"electricalcheckid"];
        [self.navigationController pushViewController:yiwangong animated:YES];
    }
    else if([[dictemp objectForKey:@"checkstatusid"] isEqualToString:@"assigned"])
    {
        MyDetectDetailYiPaiDanViewController *yipaidan = [[MyDetectDetailYiPaiDanViewController alloc] init];
        yipaidan.FCcheckid = [dictemp objectForKey:@"electricalcheckid"];
        [self.navigationController pushViewController:yipaidan animated:YES];
    }
}

#pragma mark 接口

-(void)getdetectstatus
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [RequestInterface doGetJsonWithParametersNoAn:params App:app RequestCode:RQMyDetectStatusListCode ReqUrl:InterfaceRequestUrl ShowView:app.window alwaysdo:^{
        
    } Success:^(NSDictionary *dic) {
        DLog(@"dic====%@",dic);
        if([[dic objectForKey:@"success"] isEqualToString:@"true"])
        {
            FCstatuslist = [[dic objectForKey:@"data"] objectForKey:@"electricalcheckstatuslist"];
            if([FCstatuslist count]>0)
            {
                NSDictionary *dictemp = [FCstatuslist objectAtIndex:0];
                
                FCcheckstatusid = [dictemp objectForKey:@"id"];
                [self initheaderview];
                [self getdetectlist:@"1" PageSize:@"10"];
            }
        }
        else
        {
            [MBProgressHUD showError:[dic objectForKey:@"msg"] toView:app.window];
        }
        if([FCarraydata count]>9)
            tableview.mj_footer.hidden = NO;
        [tableview.mj_header endRefreshing];
        [tableview.mj_footer endRefreshing];
    } Failur:^(NSString *strmsg) {
        [tableview.mj_header endRefreshing];
        [tableview.mj_footer endRefreshing];
        [MBProgressHUD showError:@"请求失败,请检查网络" toView:self.view];
        
    }];
}


-(void)getdetectlist:(NSString *)page PageSize:(NSString *)pagesize
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"checkstatusid"] = FCcheckstatusid;
    params[@"orderitem"] = FCorderitem;
    params[@"order"] = FCorderid;
    params[@"page"] = page;
    params[@"pagesize"] = pagesize;
    
    [RequestInterface doGetJsonWithParametersNoAn:params App:app RequestCode:RQMyDetectAllListCode ReqUrl:InterfaceRequestUrl ShowView:app.window alwaysdo:^{
        
    } Success:^(NSDictionary *dic) {
        DLog(@"dic====%@",dic);
        if([[dic objectForKey:@"success"] isEqualToString:@"true"])
        {
            FCarraydata = [[dic objectForKey:@"data"] objectForKey:@"electricalchecklist"];
            [tableview reloadData];
        }
        else
        {
            [MBProgressHUD showError:[dic objectForKey:@"msg"] toView:app.window];
        }
        if([FCarraydata count]>9)
            tableview.mj_footer.hidden = NO;
        [tableview.mj_header endRefreshing];
        [tableview.mj_footer endRefreshing];
    } Failur:^(NSString *strmsg) {
        [tableview.mj_header endRefreshing];
        [tableview.mj_footer endRefreshing];
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
