//
//  MyDetectDetailQualifiedViewController.m
//  TbeaGuardian
//
//  Created by xyy on 2017/9/17.
//  Copyright © 2017年 xyy. All rights reserved.
//

#import "MyDetectDetailQualifiedViewController.h"

@interface MyDetectDetailQualifiedViewController ()

@end

@implementation MyDetectDetailQualifiedViewController

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
    self.title = @"检测详情";
    app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-49)];
    tableview.backgroundColor = [UIColor clearColor];
    tableview.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [self.view addSubview:tableview];
    [self viewheader];
    [self setExtraCellLineHidden:tableview];
    
    [self getmydetectdetail];
}

-(void)viewheader
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 50)];
    
    float nowwidth = (SCREEN_WIDTH-20)/7;
    
    UILabel *labelfunction = [[UILabel alloc] initWithFrame:CGRectMake(10, 15, nowwidth*4, 20)];
    labelfunction.backgroundColor = [UIColor clearColor];
    labelfunction.textColor = [UIColor blackColor];
    labelfunction.text = @"检测项目";
    labelfunction.clipsToBounds = YES;
    labelfunction.font = FONTB(16.0f);
    [view addSubview:labelfunction];

    
    UILabel *labelqualified = [[UILabel alloc] initWithFrame:CGRectMake(10+nowwidth*4, 15, nowwidth, 20)];
    labelqualified.backgroundColor = [UIColor clearColor];
    labelqualified.textColor = [UIColor blackColor];
    labelqualified.text = @"合格";
    labelqualified.clipsToBounds = YES;
    labelqualified.textAlignment = NSTextAlignmentCenter;
    labelqualified.font = FONTB(16.0f);
    [view addSubview:labelqualified];
    
    UILabel *labelnotqualified = [[UILabel alloc] initWithFrame:CGRectMake(10+nowwidth*5, 15, nowwidth, 20)];
    labelnotqualified.backgroundColor = [UIColor clearColor];
    labelnotqualified.textColor = [UIColor blackColor];
    labelnotqualified.text = @"不合格";
    labelnotqualified.clipsToBounds = YES;
    labelnotqualified.textAlignment = NSTextAlignmentCenter;
    labelnotqualified.font = FONTB(16.0f);
    [view addSubview:labelnotqualified];
    
    UILabel *labelneedmodify = [[UILabel alloc] initWithFrame:CGRectMake(10+nowwidth*6, 15, nowwidth, 20)];
    labelneedmodify.backgroundColor = [UIColor clearColor];
    labelneedmodify.textColor = [UIColor blackColor];
    labelneedmodify.text = @"需要攺";
    labelneedmodify.clipsToBounds = YES;
    labelneedmodify.textAlignment = NSTextAlignmentCenter;
    labelneedmodify.font = FONTB(16.0f);
    [view addSubview:labelneedmodify];
    
    UIImageView *imageline = [[UIImageView alloc] initWithFrame:CGRectMake(0,49, SCREEN_WIDTH, 1.0)];
    imageline.backgroundColor = COLORNOW(230, 230, 230);
    [view addSubview:imageline];
    
    //四个按钮
    tableview.tableHeaderView = view;
}



-(void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
    self.navigationController.navigationBar.translucent = NO;
    [self.navigationController.navigationBar  setBackgroundImage:[[UIImage alloc] init] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    [self.navigationController.navigationBar setBarTintColor:COLORNOW(0, 170, 238)];
    UIColor* color = [UIColor whiteColor];
    NSDictionary* dict=[NSDictionary dictionaryWithObject:color forKey:NSForegroundColorAttributeName];
    self.navigationController.navigationBar.titleTextAttributes= dict;
}

-(void)initfootview
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 60)];
    
    UIImageView *imageline = [AddCustomView CusViewLine:CGRectMake(0, 0, SCREEN_WIDTH, 1) BGColor:COLORNOW(230, 230, 230)];
    [view addSubview:imageline];
    
    UILabel *labdes = [AddCustomView CusViewLabelForStyle:CGRectMake(10, 10, SCREEN_WIDTH-20, 40) BGColor:[UIColor clearColor] Title:[NSString stringWithFormat:@"备注信息:%@",FCdescription] TColor:[UIColor blackColor] Font:FONTN(15.0f) LineNumber:2];
    [view addSubview:labdes];
    tableview.tableFooterView = view;
    
}

#pragma mark IBaction

-(void)returnback
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)savesonaccount:(id)sender
{
    if([self.delegate1 respondsToSelector:@selector(DGSaveSonAccountFunctionAuthorList:)])
    {
        [self.delegate1 DGSaveSonAccountFunctionAuthorList:_FCarrayauthor];
    }
    [self.navigationController popViewControllerAnimated:YES];
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
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 50;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [FCelectricalcheckworklist count];
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
    
    NSDictionary *dictemp = [FCelectricalcheckworklist objectAtIndex:indexPath.row];
    float nowwidth = (SCREEN_WIDTH-20)/7;
    UILabel *labelname = [[UILabel alloc] initWithFrame:CGRectMake(10, 15, nowwidth*4, 20)];
    labelname.backgroundColor = [UIColor clearColor];
    labelname.textColor = [UIColor blackColor];
    labelname.text = [dictemp objectForKey:@"checkitem"];
    labelname.font = FONTN(15.0f);
    [cell.contentView addSubview:labelname];
    
    UIButton *buttonqualified = [UIButton buttonWithType:UIButtonTypeCustom];
    [buttonqualified setImage:LOADIMAGE(@"menotselectgray", @"png") forState:UIControlStateNormal];
    buttonqualified.frame = CGRectMake(10+nowwidth*4, 10, nowwidth, 30);
    [buttonqualified setBackgroundColor:[UIColor clearColor]];
    [cell.contentView addSubview:buttonqualified];
    
    UIButton *buttonunqualified = [UIButton buttonWithType:UIButtonTypeCustom];
    [buttonunqualified setImage:LOADIMAGE(@"menotselectgray", @"png") forState:UIControlStateNormal];
    buttonunqualified.frame = CGRectMake(10+nowwidth*5, 10, nowwidth, 30);
    [buttonunqualified setBackgroundColor:[UIColor clearColor]];
    [cell.contentView addSubview:buttonunqualified];
    
    UIButton *buttonneedfix = [UIButton buttonWithType:UIButtonTypeCustom];
    [buttonneedfix setImage:LOADIMAGE(@"menotselectgray", @"png") forState:UIControlStateNormal];
    buttonneedfix.frame = CGRectMake(10+nowwidth*6, 10, nowwidth, 30);
    [buttonneedfix setBackgroundColor:[UIColor clearColor]];
    [cell.contentView addSubview:buttonneedfix];
    
    if([[dictemp objectForKey:@"checkresult"] isEqualToString:@"qualified"])
        [buttonqualified setImage:LOADIMAGE(@"me默认收货地址", @"png") forState:UIControlStateNormal];
    else if([[dictemp objectForKey:@"checkresult"] isEqualToString:@"unqualified"])
        [buttonqualified setImage:LOADIMAGE(@"me默认收货地址", @"png") forState:UIControlStateNormal];
    else
        [buttonneedfix setImage:LOADIMAGE(@"me默认收货地址", @"png") forState:UIControlStateNormal];
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma mark 接口
-(void)getmydetectdetail
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"checkresultid"] = _FCCheckResultId;
    
    
    [RequestInterface doGetJsonWithParametersNoAn:params App:app RequestCode:RQMyDetectDetailQualifiedCode ReqUrl:InterfaceRequestUrl ShowView:app.window alwaysdo:^{
        
    } Success:^(NSDictionary *dic) {
        DLog(@"dic====%@",dic);
        if([[dic objectForKey:@"success"] isEqualToString:@"true"])
        {
            FCelectricalcheckworklist = [[dic objectForKey:@"data"] objectForKey:@"electricalcheckworklist"];
            FCdescription = [[[dic objectForKey:@"data"] objectForKey:@"checkdescriptioninfo"] objectForKey:@"description"];
            tableview.delegate = self;
            tableview.dataSource = self;
            [self initfootview];
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
