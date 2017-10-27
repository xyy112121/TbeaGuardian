//
//  MyTaskListViewController.m
//  TbeaGuardian
//
//  Created by xyy on 2017/9/15.
//  Copyright © 2017年 xyy. All rights reserved.
//

#import "MyTaskListViewController.h"

@interface MyTaskListViewController ()

@end

@implementation MyTaskListViewController

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
    self.title = @"我发布的任务";
    self.view.backgroundColor = [UIColor whiteColor];
    app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    entaskstatus = EnMyTaskAll;
    FCorderitem = @"";
    FCorderid = @"";
    
    
    tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64-50)];
    tableview.backgroundColor = [UIColor clearColor];
    tableview.delegate = self;
    tableview.dataSource = self;
    [self.view addSubview:tableview];
    [self setExtraCellLineHidden:tableview];
    
    __weak __typeof(self) weakSelf = self;
    tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf gettasklist:@"1" PageSize:@"10"];
    }];
    
    tableview.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [weakSelf gettasklist:@"1" PageSize:[NSString stringWithFormat:@"%d",(int)[FCarraydata count]+10]];
    }];
    // 默认先隐藏footer
    tableview.mj_footer.hidden = YES;
    
    [self initheaderview];
    
}

-(void)initheaderview
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableview.frame.size.width,40)];
    view.backgroundColor = [UIColor whiteColor];
    tableview.tableHeaderView = view;
    
    UIButton *button1 = [self initbutton:@"全部" Frame:CGRectMake(0,0,SCREEN_WIDTH/5,40)];
    [button1 addTarget:self action:@selector(clickselectitem:) forControlEvents:UIControlEventTouchUpInside];
    [button1 setTitleColor:COLORNOW(0, 170, 238) forState:UIControlStateNormal];
    button1.tag = EnMyTaskListTypeSelectItem1;
    [view addSubview:button1];
    
    UIButton *button2 = [self initbutton:@"待接单" Frame:CGRectMake(SCREEN_WIDTH/5,0,SCREEN_WIDTH/5,40)];
    [button2 addTarget:self action:@selector(clickselectitem:) forControlEvents:UIControlEventTouchUpInside];
    button2.tag = EnMyTaskListTypeSelectItem2;
    [view addSubview:button2];
    
    UIButton *button3 = [self initbutton:@"已接单" Frame:CGRectMake(SCREEN_WIDTH/5*2,0,SCREEN_WIDTH/5,40)];
    [button3 addTarget:self action:@selector(clickselectitem:) forControlEvents:UIControlEventTouchUpInside];
    button3.tag = EnMyTaskListTypeSelectItem3;
    [view addSubview:button3];
    
    UIButton *button4 = [self initbutton:@"待评价" Frame:CGRectMake(SCREEN_WIDTH/5*3,0,SCREEN_WIDTH/5,40)];
    [button4 addTarget:self action:@selector(clickselectitem:) forControlEvents:UIControlEventTouchUpInside];
    button4.tag = EnMyTaskListTypeSelectItem4;
    [view addSubview:button4];
    
    UIButton *button5 = [self initbutton:@"已结束" Frame:CGRectMake(SCREEN_WIDTH/5*4,0,SCREEN_WIDTH/5,40)];
    [button5 addTarget:self action:@selector(clickselectitem:) forControlEvents:UIControlEventTouchUpInside];
    button5.tag = EnMyTaskListTypeSelectItem5;
    [view addSubview:button5];
    
    UIImageView *imageline = [[UIImageView alloc] initWithFrame:CGRectMake(0, 39, SCREEN_WIDTH, 1)];
    imageline.backgroundColor = COLORNOW(220, 220, 220);
    [view addSubview:imageline];
    
    tableview.tableHeaderView=view;

}

-(void)viewWillAppear:(BOOL)animated
{
    [self gettasklist:@"1" PageSize:@"10"];
    
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
    
    UILabel *labeltaskcode = [[UILabel alloc] initWithFrame:CGRectMake(10,15,nowwidth*3,20)];
    labeltaskcode.backgroundColor = [UIColor clearColor];
    labeltaskcode.textColor = [UIColor blackColor];
    labeltaskcode.font = FONTN(13.0f);
    labeltaskcode.text = [sender objectForKey:@"taskcode"];
    [view addSubview:labeltaskcode];
    
    UILabel *labeltaskvalue = [[UILabel alloc] initWithFrame:CGRectMake(10+nowwidth*3,15,nowwidth*2,20)];
    labeltaskvalue.backgroundColor = [UIColor clearColor];
    labeltaskvalue.textColor = [UIColor blackColor];
    labeltaskvalue.font = FONTN(13.0f);
    if(entaskstatus == EnMyTaskAll)
        labeltaskvalue.text = [sender objectForKey:@"taskstatus"];
    else if(entaskstatus == EnMyTaskDaiJieDan)
        labeltaskvalue.text = [sender objectForKey:@"bidstatus"];
    else if(entaskstatus == EnMyTaskYiJieDan)
        labeltaskvalue.text = [sender objectForKey:@"bidstatus"];
    else if(entaskstatus == EnMyTaskDaiPingJia)
        labeltaskvalue.text = [NSString stringWithFormat:@"%@",[sender objectForKey:@"actualfee"]];
    else if(entaskstatus == EnMyTaskYiJieSu)
        labeltaskvalue.text = [NSString stringWithFormat:@"%@",[sender objectForKey:@"fee"]];
    labeltaskvalue.textAlignment = NSTextAlignmentCenter;
    [view addSubview:labeltaskvalue];
    
    UILabel *labeltaskdate = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-10-nowwidth*2,15,nowwidth*2,20)];
    labeltaskdate.backgroundColor = [UIColor clearColor];
    labeltaskdate.textColor = [UIColor blackColor];
    labeltaskdate.font = FONTN(13.0f);
    labeltaskdate.text = [sender objectForKey:@"publishtime"];
    if(entaskstatus == EnMyTaskDaiPingJia)
        labeltaskdate.text = [sender objectForKey:@"finishtime"];
    else if(entaskstatus == EnMyTaskYiJieSu)
        labeltaskdate.text = [NSString stringWithFormat:@"%@",[sender objectForKey:@"appraisetime"]];
    
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
    UIButton *button1 = [tableview.tableHeaderView viewWithTag:EnMyTaskListTypeSelectItem1];
    UIButton *button2 = [tableview.tableHeaderView viewWithTag:EnMyTaskListTypeSelectItem2];
    UIButton *button3 = [tableview.tableHeaderView viewWithTag:EnMyTaskListTypeSelectItem3];
    UIButton *button4 = [tableview.tableHeaderView viewWithTag:EnMyTaskListTypeSelectItem4];
    UIButton *button5 = [tableview.tableHeaderView viewWithTag:EnMyTaskListTypeSelectItem5];
    [button1 setTitleColor:COLORNOW(117, 117, 117) forState:UIControlStateNormal];
    [button2 setTitleColor:COLORNOW(117, 117, 117) forState:UIControlStateNormal];
    [button3 setTitleColor:COLORNOW(117, 117, 117) forState:UIControlStateNormal];
    [button4 setTitleColor:COLORNOW(117, 117, 117) forState:UIControlStateNormal];
    [button5 setTitleColor:COLORNOW(117, 117, 117) forState:UIControlStateNormal];
    UIButton *button = (UIButton *)sender;
    int tagnow = (int)[button tag];
    switch (tagnow)
    {
        case EnMyTaskListTypeSelectItem1:
            entaskstatus = EnMyTaskAll;
            [button setTitleColor:COLORNOW(0, 170, 238) forState:UIControlStateNormal];
            break;
        case EnMyTaskListTypeSelectItem2:
            entaskstatus = EnMyTaskDaiJieDan;
            [button setTitleColor:COLORNOW(0, 170, 238) forState:UIControlStateNormal];
            break;
        case EnMyTaskListTypeSelectItem3:
            entaskstatus = EnMyTaskYiJieDan;
            
            [button setTitleColor:COLORNOW(0, 170, 238) forState:UIControlStateNormal];
            break;
        case EnMyTaskListTypeSelectItem4:
            entaskstatus = EnMyTaskDaiPingJia;
            [button setTitleColor:COLORNOW(0, 170, 238) forState:UIControlStateNormal];
            break;
        case EnMyTaskListTypeSelectItem5:
            entaskstatus = EnMyTaskYiJieSu;
            [button setTitleColor:COLORNOW(0, 170, 238) forState:UIControlStateNormal];
            break;
            
    }
    [self gettasklist:@"1" PageSize:@"10"];
}

-(void)selectprice:(id)sender
{
//    ButtonItemLayoutView *buttonitem = [self.view viewWithTag:EnMallStoreMangerLinkTypeSelectItem4];
//    [buttonitem updatelablecolor:COLORNOW(0, 170, 236)];
//    if([FCorderid isEqualToString:@"desc"])
//    {
//        FCorderid = @"asc";
//        FCorderitem = @"price";
//        [buttonitem updateimage:LOADIMAGE(@"arrawbluegray", @"png")];
//    }
//    else
//    {
//        FCorderid = @"desc";
//        FCorderitem = @"price";
//        [buttonitem updateimage:LOADIMAGE(@"arrawgrayblue", @"png")];
//    }
//    [self gettasklist:@"1" PageSize:@"10"];
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
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableview.frame.size.width,40)];
    view.backgroundColor = [UIColor whiteColor];
    
    float nowwidth = (SCREEN_WIDTH-20)/7;
    if(entaskstatus == EnMyTaskAll)
    {
        ButtonItemLayoutView *buttonitem1 = [[ButtonItemLayoutView alloc] initWithFrame:CGRectMake(10, 0, nowwidth*3, 40)];
        [buttonitem1.button addTarget:self action:@selector(clickselectitem:) forControlEvents:UIControlEventTouchUpInside];
        [buttonitem1 updatebuttonitem:EnButtonTextLeft TextStr:@"任务编号" Font:FONTN(14.0f) Color:COLORNOW(117, 117, 117) Image:LOADIMAGE(@"arrawgray", @"png")];
        buttonitem1.tag = EnMyTaskorderitemSelectitem1;
        [view addSubview:buttonitem1];
        
        
        ButtonItemLayoutView *buttonitem2 = [[ButtonItemLayoutView alloc] initWithFrame:CGRectMake(10+nowwidth*3, 0, nowwidth*2, 40)];
        [buttonitem2.button addTarget:self action:@selector(clickselectitem:) forControlEvents:UIControlEventTouchUpInside];
        [buttonitem2 updatebuttonitem:EnButtonTextCenter TextStr:@"任务状态" Font:FONTN(14.0f) Color:COLORNOW(117, 117, 117) Image:LOADIMAGE(@"arrawgray", @"png")];
        buttonitem2.tag = EnMyTaskorderitemSelectitem2;
        [view addSubview:buttonitem2];
        
        ButtonItemLayoutView *buttonitem3 = [[ButtonItemLayoutView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-10-nowwidth*2, 0, nowwidth*2, 40)];
        [buttonitem3.button addTarget:self action:@selector(clickselectitem:) forControlEvents:UIControlEventTouchUpInside];
        [buttonitem3 updatebuttonitem:EnButtonTextRight TextStr:@"发布日期" Font:FONTN(14.0f) Color:COLORNOW(117, 117, 117) Image:LOADIMAGE(@"arrawgray", @"png")];
        buttonitem3.tag = EnMyTaskorderitemSelectitem2;
        [view addSubview:buttonitem3];
    }
    else if(entaskstatus == EnMyTaskDaiJieDan)
    {
        ButtonItemLayoutView *buttonitem1 = [[ButtonItemLayoutView alloc] initWithFrame:CGRectMake(10, 0, nowwidth*3, 40)];
        [buttonitem1.button addTarget:self action:@selector(clickselectitem:) forControlEvents:UIControlEventTouchUpInside];
        [buttonitem1 updatebuttonitem:EnButtonTextLeft TextStr:@"任务编号" Font:FONTN(14.0f) Color:COLORNOW(117, 117, 117) Image:LOADIMAGE(@"arrawgray", @"png")];
        buttonitem1.tag = EnMyTaskorderitemSelectitem1;
        [view addSubview:buttonitem1];
        
        
        ButtonItemLayoutView *buttonitem2 = [[ButtonItemLayoutView alloc] initWithFrame:CGRectMake(10+nowwidth*3, 0, nowwidth*2, 40)];
        [buttonitem2.button addTarget:self action:@selector(clickselectitem:) forControlEvents:UIControlEventTouchUpInside];
        [buttonitem2 updatebuttonitem:EnButtonTextCenter TextStr:@"竞价状态" Font:FONTN(14.0f) Color:COLORNOW(117, 117, 117) Image:LOADIMAGE(@"arrawgray", @"png")];
        buttonitem2.tag = EnMyTaskorderitemSelectitem2;
        [view addSubview:buttonitem2];
        
        ButtonItemLayoutView *buttonitem3 = [[ButtonItemLayoutView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-10-nowwidth*2, 0, nowwidth*2, 40)];
        [buttonitem3.button addTarget:self action:@selector(clickselectitem:) forControlEvents:UIControlEventTouchUpInside];
        [buttonitem3 updatebuttonitem:EnButtonTextRight TextStr:@"发布日期" Font:FONTN(14.0f) Color:COLORNOW(117, 117, 117) Image:LOADIMAGE(@"arrawgray", @"png")];
        buttonitem3.tag = EnMyTaskorderitemSelectitem2;
        [view addSubview:buttonitem3];
    }
    else if(entaskstatus == EnMyTaskYiJieDan)
    {
        ButtonItemLayoutView *buttonitem1 = [[ButtonItemLayoutView alloc] initWithFrame:CGRectMake(10, 0, nowwidth*3, 40)];
        [buttonitem1.button addTarget:self action:@selector(clickselectitem:) forControlEvents:UIControlEventTouchUpInside];
        [buttonitem1 updatebuttonitem:EnButtonTextLeft TextStr:@"任务编号" Font:FONTN(14.0f) Color:COLORNOW(117, 117, 117) Image:LOADIMAGE(@"arrawgray", @"png")];
        buttonitem1.tag = EnMyTaskorderitemSelectitem1;
        [view addSubview:buttonitem1];
        
        
        ButtonItemLayoutView *buttonitem2 = [[ButtonItemLayoutView alloc] initWithFrame:CGRectMake(10+nowwidth*3, 0, nowwidth*2, 40)];
        [buttonitem2.button addTarget:self action:@selector(clickselectitem:) forControlEvents:UIControlEventTouchUpInside];
        [buttonitem2 updatebuttonitem:EnButtonTextCenter TextStr:@"竞价状态" Font:FONTN(14.0f) Color:COLORNOW(117, 117, 117) Image:LOADIMAGE(@"arrawgray", @"png")];
        buttonitem2.tag = EnMyTaskorderitemSelectitem2;
        [view addSubview:buttonitem2];
        
        ButtonItemLayoutView *buttonitem3 = [[ButtonItemLayoutView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-10-nowwidth*2, 0, nowwidth*2, 40)];
        [buttonitem3.button addTarget:self action:@selector(clickselectitem:) forControlEvents:UIControlEventTouchUpInside];
        [buttonitem3 updatebuttonitem:EnButtonTextRight TextStr:@"发布日期" Font:FONTN(14.0f) Color:COLORNOW(117, 117, 117) Image:LOADIMAGE(@"arrawgray", @"png")];
        buttonitem3.tag = EnMyTaskorderitemSelectitem2;
        [view addSubview:buttonitem3];
    }
    else if(entaskstatus == EnMyTaskDaiPingJia)
    {
        ButtonItemLayoutView *buttonitem1 = [[ButtonItemLayoutView alloc] initWithFrame:CGRectMake(10, 0, nowwidth*3, 40)];
        [buttonitem1.button addTarget:self action:@selector(clickselectitem:) forControlEvents:UIControlEventTouchUpInside];
        [buttonitem1 updatebuttonitem:EnButtonTextLeft TextStr:@"任务编号" Font:FONTN(14.0f) Color:COLORNOW(117, 117, 117) Image:LOADIMAGE(@"arrawgray", @"png")];
        buttonitem1.tag = EnMyTaskorderitemSelectitem1;
        [view addSubview:buttonitem1];
        
        
        ButtonItemLayoutView *buttonitem2 = [[ButtonItemLayoutView alloc] initWithFrame:CGRectMake(10+nowwidth*3, 0, nowwidth*2, 40)];
        [buttonitem2.button addTarget:self action:@selector(clickselectitem:) forControlEvents:UIControlEventTouchUpInside];
        [buttonitem2 updatebuttonitem:EnButtonTextCenter TextStr:@"接单价格" Font:FONTN(14.0f) Color:COLORNOW(117, 117, 117) Image:LOADIMAGE(@"arrawgray", @"png")];
        buttonitem2.tag = EnMyTaskorderitemSelectitem2;
        [view addSubview:buttonitem2];
        
        ButtonItemLayoutView *buttonitem3 = [[ButtonItemLayoutView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-10-nowwidth*2, 0, nowwidth*2, 40)];
        [buttonitem3.button addTarget:self action:@selector(clickselectitem:) forControlEvents:UIControlEventTouchUpInside];
        [buttonitem3 updatebuttonitem:EnButtonTextRight TextStr:@"发布日期" Font:FONTN(14.0f) Color:COLORNOW(117, 117, 117) Image:LOADIMAGE(@"arrawgray", @"png")];
        buttonitem3.tag = EnMyTaskorderitemSelectitem2;
        [view addSubview:buttonitem3];
    }
    else if(entaskstatus == EnMyTaskYiJieSu)
    {
        ButtonItemLayoutView *buttonitem1 = [[ButtonItemLayoutView alloc] initWithFrame:CGRectMake(10, 0, nowwidth*3, 40)];
        [buttonitem1.button addTarget:self action:@selector(clickselectitem:) forControlEvents:UIControlEventTouchUpInside];
        [buttonitem1 updatebuttonitem:EnButtonTextLeft TextStr:@"任务编号" Font:FONTN(14.0f) Color:COLORNOW(117, 117, 117) Image:LOADIMAGE(@"arrawgray", @"png")];
        buttonitem1.tag = EnMyTaskorderitemSelectitem1;
        [view addSubview:buttonitem1];

        ButtonItemLayoutView *buttonitem2 = [[ButtonItemLayoutView alloc] initWithFrame:CGRectMake(10+nowwidth*3, 0, nowwidth*2, 40)];
        [buttonitem2.button addTarget:self action:@selector(clickselectitem:) forControlEvents:UIControlEventTouchUpInside];
        [buttonitem2 updatebuttonitem:EnButtonTextCenter TextStr:@"接单价格" Font:FONTN(14.0f) Color:COLORNOW(117, 117, 117) Image:LOADIMAGE(@"arrawgray", @"png")];
        buttonitem2.tag = EnMyTaskorderitemSelectitem2;
        [view addSubview:buttonitem2];
        
        ButtonItemLayoutView *buttonitem3 = [[ButtonItemLayoutView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-10-nowwidth*2, 0, nowwidth*2, 40)];
        [buttonitem3.button addTarget:self action:@selector(clickselectitem:) forControlEvents:UIControlEventTouchUpInside];
        [buttonitem3 updatebuttonitem:EnButtonTextRight TextStr:@"评价日期" Font:FONTN(14.0f) Color:COLORNOW(117, 117, 117) Image:LOADIMAGE(@"arrawgray", @"png")];
        buttonitem3.tag = EnMyTaskorderitemSelectitem2;
        [view addSubview:buttonitem3];
    }
        
    UIImageView *imageline = [[UIImageView alloc] initWithFrame:CGRectMake(0, 39, SCREEN_WIDTH, 1)];
    imageline.backgroundColor = COLORNOW(220, 220, 220);
    [view addSubview:imageline];
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
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
    [cell.contentView addSubview:[self viewcelltask:dictemp Frame:CGRectMake(0, 0, 0, 40)]];
    
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dictemp = [FCarraydata objectAtIndex:indexPath.row];
    if([[dictemp objectForKey:@"taskstatusid"] isEqualToString:@"new"])
    {
        TaskDetailViewController *taskdetail = [[TaskDetailViewController alloc] init];
        taskdetail.FCtaskid = [dictemp objectForKey:@"taskid"];
        [self.navigationController pushViewController:taskdetail animated:YES];
    }
    else if([[dictemp objectForKey:@"taskstatusid"] isEqualToString:@"assigned"])
    {
        TaskDetailYiJieDanViewController *taskdetail = [[TaskDetailYiJieDanViewController alloc] init];
        taskdetail.FCtaskid = [dictemp objectForKey:@"taskid"];
        [self.navigationController pushViewController:taskdetail animated:YES];
    }
    else if([[dictemp objectForKey:@"taskstatusid"] isEqualToString:@"finishedbutneedappraise"])
    {
        TaskDetailDaiPingJiaViewController *taskdetail = [[TaskDetailDaiPingJiaViewController alloc] init];
        taskdetail.FCtaskid = [dictemp objectForKey:@"taskid"];
        [self.navigationController pushViewController:taskdetail animated:YES];
    }
}

#pragma mark 接口
-(void)gettasklist:(NSString *)page PageSize:(NSString *)pagesize 
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"orderitem"] = FCorderitem;
    params[@"order"] = FCorderid;
    params[@"page"] = page;
    params[@"pagesize"] = pagesize;
    
    NSString *strinterface;
    if(entaskstatus == EnMyTaskAll)
    {
        strinterface = RQMyTaskListAllCode;
    }
    else if(entaskstatus == EnMyTaskDaiJieDan)
    {
        strinterface = RQMyTaskListDaiJieDanCode;
    }
    else if(entaskstatus == EnMyTaskYiJieDan)
    {
        strinterface = RQMyTaskListYiJieDanCode;
    }
    else if(entaskstatus == EnMyTaskDaiPingJia)
    {
        strinterface = RQMyTaskListDaiPingJiaCode;
    }
    else if(entaskstatus == EnMyTaskYiJieSu)
    {
        strinterface = RQMyTaskListYiJieSuCode;
    }
    
    [RequestInterface doGetJsonWithParametersNoAn:params App:app RequestCode:strinterface ReqUrl:InterfaceRequestUrl ShowView:app.window alwaysdo:^{
        
    } Success:^(NSDictionary *dic) {
        DLog(@"dic====%@",dic);
        if([[dic objectForKey:@"success"] isEqualToString:@"true"])
        {
            FCarraydata = [[dic objectForKey:@"data"] objectForKey:@"tasklist"];
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
