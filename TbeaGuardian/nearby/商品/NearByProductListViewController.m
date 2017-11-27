//
//  NearByProductListViewController.m
//  TbeaGuardian
//
//  Created by xyy on 2017/10/9.
//  Copyright © 2017年 xyy. All rights reserved.
//

#import "NearByProductListViewController.h"

@interface NearByProductListViewController ()

@end

@implementation NearByProductListViewController

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
    tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:tableview];
    
    [self setExtraCellLineHidden:tableview];
    
    __weak __typeof(self) weakSelf = self;
    tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf getproductlist:@"1" PageSize:@"10"];
    }];
    
    tableview.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [weakSelf getproductlist:@"1" PageSize:[NSString stringWithFormat:@"%d",(int)[FCarraydata count]+10]];

    }];
    // 默认先隐藏footer
    
    tableview.mj_footer.hidden = YES;
    
    [self getproductlist:@"1" PageSize:@"10"];
    
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
    
    SearchNavigateView *navi = [[SearchNavigateView alloc] initWithFrame:CGRectMake(50,0, SCREEN_WIDTH-50, 44) FromFlag:@"2"]; //传2表示是商品列表页
    navi.tag = EnHpNavigationViewTag1;
    navi.delegate1 = self;
    [self.navigationController.navigationBar addSubview:navi];
}

#pragma mark 全部商品列表
-(UIView *)viewcellcommdity:(NSDictionary *)sender Frame:(CGRect)frame
{
    UIView *view = [[UIView alloc] initWithFrame:frame];
    
    UIImageView *imageview  = [[UIImageView alloc] initWithFrame:CGRectMake(20, 10, 100, 100)];
    NSString *strpic = [sender objectForKey:@"thumbpicture"];
    //    strpic = [InterfaceResource stringByAppendingString:[strpic length]>0?strpic:@"noimage.png"];
    [imageview setImageWithURL:[NSURL URLWithString:strpic] placeholderImage:LOADIMAGE(@"testpic", @"png")];
    imageview.contentMode = UIViewContentModeScaleAspectFill;
    imageview.clipsToBounds = YES;
    [view addSubview:imageview];
    
    CGSize size = [AddInterface getlablesize:[sender objectForKey:@"commodityname"] Fwidth:SCREEN_WIDTH-140 Fheight:40 Sfont:FONTN(15.0f)];
    UILabel *labeltitle = [[UILabel alloc] initWithFrame:CGRectMake(XYViewR(imageview)+10,XYViewTop(imageview),size.width,size.height)];
    labeltitle.backgroundColor = [UIColor clearColor];
    labeltitle.textColor = [UIColor blackColor];
    labeltitle.font = FONTN(15.0f);
    labeltitle.text = [sender objectForKey:@"commodityname"];
    labeltitle.numberOfLines = 2;
    [view addSubview:labeltitle];
    
    UILabel *lablemoneyflag = [[UILabel alloc] initWithFrame:CGRectMake(XYViewL(labeltitle), XYViewBottom(imageview)-16, 10,10)];
    lablemoneyflag.text = @"￥";
    lablemoneyflag.font = FONTMEDIUM(12.0f);
    lablemoneyflag.textColor = [UIColor redColor];
    lablemoneyflag.backgroundColor = [UIColor clearColor];
    [view addSubview:lablemoneyflag];
    
    size = [AddInterface getlablesize:[NSString stringWithFormat:@"%@",[sender objectForKey:@"price"]] Fwidth:150 Fheight:20 Sfont:FONTMEDIUM(17.0f)];
    UILabel *lablemoneyvalue = [[UILabel alloc] initWithFrame:CGRectMake(XYViewR(lablemoneyflag)+1, XYViewBottom(imageview)-20, size.width, 20)];
    lablemoneyvalue.text = [NSString stringWithFormat:@"%@",[sender objectForKey:@"price"]];
    lablemoneyvalue.font = FONTMEDIUM(17.0f);
    lablemoneyvalue.textColor = [UIColor redColor];
    lablemoneyvalue.backgroundColor = [UIColor clearColor];
    [view addSubview:lablemoneyvalue];
    
    UILabel *labelpingjia = [[UILabel alloc] initWithFrame:CGRectMake(XYViewR(imageview)+10,XYViewTop(lablemoneyvalue)-23,120,20)];
    labelpingjia.backgroundColor = [UIColor clearColor];
    labelpingjia.textColor = COLORNOW(117, 117, 117);
    labelpingjia.font = FONTN(13.0f);
    labelpingjia.text = [NSString stringWithFormat:@"%@评价",[sender objectForKey:@"appaisenumber"]];
    [view addSubview:labelpingjia];
    
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

#pragma mark ActionDelegate
-(void)DGSelectGoodsItemSort:(NSString *)order OrderItem:(NSString *)orderitem
{
    FCorder = order;
    FCorderitem = orderitem;
    [self getproductlist:@"1" PageSize:@"10"];
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
    return 120;
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
    if(goodsitemheader == nil)
    {
        goodsitemheader = [[NearByStoreGoodsitemHeader alloc] initWithFrame:CGRectMake(0, 5, SCREEN_WIDTH, 40) DicFrom:nil SelectItem:EnStorePageSlectGoods GoodSSelectItem:EnStoreGOodsPageRecommand];
        goodsitemheader.delegate1 = self;
    }
    [view addSubview:goodsitemheader];
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
    UIView *view = [self viewcellcommdity:dictemp Frame:CGRectMake(0, 0, SCREEN_WIDTH, 120)];
    [cell.contentView addSubview:view];

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dictemp = [FCarraydata objectAtIndex:indexPath.row];
    NearByProductDetailViewController *productdetail = [[NearByProductDetailViewController alloc] init];
    productdetail.FCdicproduct = dictemp;
    [self.navigationController pushViewController:productdetail animated:YES];
}

#pragma mark 接口
-(void)getproductlist:(NSString *)page PageSize:(NSString *)pagesize
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"commoditycategoryid"] = FCcommoditycategoryid;
    params[@"orderitem"] = FCorderitem;
    params[@"order"] = FCorder;
    params[@"page"] = page;
    params[@"pagesize"] = pagesize;
    
    
    [RequestInterface doGetJsonWithParametersNoAn:params App:app RequestCode:RQNearByProductAllCommidityCode ReqUrl:InterfaceRequestUrl ShowView:app.window alwaysdo:^{
        
    } Success:^(NSDictionary *dic) {
        DLog(@"dic====%@",dic);
        if([[dic objectForKey:@"success"] isEqualToString:@"true"])
        {
            FCarrayfocus = [[dic objectForKey:@"data"] objectForKey:@"advertiselist"];
            FCarraydata = [[dic objectForKey:@"data"] objectForKey:@"commoditylist"];
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
