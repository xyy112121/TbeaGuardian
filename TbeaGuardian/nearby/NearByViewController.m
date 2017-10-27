//
//  NearByViewController.m
//  TbeaGuardian
//
//  Created by xyy on 2017/9/8.
//  Copyright © 2017年 xyy. All rights reserved.
//

#import "NearByViewController.h"

@interface NearByViewController ()

@end

@implementation NearByViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)])
    {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }

    [self initview];
}

#pragma mark UIviewcontrollerdelegate
-(void)viewWillAppear:(BOOL)animated
{
    [self gethppage];
//    self.title = @"";
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [[self.navigationController.navigationBar viewWithTag:EnHpNavigationViewTag] removeFromSuperview];
    
    self.navigationController.navigationBar.translucent = NO;
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    [self.navigationController.navigationBar setBarTintColor:COLORNOW(0, 170, 238)];
    [self addnavigation:nil];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [[self.navigationController.navigationBar viewWithTag:EnHpNavigationViewTag] removeFromSuperview];
}

-(void)addnavigation:(id)sender
{
    [[self.navigationController.navigationBar viewWithTag:EnHpNavigationViewTag] removeFromSuperview];
    HpNavigateView *hpna = [[HpNavigateView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44) FromFlag:@"1"];
    hpna.delegate1 = self;
    hpna.tag = EnHpNavigationViewTag;
    [self.navigationController.navigationBar addSubview:hpna];
}

-(void)initview
{
    self.view.backgroundColor = [UIColor whiteColor];
    app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-49)];
    tableview.backgroundColor = [UIColor clearColor];
    tableview.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    tableview.delegate = self;
    tableview.dataSource = self;
    [self.view addSubview:tableview];
    [self setExtraCellLineHidden:tableview];
    
    [self gethppage];
}

-(void)viewheader
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 260)];
    
    FocusNewsView *focusnews = [[FocusNewsView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 260) Focus:FCarrayfocus];
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

#pragma mark ActionDelegate
-(void)DGclickMessage:(id)sender
{
    MyMessageViewController *mymessage = [[MyMessageViewController alloc] init];
    mymessage.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:mymessage animated:YES];
}

-(void)DGFocusClickNumberPic:(id)sender
{
    
}

-(void)DGClickTbeaHpProduct:(NSDictionary *)sender
{
    TbeaProductDetailViewController *productdetail = [[TbeaProductDetailViewController alloc] init];
    productdetail.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:productdetail animated:YES];
}

-(void)DGClickTopFunction:(int)sender
{
    NeayByBusinessmenLisViewController *nearbybusinessmen;
    NearByProductListViewController *productlist;
    NearByWaterElectricianViewController *waterele;
    NearByFloorListViewController *floorlist;
    switch (sender)
    {
        case 0:
            nearbybusinessmen = [[NeayByBusinessmenLisViewController alloc] init];
            nearbybusinessmen.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:nearbybusinessmen animated:YES];
            break;
        case 1:
            productlist = [[NearByProductListViewController alloc] init];
            productlist.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:productlist animated:YES];
            break;
        case 2:
            waterele = [[NearByWaterElectricianViewController alloc] init];
            waterele.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:waterele animated:YES];
            break;
        case 3:
            floorlist = [[NearByFloorListViewController alloc] init];
            floorlist.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:floorlist animated:YES];
            break;
            
    }
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

    return [FCarrayproduct count];
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
        
        UILabel *labtitle = [[UILabel alloc] initWithFrame:CGRectMake(20,10, 100, 20)];
        labtitle.text = @"离人最近";
        labtitle.font = FONTMEDIUM(16.0f);
        labtitle.textColor = [UIColor blackColor];
        [viewheader addSubview:labtitle];
        
        UIButton *button = [AddCustomView CusViewButtonForRadius:CGRectMake(SCREEN_WIDTH-60, 5, 60, 30) BGColor:[UIColor clearColor] Title:@"更多" TitleColor:COLORNOW(200, 200, 200) FRadius:0.0f];
        [viewheader addSubview:button];
        
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

    NSDictionary *dictemp = [FCarrayproduct objectAtIndex:indexPath.row];
    [cell.contentView addSubview:[self viewcellcommdity:dictemp Frame:CGRectMake(0, 0, SCREEN_WIDTH, 100)]];
        

    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dictemp = [FCarrayproduct objectAtIndex:indexPath.row];
    NearByStoreGoodsPageViewController *nearby = [[NearByStoreGoodsPageViewController alloc] init];
    nearby.FCcompanyid = [dictemp objectForKey:@"id"];
    [self.navigationController pushViewController:nearby animated:YES];
}

#pragma mark 接口
-(void)gethppage
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    [RequestInterface doGetJsonWithParametersNoAn:params App:app RequestCode:RQNearbyHopageInfoCode ReqUrl:InterfaceRequestUrl ShowView:app.window alwaysdo:^{
        
    } Success:^(NSDictionary *dic) {
        DLog(@"dic====%@",dic);
        if([[dic objectForKey:@"success"] isEqualToString:@"true"])
        {
            FCarrayfocus = [[dic objectForKey:@"data"] objectForKey:@"advertiselist"];
            FCarrayproduct = [[dic objectForKey:@"data"] objectForKey:@"companylist"];
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
