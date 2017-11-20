//
//  MyPageViewController.m
//  TbeaCloudBusiness
//
//  Created by xyy520 on 17/5/18.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import "MyPageViewController.h"

@interface MyPageViewController ()

@end

@implementation MyPageViewController

- (void)viewDidLoad {
	[super viewDidLoad];
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)])
    {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
	[self initview];
	// Do any additional setup after loading the view.
}

-(void)initview
{
    
	self.view.backgroundColor = [UIColor whiteColor];
	app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
	tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, -20, SCREEN_WIDTH, SCREEN_HEIGHT-49)];
	tableview.backgroundColor = [UIColor clearColor];
	tableview.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
	tableview.delegate = self;
	tableview.dataSource = self;
	[self.view addSubview:tableview];
	
    if (@available(iOS 11.0, *)) {
        tableview.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }else{
    }
    
    
	[self setExtraCellLineHidden:tableview];
	
	UIButton *buttonsetting = [UIButton buttonWithType:UIButtonTypeCustom];
	buttonsetting.frame = CGRectMake(SCREEN_WIDTH-60, 42, 40, 40);
	[buttonsetting setTitle:@"设置" forState:UIControlStateNormal];
	[buttonsetting setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
	buttonsetting.titleLabel.font = FONTN(15.0f);
	[buttonsetting addTarget:self action:@selector(gotosetting:) forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview:buttonsetting];
    
    
}

-(void)viewheader
{
	UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 180)];
	
	MyPageHeaderView *focusnews = [[MyPageHeaderView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 180) DicFrom:FCdicuserpersoninfo];
	focusnews.delegate1 = self;
	[view addSubview:focusnews];
	
	//四个按钮
	tableview.tableHeaderView = view;
}

-(void)viewWillAppear:(BOOL)animated
{
    //获取用户信息
    if([AddInterface judgeislogin])
        [self getmypageinfo];
    else
       self.tabBarController.selectedIndex = 2;
	[[self.navigationController.navigationBar viewWithTag:EnNctlSearchViewTag] removeFromSuperview];
	[self.navigationController setNavigationBarHidden:YES animated:YES];
}

#pragma mark IBaction
-(void)gotosetting:(id)sender
{
	MyPageSettingViewController *mysetting = [[MyPageSettingViewController alloc] init];
	mysetting.hidesBottomBarWhenPushed = YES;
	[self.navigationController pushViewController:mysetting animated:YES];
}

#pragma mark ActionDelegate


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
	return [arrayitemlist count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	
	return 40;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[arrayitemlist objectAtIndex:section] count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
	if(section == 0)
		return 0.001;
	return 10;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
	if(section == 0)
		return nil;
	else
	{
		UIView *sectionview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10)];
		sectionview.backgroundColor = COLORNOW(235, 235, 235);
		return sectionview;
	}
	return nil;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	UITableViewCell *cell;
	static NSString *reuseIdetify = @"cell";
	if (!cell) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdetify];
		cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	}
	
	
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
	for(UIView *view in cell.contentView.subviews)
	{
		[view removeFromSuperview];
	}
	
	cell.backgroundColor = [UIColor whiteColor];
	
    NSDictionary *dictemp = [[arrayitemlist objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    
	UIImageView *imageicon = [[UIImageView alloc] initWithFrame:CGRectMake(20, 11, 18, 18)];
    NSString *strpic = [dictemp objectForKey:@"icon"];//[NSString stringWithFormat:@"%@%@",InterfaceResource,[dictemp objectForKey:@"icon"]];
    [imageicon setImageWithURL:[NSURL URLWithString:strpic]];
	[cell.contentView addSubview:imageicon];
	
	UILabel *labelname = [[UILabel alloc] initWithFrame:CGRectMake(XYViewR(imageicon)+10, 10, 150, 20)];
	labelname.backgroundColor = [UIColor clearColor];
	labelname.textColor = [UIColor blackColor];
    labelname.text = [dictemp objectForKey:@"name"];
	labelname.font = FONTN(15.0f);
	[cell.contentView addSubview:labelname];
	
	
	UILabel *labelnumber = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-100, 10, 70, 20)];
	labelnumber.backgroundColor = [UIColor clearColor];
	labelnumber.textColor = [UIColor blackColor];
	labelnumber.font = FONTMEDIUM(15.0f);
    if([[dictemp objectForKey:@"displayvalue"] length]>0)
    {
        labelnumber.text = [NSString stringWithFormat:@"%@",[dictemp objectForKey:@"displayvalue"]];
    }
	labelnumber.textAlignment = NSTextAlignmentRight;
	[cell.contentView addSubview:labelnumber];
    
	return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dictemp = [[arrayitemlist objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    if([[dictemp objectForKey:@"id"] isEqualToString:@"mytask"]) //我的扫码返利账户
    {
        MyTaskListViewController *mytask = [[MyTaskListViewController alloc] init];
        mytask.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:mytask animated:YES];
    }
    else if([[dictemp objectForKey:@"id"] isEqualToString:@"myfreeelectricalcheck"]) //免费检测
    {
        MyDetectListViewController *DetectList = [[MyDetectListViewController alloc] init];
        DetectList.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:DetectList animated:YES];
    }
    else if([[dictemp objectForKey:@"id"] isEqualToString:@"mymessage"]) //我的消息
    {
        MyMessageViewController *mymessage = [[MyMessageViewController alloc] init];
        mymessage.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:mymessage animated:YES];
    }
    else if([[dictemp objectForKey:@"id"] isEqualToString:@"myfocus"]) //我的关注
    {
        MyAttentionViewController *myattention = [[MyAttentionViewController alloc] init];
        myattention.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:myattention animated:YES];
    }
    else if([[dictemp objectForKey:@"id"] isEqualToString:@"myelectricallayout"]) //我的布线图
    {
        MyWiringDiagramViewController *WiringDiagram = [[MyWiringDiagramViewController alloc] init];
        WiringDiagram.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:WiringDiagram animated:YES];
    }
    else if([[dictemp objectForKey:@"id"] isEqualToString:@"aboutplatform"])  //关于我们
    {
        SwiftWebview * s1 = [[SwiftWebview alloc] init];
        s1.hidesBottomBarWhenPushed = YES;
        NSString *strurlnow = [NSString stringWithFormat:@"%@%@",[app.GBURLPreFix length]>0?app.GBURLPreFix:Interfacehtmlurlheader,HtmlURLAboutMeIns];
        s1.FCStrURL = strurlnow;
        s1.FCtitle = @"关于我们";
        [self.navigationController pushViewController:s1 animated:self];
    }
    else if([[dictemp objectForKey:@"id"] isEqualToString:@"platformhelp"])  //帮助中心
    {
        CustomQustionViewController *customquestion = [[CustomQustionViewController alloc] init];
        customquestion.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:customquestion animated:YES];
    }
	
}

#pragma mark 接口
-(void)getmypageinfo
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    [RequestInterface doGetJsonWithParametersNoAn:params App:app RequestCode:RQMyPageHpInfoCode ReqUrl:InterfaceRequestUrl ShowView:app.window alwaysdo:^{
        
    } Success:^(NSDictionary *dic) {
        DLog(@"dic====%@",dic);
        if([[dic objectForKey:@"success"] isEqualToString:@"true"])
        {
            arrayitemlist = [[dic objectForKey:@"data"] objectForKey:@"itemlist"];
            FCdicuserpersoninfo = [[dic objectForKey:@"data"] objectForKey:@"userpersoninfo"];
            tableview.delegate = self;
            tableview.dataSource = self;
            [tableview reloadData];
            [self viewheader];
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
