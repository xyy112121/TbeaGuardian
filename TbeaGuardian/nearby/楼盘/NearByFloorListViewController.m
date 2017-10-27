//
//  NearByFloorListViewController.m
//  TbeaGuardian
//
//  Created by xyy on 2017/10/11.
//  Copyright © 2017年 xyy. All rights reserved.
//

#import "NearByFloorListViewController.h"

@interface NearByFloorListViewController ()

@end

@implementation NearByFloorListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)])
    {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(-20, 0, 40, 40)];
    contentView.backgroundColor = [UIColor clearColor];
    UIButton *button = [[UIButton alloc] initWithFrame:contentView.bounds];
    button.layer.borderColor = [UIColor clearColor].CGColor;
    button.backgroundColor = [UIColor clearColor];
    [button setImage:LOADIMAGE(@"returnback", @"png") forState:UIControlStateNormal];
    button.imageEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
    [button addTarget:self action: @selector(returnback) forControlEvents: UIControlEventTouchUpInside];
    [contentView addSubview:button];
    UIBarButtonItem *nagetiveSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                                                                   target:nil action:nil];
    nagetiveSpacer.width = -20;//这个值可以根据自己需要自己调整
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:contentView];
    self.navigationItem.leftBarButtonItems = @[nagetiveSpacer, barButtonItem];
    
    [self initview];
    // Do any additional setup after loading the view.
}

-(void)initview
{
    self.view.backgroundColor = [UIColor whiteColor];
    
    app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    FCorderitem = @"";
    FCorder = @"";
    
    tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64)];
    tableview.backgroundColor = [UIColor clearColor];
    tableview.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [self.view addSubview:tableview];
    
    [self setExtraCellLineHidden:tableview];
    
    __weak __typeof(self) weakSelf = self;
    tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf getfloorlist:@"1" PageSize:@"10"];
    }];
    
    tableview.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [weakSelf getfloorlist:@"1" PageSize:[NSString stringWithFormat:@"%d",(int)[FCarraydata count]+10]];
        
    }];
    // 默认先隐藏footer
    
    tableview.mj_footer.hidden = YES;
    
    [self getfloorlist:@"1" PageSize:@"10"];
    
}

-(void)inittableviewheader
{
    UIView *view = [self initloop:FCarrayfocus];
    tableview.tableHeaderView = view;
}

-(void)viewWillAppear:(BOOL)animated
{
    [[self.navigationController.navigationBar viewWithTag:EnHpNavigationViewTag] removeFromSuperview];
    [[self.navigationController.navigationBar viewWithTag:EnHpNavigationViewTag1] removeFromSuperview];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.navigationController.navigationBar.translucent = NO;
    [self.navigationController.navigationBar  setBackgroundImage:[[UIImage alloc] init] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    [self.navigationController.navigationBar setBarTintColor:COLORNOW(0, 170, 238)];
    UIColor* color = [UIColor whiteColor];
    NSDictionary* dict=[NSDictionary dictionaryWithObject:color forKey:NSForegroundColorAttributeName];
    self.navigationController.navigationBar.titleTextAttributes= dict;
    
    [[self.navigationController.navigationBar viewWithTag:EnHpNavigationViewTag1] removeFromSuperview];
    SearchNavigateView *navi = [[SearchNavigateView alloc] initWithFrame:CGRectMake(50,0, SCREEN_WIDTH-50, 44) FromFlag:@"4"]; //传2表示是商品列表页
    navi.tag = EnHpNavigationViewTag1;
    navi.delegate1 = self;
    [self.navigationController.navigationBar addSubview:navi];
}

#pragma mark 全部水电工列表
-(UIView *)viewcellwaterelec:(NSDictionary *)sender Frame:(CGRect)frame
{
    UIView *view = [[UIView alloc] initWithFrame:frame];
    
    UIImageView *imageview  = [[UIImageView alloc] initWithFrame:CGRectMake(20, 10, 60, 60)];
    NSString *strpic = [sender objectForKey:@"thumbpicture"];
    [imageview setImageWithURL:[NSURL URLWithString:strpic] placeholderImage:LOADIMAGE(@"testpic", @"png")];
    imageview.contentMode = UIViewContentModeScaleAspectFill;
    imageview.clipsToBounds = YES;
    [view addSubview:imageview];
    
    UILabel *labeltitle = [[UILabel alloc] initWithFrame:CGRectMake(XYViewR(imageview)+10,XYViewTop(imageview),150,20)];
    labeltitle.backgroundColor = [UIColor clearColor];
    labeltitle.textColor = [UIColor blackColor];
    labeltitle.font = FONTB(16.0f);
    labeltitle.text = [sender objectForKey:@"buildingzonename"];
    [view addSubview:labeltitle];
    
    UILabel *lablemoneyvalue = [[UILabel alloc] initWithFrame:CGRectMake(XYViewL(labeltitle), XYViewBottom(labeltitle), SCREEN_WIDTH-100, 20)];
    lablemoneyvalue.text = [NSString stringWithFormat:@"%@",[sender objectForKey:@"address"]];
    lablemoneyvalue.font = FONTN(14.0f);
    lablemoneyvalue.textColor = COLORNOW(117, 117, 117);
    lablemoneyvalue.backgroundColor = [UIColor clearColor];
    [view addSubview:lablemoneyvalue];
    
    UILabel *labeleyear = [[UILabel alloc] initWithFrame:CGRectMake(XYViewL(lablemoneyvalue),XYViewBottom(lablemoneyvalue),150,20)];
    labeleyear.backgroundColor = [UIColor clearColor];
    labeleyear.textColor = COLORNOW(117, 117, 117);
    labeleyear.font = FONTN(14.0f);
    labeleyear.text = [NSString stringWithFormat:@"入驻水电工:%@人",[sender objectForKey:@"electriciannumber"]];
    [view addSubview:labeleyear];
    
    UILabel *labeledistance = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-150,XYViewBottom(imageview)-18,140,18)];
    labeledistance.backgroundColor = [UIColor clearColor];
    labeledistance.textColor = COLORNOW(117, 117, 117);
    labeledistance.font = FONTN(14.0f);
    labeledistance.textAlignment = NSTextAlignmentRight;
    labeledistance.text = [NSString stringWithFormat:@"%@",[sender objectForKey:@"distance"]];
    [view addSubview:labeledistance];
    
    
    
    return view;
}

#pragma mark 循环滚动图片
-(UIView *)initloop:(NSArray *)arrayfocus
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 160)];
    
    NSMutableArray *arraypiclist =  [[NSMutableArray alloc] init];
    for(int i=0;i<[arrayfocus count];i++)
    {
        NSDictionary *dictemp = [arrayfocus objectAtIndex:i];
        NSString *strpic = [dictemp objectForKey:@"picture"];
        [arraypiclist addObject:[strpic length]>0?strpic:@"123"];
    }
    
    loop = [[XLsn0wLoop alloc] initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH, 160)];
    [view addSubview:loop];
    loop.xlsn0wDelegate = self;
    loop.time = 5;
    [loop setPagePosition:PositionBottomCenter];
    [loop setPageColor:Colorredcolor andCurrentPageColor:[UIColor whiteColor]];
    //支持gif动态图
    loop.imageArray = arraypiclist;
    
    return view;
}

#pragma mark XRCarouselViewDelegate
- (void)loopView:(XLsn0wLoop *)loopView clickImageAtIndex:(NSInteger)index {
    NSLog(@"点击了第%ld张图片", index);
    
    //    if([self.delegate1 respondsToSelector:@selector(DGFocusClickNumberPic:)])
    //    {
    //        //    NSArray *focus = [dicfocus objectForKey:@"list"];
    //        [self.delegate1 DGFocusClickNumberPic:@""];
    //    }
}

-(void)changepicdescript:(int)currentindex
{
    
}

#pragma mark ActionDelegate
-(void)DGSelectGoodsItemSort:(NSString *)order OrderItem:(NSString *)orderitem
{
    FCorder = order;
    FCorderitem = orderitem;
    [self getfloorlist:@"1" PageSize:@"10"];
}

#pragma mark IBAction
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
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [FCarraydata count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 45;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 45)];
    view.backgroundColor = COLORNOW(235, 235, 235);
    if(waterelecitemheader == nil)
    {
        waterelecitemheader = [[NearByWaterElecitemHeader alloc] initWithFrame:CGRectMake(0, 5, SCREEN_WIDTH, 40) DicFrom:nil];
        waterelecitemheader.delegate1 = self;
    }
    [view addSubview:waterelecitemheader];
    return view;
    
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
    
    NSDictionary *dictemp = [FCarraydata objectAtIndex:indexPath.row];
    UIView *view = [self viewcellwaterelec:dictemp Frame:CGRectMake(0, 0, SCREEN_WIDTH, 80)];
    [cell.contentView addSubview:view];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dictemp = [FCarraydata objectAtIndex:indexPath.row];
    NearByFloorDetailViewController *waterelec = [[NearByFloorDetailViewController alloc] init];
    waterelec.FCbuildingzoneid = [dictemp objectForKey:@"buildingzoneid"];
    [self.navigationController pushViewController:waterelec animated:YES];
}

#pragma mark 接口
-(void)getfloorlist:(NSString *)page PageSize:(NSString *)pagesize
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"orderitem"] = FCorderitem;
    params[@"order"] = FCorder;
    params[@"page"] = page;
    params[@"pagesize"] = pagesize;
    
    
    [RequestInterface doGetJsonWithParametersNoAn:params App:app RequestCode:RQNearByFloorListCode ReqUrl:InterfaceRequestUrl ShowView:app.window alwaysdo:^{
        
    } Success:^(NSDictionary *dic) {
        DLog(@"dic====%@",dic);
        if([[dic objectForKey:@"success"] isEqualToString:@"true"])
        {
            FCarrayfocus = [[dic objectForKey:@"data"] objectForKey:@"advertiselist"];
            FCarraydata = [[dic objectForKey:@"data"] objectForKey:@"buildingzonelist"];
            [self inittableviewheader];
            tableview.delegate = self;
            tableview.dataSource = self;
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
