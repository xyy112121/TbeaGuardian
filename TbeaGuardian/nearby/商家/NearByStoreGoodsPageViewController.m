//
//  NearByStoreGoodsPageViewController.m
//  TbeaGuardian
//
//  Created by xyy on 2017/9/20.
//  Copyright © 2017年 xyy. All rights reserved.
//

#import "NearByStoreGoodsPageViewController.h"

@interface NearByStoreGoodsPageViewController ()

@end

@implementation NearByStoreGoodsPageViewController

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
    self.title = @"";
    enstoreselectitems = EnStorePageSlectStore;
    FCorderitem = @"";
    FCorder = @"";
    FCorderitemRecommend = @"";
    FCorderitemTime = @"";
    FCorderitemPrice = @"";
    FCorderitemSaleNumber = @"";
    FCcommoditycategoryid = @"";
    enstoregoodsselectitem = EnStoreGOodsPageRecommand;
    arrayheight = [[NSMutableArray alloc] init];
    
    tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64)];
    tableview.backgroundColor = [UIColor clearColor];
    tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:tableview];
    
    [self setExtraCellLineHidden:tableview];
    [self getwateruserhome];
    
    __weak __typeof(self) weakSelf = self;
    tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        if(enstoreselectitems == EnStorePageSlectStore)
            [weakSelf getstorelist:@"1" PageSize:@"10"];
        else if(enstoreselectitems == EnStorePageSlectGoods)
            [weakSelf getcommiditylist:@"1" PageSize:@"10"];
        else if(enstoreselectitems == EnStorePageActivity)
            [weakSelf getactivitylist:@"1" PageSize:@"10"];
    }];
    
    tableview.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        
        if(enstoreselectitems == EnStorePageSlectStore)
            [weakSelf getstorelist:@"1" PageSize:[NSString stringWithFormat:@"%d",(int)[FCarraydata count]+10]];
        else if(enstoreselectitems == EnStorePageSlectGoods)
            [weakSelf getcommiditylist:@"1" PageSize:[NSString stringWithFormat:@"%d",(int)[FCarraydata count]+10]];
        else if(enstoreselectitems == EnStorePageActivity)
            [weakSelf getactivitylist:@"1" PageSize:[NSString stringWithFormat:@"%d",(int)[FCarraydata count]+10]];
    }];
    // 默认先隐藏footer

    tableview.mj_footer.hidden = YES;
    
    [self getstorelist:@"1" PageSize:@"10"];
}

-(void)addtabviewheader
{
    WaterPersonHpHeaderView *waterheader = [[WaterPersonHpHeaderView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 210) DicFrom:FCdicuserinfo];
    waterheader.delegate1 = self;
    tableview.tableHeaderView = waterheader;
}

#pragma mark 动态列表布局
-(UIView *)activitycellview:(NSDictionary *)sender Frame:(CGRect)frame
{
    UIView *view = [[UIView alloc] initWithFrame:frame];
    
    view.backgroundColor = COLORNOW(235, 235, 235);
    
    UIImageView *imagebg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, frame.size.height-5)];
    imagebg.backgroundColor = [UIColor whiteColor];
    [view addSubview:imagebg];
    
    UIImageView *imageview  = [[UIImageView alloc] initWithFrame:CGRectMake(20, 10, 40, 40)];
    NSString *strpic = [sender objectForKey:@"thumbpicture"];
    [imageview setImageWithURL:[NSURL URLWithString:strpic] placeholderImage:LOADIMAGE(@"testpic", @"png")];
    imageview.contentMode = UIViewContentModeScaleAspectFill;
    imageview.clipsToBounds = YES;
    [view addSubview:imageview];
    
    UILabel *labelcompanyname = [[UILabel alloc] initWithFrame:CGRectMake(XYViewR(imageview)+10,XYViewTop(imageview),SCREEN_WIDTH-75,20)];
    labelcompanyname.backgroundColor = [UIColor clearColor];
    labelcompanyname.textColor = [UIColor blackColor];
    labelcompanyname.font = FONTN(15.0f);
    labelcompanyname.text = [sender objectForKey:@"companyname"];
    [view addSubview:labelcompanyname];
    
    UILabel *labeltime = [[UILabel alloc] initWithFrame:CGRectMake(XYViewL(labelcompanyname),XYViewBottom(labelcompanyname),SCREEN_WIDTH-120,20)];
    labeltime.backgroundColor = [UIColor clearColor];
    labeltime.textColor = COLORNOW(117, 117, 117);
    labeltime.font = FONTN(15.0f);
    labeltime.text = [sender objectForKey:@"publishtime"];
    [view addSubview:labeltime];
    
    float nowheight = XYViewBottom(imageview)+10;
    
    CGSize size = [AddInterface getlablesize:[sender objectForKey:@"title"] Fwidth:SCREEN_WIDTH-80 Fheight:100 Sfont:FONTN(15.0f)];
    UILabel *labeltitle = [[UILabel alloc] initWithFrame:CGRectMake(XYViewL(labelcompanyname),nowheight,size.width,size.height)];
    labeltitle.backgroundColor = [UIColor clearColor];
    labeltitle.textColor = [UIColor blackColor];
    labeltitle.font = FONTN(15.0f);
    labeltitle.text = [sender objectForKey:@"title"];
    labeltitle.numberOfLines = 0;
    [view addSubview:labeltitle];
    
    nowheight = nowheight+size.height+10;
    
    if([[sender objectForKey:@"newsthumbpicture"] length]>0)
    {
        UIImageView *imageviewpic  = [[UIImageView alloc] initWithFrame:CGRectMake(XYViewL(labelcompanyname), nowheight, 100, 100)];
        NSString *strpic = [sender objectForKey:@"newsthumbpicture"];
        [imageviewpic setImageWithURL:[NSURL URLWithString:strpic] placeholderImage:LOADIMAGE(@"testpic", @"png")];
        imageviewpic.contentMode = UIViewContentModeScaleAspectFill;
        imageviewpic.clipsToBounds = YES;
        [view addSubview:imageviewpic];
        nowheight = nowheight+100+10;
    }
    nowheight = nowheight+5;
    imagebg.frame = CGRectMake(0, 0, SCREEN_WIDTH, nowheight-5);
    view.frame = CGRectMake(XYViewL(view), XYViewTop(view), XYViewWidth(view), nowheight);
    return view;
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

#pragma mark 店铺首页商品模块
-(UIView *)viewproduct:(NSDictionary *)dicfrom Frame:(CGRect)frame
{
    UIView *view = [[UIView alloc] initWithFrame:frame];
    
    UIImageView *imageview =[[UIImageView alloc] initWithFrame:CGRectMake(0, 0,XYViewWidth(view),XYViewWidth(view))];
    imageview.backgroundColor = [UIColor clearColor];
    imageview.contentMode = UIViewContentModeScaleAspectFill;
    imageview.clipsToBounds = YES;
    imageview.userInteractionEnabled = YES;
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickproductpic:)];
    NSString *strpic = [dicfrom objectForKey:@"thumbpicture"];
    [imageview addGestureRecognizer:singleTap];
    [imageview setImageWithURL:[NSURL URLWithString:strpic] placeholderImage:LOADIMAGE(@"testpic", @"png")];
    [view addSubview:imageview];
    
    NSString *str = [dicfrom objectForKey:@"commodityname"];
    CGSize size = [AddInterface getlablesize:str Fwidth:XYViewWidth(imageview) Fheight:40 Sfont:FONTN(15.0f)];
    UILabel *labtitle = [[UILabel alloc] initWithFrame:CGRectMake(0,XYViewBottom(imageview)+5, size.width, size.height)];
    labtitle.text = str;
    labtitle.font = FONTN(15.0f);
    labtitle.numberOfLines = 0;
    labtitle.textColor = [UIColor blackColor];
    [view addSubview:labtitle];
    
    UILabel *lablemoneyflag1 = [[UILabel alloc] initWithFrame:CGRectMake(XYViewL(labtitle),XYViewHeight(view)-35, 10,10)];
    lablemoneyflag1.text = @"￥";
    lablemoneyflag1.font = FONTMEDIUM(11.0f);
    lablemoneyflag1.textColor = [UIColor redColor];
    lablemoneyflag1.backgroundColor = [UIColor clearColor];
    [view addSubview:lablemoneyflag1];
    
    UILabel *lableispayvalue = [[UILabel alloc] initWithFrame:CGRectMake(XYViewR(lablemoneyflag1)+1, XYViewTop(lablemoneyflag1)-3, SCREEN_WIDTH/2-30, 20)];
    lableispayvalue.text = [NSString stringWithFormat:@"%@",[dicfrom objectForKey:@"price"]];
    lableispayvalue.font = FONTB(18.0f);
    lableispayvalue.textColor = [UIColor redColor];
    lableispayvalue.backgroundColor = [UIColor clearColor];
    [view addSubview:lableispayvalue];
    
    return view;
}

#pragma mark 店铺首页通知新闻
-(UIView *)viewnotice:(NSArray *)FCsystemmessagelist
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 60)];
    view.backgroundColor = COLORNOW(235, 235, 235);
    
    NSDictionary *dictemp = [FCsystemmessagelist objectAtIndex:0];
    UIImageView *imageview =[[UIImageView alloc] initWithFrame:CGRectMake(0, 10, SCREEN_WIDTH, 40)];
    imageview.backgroundColor = [UIColor whiteColor];
    [view addSubview:imageview];

    UIImageView *imageicon = [[UIImageView alloc] initWithFrame:CGRectMake(20, 20, 18, 20)];
    
    imageicon.image = LOADIMAGE(@"tbeabells", @"png");
    [view addSubview:imageicon];

    UILabel *labtitle = [[UILabel alloc] initWithFrame:CGRectMake(XYViewR(imageicon)+5,XYViewTop(imageicon), SCREEN_WIDTH-80, 20)];
    labtitle.text = [dictemp objectForKey:@"title"];
    labtitle.font = FONTLIGHT(15.0f);
    labtitle.textColor = COLORNOW(72, 72, 72);
    [view addSubview:labtitle];

    UIImageView *imageright = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-27, 24, 7, 12)];
    imageright.image = LOADIMAGE(@"tbeaarrowright", @"png");
    [view addSubview:imageright];
    
    return view;
}
#pragma mark 循环滚动图片
-(UIView *)initloop:(NSArray *)arrayfocus
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 140)];
    
    NSMutableArray *arraypiclist =  [[NSMutableArray alloc] init];
    for(int i=0;i<[arrayfocus count];i++)
    {
        NSDictionary *dictemp = [arrayfocus objectAtIndex:i];
        NSString *strpic = [dictemp objectForKey:@"picture"];
        [arraypiclist addObject:[strpic length]>0?strpic:@"123"];
    }
    
    self.loop = [[XLsn0wLoop alloc] initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH, 140)];
    [view addSubview:self.loop];
    self.loop.xlsn0wDelegate = self;
    self.loop.time = 5;
    [self.loop setPagePosition:PositionBottomCenter];
    [self.loop setPageColor:Colorredcolor andCurrentPageColor:[UIColor whiteColor]];
    //支持gif动态图
    self.loop.imageArray = arraypiclist;
    
    return view;
}

#pragma mark XRCarouselViewDelegate
- (void)loopView:(XLsn0wLoop *)loopView clickImageAtIndex:(NSInteger)index {
    NSLog(@"点击了第%ld张图片", index);
    
    if([self.delegate1 respondsToSelector:@selector(DGFocusClickNumberPic:)])
    {
        //    NSArray *focus = [dicfocus objectForKey:@"list"];
        [self.delegate1 DGFocusClickNumberPic:@""];
    }
}

#pragma mark UIviewcontrollerdelegate
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
    
    SearchNavigateView *navi = [[SearchNavigateView alloc] initWithFrame:CGRectMake(50,0, SCREEN_WIDTH-50, 44) FromFlag:@"1"]; //传1表示是店铺首页
    navi.tag = EnHpNavigationViewTag1;
    navi.delegate1 = self;
    [self.navigationController.navigationBar addSubview:navi];
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    [[self.navigationController.navigationBar viewWithTag:EnHpNavigationViewTag1] removeFromSuperview];
}

#pragma mark IBaction
-(void)clickproductpic:(id)sender
{
    
}

-(void)returnback
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)morepoint:(id)sender
{
    
}

-(void)clickcollection:(id)sender
{
    
}

-(void)commditycategory:(id)sender
{
    
}

#pragma mark ActionDelegate
-(void)DGCLickWaterPersonHeader:(id)sender
{
    NearByStoreDetailViewController *storedetail = [[NearByStoreDetailViewController alloc] init];
    storedetail.FCcompanyid = _FCcompanyid;
    [self.navigationController pushViewController:storedetail animated:YES];
}

-(void)DGSelectNearByGoodsCategoryItem:(NSDictionary *)sender
{
    if(enstoreselectitems == EnStorePageSlectGoods)
    {
        FCcommoditycategoryid = [sender objectForKey:@"id"];
        [self getcommiditylist:@"1" PageSize:@"10"];
    }
}

-(void)DGCLickNearByStoreGoodsCategory:(id)sender
{
    NearByViewCommdityCategoryController *nearby = [[NearByViewCommdityCategoryController alloc] init];
    nearby.delegate1 = self;
    [self.navigationController pushViewController:nearby animated:YES];
}

-(void)DGFocusClickNumberPic:(id)sender
{
    
}

-(void)DGSelectGoodsItemSort:(NSString *)order OrderItem:(NSString *)orderitem
{
    FCorder = order;
    FCorderitem = orderitem;
    [self getcommiditylist:@"1" PageSize:@"10"];
}


-(void)DGClickNearByStoreHp:(id)sender
{
    tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    enstoreselectitems = EnStorePageSlectStore;
    [self getcommiditylist:@"1" PageSize:@"10"];
}

-(void)DGClickNearByAllCommity:(id)sender
{
    enstoreselectitems = EnStorePageSlectGoods;
    tableview.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [self getcommiditylist:@"1" PageSize:@"10"];
}

-(void)DGClickNearByAllActivity:(id)sender
{
    enstoreselectitems = EnStorePageActivity;
    tableview.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [self getactivitylist:@"1" PageSize:@"10"];
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
    if(enstoreselectitems == EnStorePageSlectStore) //选择的店铺首页
    {
        return 3;
    }
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(enstoreselectitems == EnStorePageSlectStore) //选择的店铺首页
    {
        if(indexPath.section == 0)
            return 140;
        else if(indexPath.section == 1)
            return 60;
        return (SCREEN_WIDTH-40-20)/2+80;
    }
    else if(enstoreselectitems == EnStorePageSlectGoods)  //选择商品
    {
        return 120;
    }
    else if(enstoreselectitems == EnStorePageActivity)  //选择动态
    {
        return [[arrayheight objectAtIndex:indexPath.row] floatValue];
    }
    
    return 100;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(enstoreselectitems == EnStorePageSlectStore) //选择的店铺首页
    {
        if(section == 0)
            return 1;
        else if(section == 1)
            return 1;
        else
            return ([FCarraydata count]+1)/2;
    }
    else if(enstoreselectitems == EnStorePageSlectGoods)  //选择商品
    {
        return [FCarraydata count];
    }
    else if(enstoreselectitems == EnStorePageActivity)  //选择动态
    {
        return [arrayheight count];
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if(enstoreselectitems == EnStorePageSlectStore) //选择的店铺首页
    {
        if(section == 0)
            return 55;
        else if(section == 1)
            return 0.001;
        else if(section == 2)
            return 40;
    }
    else if(enstoreselectitems == EnStorePageSlectGoods)  //选择商品
    {
        return 95;
    }
    else if(enstoreselectitems == EnStorePageActivity)  //选择动态
    {
        return 55;
    }
    return 0.001;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if(enstoreselectitems == EnStorePageSlectStore) //选择的店铺首页
    {
        [goodsitemheader removeFromSuperview];
        goodsitemheader = nil;
        if(section == 0)
        {
            NearByStoreHeaderView *storeheader = [[NearByStoreHeaderView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 55) DicFrom:FCdicuserinfo SelectItem:enstoreselectitems];
            storeheader.delegate1 = self;
            return storeheader;
        }
        else if(section == 2)
        {
            UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
            view.backgroundColor = [UIColor whiteColor];
            UILabel *label = [AddCustomView CusViewLabelForStyle:CGRectMake(20, 10, 100, 20) BGColor:[UIColor whiteColor] Title:@"推荐商品" TColor:[UIColor blackColor] Font:FONTB(15.0f) LineNumber:1];
            [view addSubview:label];
            return view;
        }
        return nil;
    }
    else if(enstoreselectitems == EnStorePageSlectGoods)  //选择商品
    {
        NearByStoreHeaderView *storeheader = [[NearByStoreHeaderView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 95) DicFrom:FCdicuserinfo SelectItem:enstoreselectitems GoodSSelectItem:enstoregoodsselectitem];
        storeheader.delegate1 = self;
        
        if(goodsitemheader == nil)
        {
            goodsitemheader = [[NearByStoreGoodsitemHeader alloc] initWithFrame:CGRectMake(0, 55, SCREEN_WIDTH, 40) DicFrom:FCdicuserinfo SelectItem:enstoreselectitems GoodSSelectItem:enstoregoodsselectitem];
            goodsitemheader.delegate1 = self;
        }
        [storeheader addSubview:goodsitemheader];
        return storeheader;
    }
    else if(enstoreselectitems == EnStorePageActivity)  //选择动态
    {
        [goodsitemheader removeFromSuperview];
        goodsitemheader = nil;
        NearByStoreHeaderView *storeheader = [[NearByStoreHeaderView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 55) DicFrom:FCdicuserinfo SelectItem:enstoreselectitems];
        storeheader.delegate1 = self;
        return storeheader;
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
    
    if(enstoreselectitems == EnStorePageSlectStore)
    {
        if(indexPath.section == 0)
        {
            UIView *view = [self initloop:FCadvertiselist];
            [cell.contentView addSubview:view];
        }
        else if(indexPath.section == 1)
        {
            
            UIView *view = [self viewnotice:FCsystemmessagelist];
            [cell.contentView addSubview:view];
        }
        else
        {
            float widthnow = (SCREEN_WIDTH-40-20)/2;
            if([FCarraydata count]>indexPath.row*2)
            {
                NSDictionary *dictemp = [FCarraydata objectAtIndex:indexPath.row*2];
                UIView *view =  [self viewproduct:dictemp Frame:CGRectMake(20, 5, widthnow, widthnow+80)];
                [cell.contentView addSubview:view];
            }
            
            if([FCarraydata count]>indexPath.row*2+1)
            {
                NSDictionary *dictemp1 = [FCarraydata objectAtIndex:indexPath.row*2+1];
                UIView *view1 =  [self viewproduct:dictemp1 Frame:CGRectMake(20+widthnow+20, 5, widthnow, widthnow+80)];
                [cell.contentView addSubview:view1];
            }
        }
    }
    else if(enstoreselectitems == EnStorePageSlectGoods)  //选择商品
    {
        NSDictionary *dictemp = [FCarraydata objectAtIndex:indexPath.row];
        UIView *view = [self viewcellcommdity:dictemp Frame:CGRectMake(0, 0, SCREEN_WIDTH, 120)];
        [cell.contentView addSubview:view];
    }
    else if(enstoreselectitems == EnStorePageActivity)  //选择动态
    {
        NSDictionary *dictemp = [FCarraydata objectAtIndex:indexPath.row];
        UIView *view = [self activitycellview:dictemp Frame:CGRectMake(0, 0, SCREEN_WIDTH, 100)];
        [cell.contentView addSubview:view];
     //   cell.textLabel.text = @"123";
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma mark 接口

-(void)getwateruserhome
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"companyid"] = _FCcompanyid;
    
    
    [RequestInterface doGetJsonWithParametersNoAn:params App:app RequestCode:RQNearByBusinessmenHpUserInfoCode ReqUrl:InterfaceRequestUrl ShowView:app.window alwaysdo:^{

    } Success:^(NSDictionary *dic) {
        DLog(@"dic====%@",dic);
        if([[dic objectForKey:@"success"] isEqualToString:@"true"])
        {
            FCdicuserinfo   = [[dic objectForKey:@"data"] objectForKey:@"summaryinfo"];

            [self addtabviewheader];
        }
        else
        {
            [MBProgressHUD showError:[dic objectForKey:@"msg"] toView:app.window];
        }
    } Failur:^(NSString *strmsg) {
        [MBProgressHUD showError:@"请求失败,请检查网络" toView:self.view];
        
    }];
}

-(void)getstorelist:(NSString *)page PageSize:(NSString *)pagesize
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"companyid"] = _FCcompanyid;
    params[@"page"] = page;
    params[@"pagesize"] = pagesize;
    
    
    [RequestInterface doGetJsonWithParametersNoAn:params App:app RequestCode:RQNearByBusinessmenStoreListCode ReqUrl:InterfaceRequestUrl ShowView:app.window alwaysdo:^{
        
    } Success:^(NSDictionary *dic) {
        DLog(@"dic====%@",dic);
        if([[dic objectForKey:@"success"] isEqualToString:@"true"])
        {
            FCadvertiselist = [[dic objectForKey:@"data"] objectForKey:@"advertiselist"];
            FCsystemmessagelist = [[dic objectForKey:@"data"] objectForKey:@"systemmessagelist"];
            FCarraydata = [[dic objectForKey:@"data"] objectForKey:@"commoditylist"];
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

-(void)getcommiditylist:(NSString *)page PageSize:(NSString *)pagesize
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"companyid"] = _FCcompanyid;
    params[@"commoditycategoryid"] = FCcommoditycategoryid;
    params[@"orderitem"] = FCorderitem;
    params[@"order"] = FCorder;
    params[@"page"] = page;
    params[@"pagesize"] = pagesize;
    
    
    [RequestInterface doGetJsonWithParametersNoAn:params App:app RequestCode:RQNearByBusinessmenAllCommidityCode ReqUrl:InterfaceRequestUrl ShowView:app.window alwaysdo:^{
        
    } Success:^(NSDictionary *dic) {
        DLog(@"dic====%@",dic);
        if([[dic objectForKey:@"success"] isEqualToString:@"true"])
        {
            FCarraydata = [[dic objectForKey:@"data"] objectForKey:@"commoditylist"];
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

-(void)getactivitylist:(NSString *)page PageSize:(NSString *)pagesize
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"companyid"] = _FCcompanyid;
    params[@"page"] = page;
    params[@"pagesize"] = pagesize;
    
    
    [RequestInterface doGetJsonWithParametersNoAn:params App:app RequestCode:RQNearByBusinessmenActivityListCode ReqUrl:InterfaceRequestUrl ShowView:app.window alwaysdo:^{
        
    } Success:^(NSDictionary *dic) {
        DLog(@"dic====%@",dic);
        if([[dic objectForKey:@"success"] isEqualToString:@"true"])
        {
            FCarraydata = [[dic objectForKey:@"data"] objectForKey:@"newslist"];
            [arrayheight removeAllObjects];
            for(int i=0;i<[FCarraydata count];i++)
            {
                NSDictionary *dictemp = [FCarraydata objectAtIndex:i];
                UIView *view = [self activitycellview:dictemp Frame:CGRectMake(0, 0, SCREEN_WIDTH, 100)];
                [arrayheight addObject:[NSString stringWithFormat:@"%f",view.frame.size.height]];
                
            }
            
            tableview.delegate = self;
            tableview.dataSource = self;
            if([FCarraydata count] == [arrayheight count])
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
