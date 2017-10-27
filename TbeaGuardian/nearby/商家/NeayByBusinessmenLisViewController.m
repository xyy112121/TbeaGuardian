//
//  NeayByBusinessmenLisViewController.m
//  TbeaGuardian
//
//  Created by xyy on 2017/9/19.
//  Copyright © 2017年 xyy. All rights reserved.
//

#import "NeayByBusinessmenLisViewController.h"

@interface NeayByBusinessmenLisViewController ()

@end

@implementation NeayByBusinessmenLisViewController

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
    
    UIView *contentViewright = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    UIButton *buttonright = [[UIButton alloc] initWithFrame:contentViewright.bounds];
    buttonright.titleLabel.font = FONTN(14.0f);
    buttonright.tag = 900;
    [buttonright setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    buttonright.imageEdgeInsets = UIEdgeInsetsMake(0,0, 0, -20);
    [buttonright setImage:LOADIMAGE(@"hpscanqr", @"png") forState:UIControlStateNormal];
    [buttonright addTarget:self action: @selector(hpscanqr:) forControlEvents: UIControlEventTouchUpInside];
    [contentViewright addSubview:buttonright];
    UIBarButtonItem *barButtonItemright = [[UIBarButtonItem alloc] initWithCustomView:contentViewright];
    
    UIView *contentViewright1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    UIButton *buttonright1 = [[UIButton alloc] initWithFrame:contentViewright1.bounds];
    buttonright1.titleLabel.font = FONTN(14.0f);
    buttonright1.tag = 900;
    [buttonright1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    buttonright1.imageEdgeInsets = UIEdgeInsetsMake(0,0, 0, -20);
    [buttonright1 setImage:LOADIMAGE(@"hp_searchiconwhite", @"png") forState:UIControlStateNormal];
    [buttonright1 addTarget:self action: @selector(gotosearch:) forControlEvents: UIControlEventTouchUpInside];
    [contentViewright1 addSubview:buttonright1];
    UIBarButtonItem *barButtonItemright1 = [[UIBarButtonItem alloc] initWithCustomView:contentViewright1];
    
    self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:barButtonItemright, barButtonItemright1, nil];;
    
    [self initview];
    // Do any additional setup after loading the view.
}

-(void)initview
{
    self.title = @"商家";
    self.view.backgroundColor = [UIColor whiteColor];//COLORNOW(235, 235, 235);
    app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    FCcompanytypeid = @"";
    FCorder = @"";
    FCorderitem = @"";
    tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-49)];
    tableview.backgroundColor = [UIColor clearColor];
    tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:tableview];
    [self setExtraCellLineHidden:tableview];
    
    
    [self getcompanytypelist];
    
    __weak __typeof(self) weakSelf = self;
    tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [weakSelf gethppagelist:@"1" PageSize:@"10"];
    }];
    
    tableview.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        
        [weakSelf gethppagelist:@"1" PageSize:[NSString stringWithFormat:@"%d",(int)[FCarraydata count]+10]];
    }];
    // 默认先隐藏footer
    tableview.mj_footer.hidden = YES;
    
    [self gethppagelist:@"1" PageSize:@"10"];
}

-(void)viewheader
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 180)];
    
    NearByBusinessmenHeaderView *focusnews = [[NearByBusinessmenHeaderView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 180) Focus:FCarrayfocus];
    focusnews.delegate1 = self;
    [view addSubview:focusnews];
    
    //四个按钮
    tableview.tableHeaderView = view;
}

-(UIView *)viewcellcommdity:(NSDictionary *)sender Frame:(CGRect)frame
{
    UIView *view = [[UIView alloc] initWithFrame:frame];
    
    UIImageView *imageview  = [[UIImageView alloc] initWithFrame:CGRectMake(20, 10, 80, 80)];
    NSString *strpic = [sender objectForKey:@"thumbpicture"];
    //    strpic = [InterfaceResource stringByAppendingString:[strpic length]>0?strpic:@"noimage.png"];
    [imageview setImageWithURL:[NSURL URLWithString:strpic] placeholderImage:LOADIMAGE(@"testpic", @"png")];
    imageview.contentMode = UIViewContentModeScaleAspectFill;
    imageview.clipsToBounds = YES;
    [view addSubview:imageview];
    
    CGSize size = [AddInterface getlablesize:[sender objectForKey:@"name"] Fwidth:SCREEN_WIDTH-140 Fheight:40 Sfont:FONTN(15.0f)];
    UILabel *labeltitle = [[UILabel alloc] initWithFrame:CGRectMake(XYViewR(imageview)+10,XYViewTop(imageview),size.width,size.height)];
    labeltitle.backgroundColor = [UIColor clearColor];
    labeltitle.textColor = [UIColor blackColor];
    labeltitle.font = FONTN(15.0f);
    labeltitle.text = [sender objectForKey:@"name"];
    [view addSubview:labeltitle];
    
    CGSize size1 = [AddInterface getlablesize:[sender objectForKey:@"description"] Fwidth:SCREEN_WIDTH-140 Fheight:40 Sfont:FONTN(16.0f)];
    UILabel *labelsummary = [[UILabel alloc] initWithFrame:CGRectMake(XYViewR(imageview)+10,XYViewBottom(labeltitle)+5,size1.width,size1.height)];
    labelsummary.backgroundColor = [UIColor clearColor];
    labelsummary.textColor = COLORNOW(117, 117, 117);
    labelsummary.font = FONTN(14.0f);
    labelsummary.text = [sender objectForKey:@"description"];
    [view addSubview:labelsummary];
    
    UILabel *labeldistance = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-150,XYViewBottom(imageview)-20,140,20)];
    labeldistance.backgroundColor = [UIColor clearColor];
    labeldistance.textColor = COLORNOW(117, 117, 117);
    labeldistance.font = FONTN(14.0f);
    labeldistance.textAlignment = NSTextAlignmentRight;
    labeldistance.text = [sender objectForKey:@"distance"];
    [view addSubview:labeldistance];
    
    return view;
}

#pragma mark UIviewcontrollerdelegate
-(void)viewWillAppear:(BOOL)animated
{
    [[self.navigationController.navigationBar viewWithTag:EnHpNavigationViewTag] removeFromSuperview];
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
-(void)clickselecttype:(id)sender
{
    ButtonItemLayoutView *buttonitem = [self.view viewWithTag:EnTbeaProductInstroduceSelect1];
    [buttonitem updatelablecolor:COLORNOW(0, 170, 236)];
    //	[buttonitem updateimage:LOADIMAGE(@"arrowblueunder", @"png")];
//    selectitem =EnTbeaProductSelectItem1;
    
    NSMutableArray *arrayspecial = [[NSMutableArray alloc] init];
    for(int i=0;i<[FCarraytype count];i++)
    {
        NSDictionary *dictemp = [FCarraytype objectAtIndex:i];
        [arrayspecial addObject:[dictemp objectForKey:@"name"]];
    }
    
    [ZJBLStoreShopTypeAlert showWithTitle:@"规格选择" titles:arrayspecial deleGate1:self selectIndex:^(NSInteger selectIndex) {
    } selectValue:^(NSString *selectValue) {
        DLog(@"selectvalue====%@",selectValue);
        FCcompanytypename = selectValue;
        FCcompanytypeid = [AddInterface returnselectid:FCarraytype SelectValue:selectValue];
    } showCloseButton:YES];

}

-(void)clickselectdistance:(id)sender
{
    FCorderitem = @"distance";
    ButtonItemLayoutView *buttonitem1 = [self.view viewWithTag:EnWaterMettingSelectItembt2];
    if([FCorder isEqualToString:@""])
    {
        FCorder= @"desc";
        [buttonitem1 updatelablecolor:COLORNOW(0, 170, 236)];
        [buttonitem1 updateimage:LOADIMAGE(@"arrawbluegray", @"png")];
    }
    else if([FCorder isEqualToString:@"desc"])
    {
        FCorder= @"asc";
        [buttonitem1 updatelablecolor:COLORNOW(0, 170, 236)];
        [buttonitem1 updateimage:LOADIMAGE(@"arrawgrayblue", @"png")];
    }
    else
    {
        FCorder= @"desc";
        [buttonitem1 updatelablecolor:COLORNOW(0, 170, 236)];
        [buttonitem1 updateimage:LOADIMAGE(@"arrawbluegray", @"png")];
    }
    [self gethppagelist:@"1" PageSize:@"10"];

}

-(void)gotosearch:(id)sender
{
    
}

-(void)hpscanqr:(id)sender
{
    
}

-(void)returnback
{
    [self.navigationController popViewControllerAnimated:YES];
}



#pragma mark ActionDelegate
-(void)DGClickselectItemDone:(id)sender
{
    [self gethppagelist:@"1" PageSize:@"10"];
}

-(void)DGFocusClickNumberPic:(id)sender
{
    
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
    return 100;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [FCarraydata count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if(section == 0)
    {
        UIView *viewheader = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
        viewheader.backgroundColor = [UIColor whiteColor];
        
        float widthnow = (SCREEN_WIDTH-20)/2;
        //类型
        ButtonItemLayoutView *buttontype = [[ButtonItemLayoutView alloc] initWithFrame:CGRectMake(10, 0, widthnow, 40)];
        [buttontype.button addTarget:self action:@selector(clickselecttype:) forControlEvents:UIControlEventTouchUpInside];
        buttontype.tag = EnWaterMettingSelectItembt1;
        [buttontype updatebuttonitem:EnButtonTextLeft TextStr:@"类型" Font:FONTN(14.0f) Color:COLORNOW(177,177, 177) Image:LOADIMAGE(@"arrowgrayunder", @"png")];
        [viewheader addSubview:buttontype];

        
        //距离
        ButtonItemLayoutView *buttondistance = [[ButtonItemLayoutView alloc] initWithFrame:CGRectMake(10+widthnow, 0, widthnow, 40)];
        [buttondistance.button addTarget:self action:@selector(clickselectdistance:) forControlEvents:UIControlEventTouchUpInside];
        buttondistance.tag = EnWaterMettingSelectItembt2;
        
        [buttondistance updatebuttonitem:EnButtonTextRight TextStr:@"距离" Font:FONTN(14.0f) Color:COLORNOW(177, 177, 177) Image:LOADIMAGE(@"arrawgray", @"png")];
        if([FCorder isEqualToString:@"desc"])
            [buttondistance updatebuttonitem:EnButtonTextRight TextStr:@"距离" Font:FONTN(14.0f) Color:COLORNOW(0, 170, 238) Image:LOADIMAGE(@"arrawgrayblue", @"png")];
        else if([FCorder isEqualToString:@"asc"])
            [buttondistance updatebuttonitem:EnButtonTextRight TextStr:@"距离" Font:FONTN(14.0f) Color:COLORNOW(0, 170, 238) Image:LOADIMAGE(@"arrawbluegray", @"png")];
        [viewheader addSubview:buttondistance];
        
        UIImageView *imageline = [[UIImageView alloc] initWithFrame:CGRectMake(0, 39, SCREEN_WIDTH, 0.7)];
        imageline.backgroundColor = COLORNOW(210, 210, 210);
        [viewheader addSubview:imageline];
        
        return viewheader;
    }
    return nil;
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
    [cell.contentView addSubview:[self viewcellcommdity:dictemp Frame:CGRectMake(0, 0, SCREEN_WIDTH, 100)]];
    
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dictemp = [FCarraydata objectAtIndex:indexPath.row];
    NearByStoreGoodsPageViewController *nearby = [[NearByStoreGoodsPageViewController alloc] init];
    nearby.FCcompanyid = [dictemp objectForKey:@"id"];
    [self.navigationController pushViewController:nearby animated:YES];
}

#pragma mark 接口

-(void)getcompanytypelist
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    [RequestInterface doGetJsonWithParametersNoAn:params App:app RequestCode:RQNearByBusinessmenCompanyType ReqUrl:InterfaceRequestUrl ShowView:app.window alwaysdo:^{
        
    } Success:^(NSDictionary *dic) {
        DLog(@"dic====%@",dic);
        if([[dic objectForKey:@"success"] isEqualToString:@"true"])
        {
            FCarraytype   = [[dic objectForKey:@"data"] objectForKey:@"companytypelist"];
        }
        else
        {
            [MBProgressHUD showError:[dic objectForKey:@"msg"] toView:app.window];
        }
    } Failur:^(NSString *strmsg) {
        [MBProgressHUD showError:@"请求失败,请检查网络" toView:self.view];
        
    }];
}


-(void)gethppagelist:(NSString *)page PageSize:(NSString *)pagesize
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"companytypeid"] = FCcompanytypeid;
    params[@"orderitem"] = FCorderitem;
    params[@"order"] = FCorder;
    params[@"page"] = page;
    params[@"pagesize"] = pagesize;
    
    
    [RequestInterface doGetJsonWithParametersNoAn:params App:app RequestCode:RQNearByBusinessmenListCode ReqUrl:InterfaceRequestUrl ShowView:app.window alwaysdo:^{
        
    } Success:^(NSDictionary *dic) {
        DLog(@"dic====%@",dic);
        if([[dic objectForKey:@"success"] isEqualToString:@"true"])
        {
            FCarrayfocus   = [[dic objectForKey:@"data"] objectForKey:@"advertiselist"];
            FCarraydata = [[dic objectForKey:@"data"] objectForKey:@"companylist"];
            tableview.delegate = self;
            tableview.dataSource = self;
            [tableview reloadData];
            [self viewheader];
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
