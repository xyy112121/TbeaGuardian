//
//  NearByFloorDetailViewController.m
//  TbeaGuardian
//
//  Created by xyy on 2017/10/12.
//  Copyright © 2017年 xyy. All rights reserved.
//

#import "NearByFloorDetailViewController.h"

@interface NearByFloorDetailViewController ()

@end

@implementation NearByFloorDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)])
    {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    [self initview];
    
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(20, StatusHeight+2, 40, 40)];
    [button setImage:LOADIMAGE(@"returnback", @"png") forState:UIControlStateNormal];
    [button addTarget:self action: @selector(returnback) forControlEvents: UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    
    
    
    // Do any additional setup after loading the view.
}

#pragma mark 页面布局
-(void)initview
{
    self.title = @"";
    self.view.backgroundColor = [UIColor whiteColor];
    //    self.view.backgroundColor = COLORNOW(0, 170, 238);
    app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    tableview.backgroundColor = [UIColor clearColor];
    tableview.delegate = self;
    tableview.dataSource = self;
    tableview.estimatedRowHeight = 0;
    tableview.estimatedSectionHeaderHeight = 0;
    tableview.estimatedSectionFooterHeight = 0;
    if (@available(iOS 11.0, *)) {
        tableview.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }else{
    }
    
    [self.view insertSubview:tableview atIndex:0];
    
    [self setExtraCellLineHidden:tableview];
    [self getfloordetail:@"1" PageSize:@"10"];
}

-(void)addtabviewheader
{
    NearByFloorDetailHeader *waterheader = [[NearByFloorDetailHeader alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 240) DicFrom:FCdicbuildingzoneinfo];
    waterheader.delegate1 = self;
    tableview.tableHeaderView = waterheader;
}

#pragma mark 全部水电工列表
-(UIView *)viewcellwaterelec:(NSDictionary *)sender Frame:(CGRect)frame
{
    UIView *view = [[UIView alloc] initWithFrame:frame];
    
    UIImageView *imageview  = [[UIImageView alloc] initWithFrame:CGRectMake(20, 10, 60, 60)];
    NSString *strpic = [sender objectForKey:@"thumbpicture"];
    [imageview setImageWithURL:[NSURL URLWithString:strpic] placeholderImage:LOADIMAGE(@"testpic", @"png")];
    imageview.contentMode = UIViewContentModeScaleAspectFill;
    imageview.layer.cornerRadius = 30.0f;
    imageview.clipsToBounds = YES;
    [view addSubview:imageview];
    
    UILabel *labeltitle = [[UILabel alloc] initWithFrame:CGRectMake(XYViewR(imageview)+10,XYViewTop(imageview),150,20)];
    labeltitle.backgroundColor = [UIColor clearColor];
    labeltitle.textColor = [UIColor blackColor];
    labeltitle.font = FONTB(16.0f);
    labeltitle.text = [sender objectForKey:@"personname"];
    [view addSubview:labeltitle];
    
    UILabel *lablemoneyvalue = [[UILabel alloc] initWithFrame:CGRectMake(XYViewL(labeltitle), XYViewBottom(labeltitle), 150, 20)];
    lablemoneyvalue.text = [NSString stringWithFormat:@"%@",[sender objectForKey:@"cityzone"]];
    lablemoneyvalue.font = FONTN(14.0f);
    lablemoneyvalue.textColor = COLORNOW(117, 117, 117);
    lablemoneyvalue.backgroundColor = [UIColor clearColor];
    [view addSubview:lablemoneyvalue];
    
    UILabel *labeleyear = [[UILabel alloc] initWithFrame:CGRectMake(XYViewL(lablemoneyvalue),XYViewBottom(lablemoneyvalue),150,20)];
    labeleyear.backgroundColor = [UIColor clearColor];
    labeleyear.textColor = COLORNOW(117, 117, 117);
    labeleyear.font = FONTN(14.0f);
    labeleyear.text = [NSString stringWithFormat:@"从业年限:%@年",[sender objectForKey:@"workyear"]];
    [view addSubview:labeleyear];
    
    UILabel *labelescore = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-30,XYViewTop(labeltitle)+3,25,14)];
    labelescore.backgroundColor = [UIColor clearColor];
    labelescore.textColor = COLORNOW(117, 117, 117);
    labelescore.font = FONTN(12.0f);
    [view addSubview:labelescore];
    
    UIImageView *imageviewxin = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-100, XYViewTop(labeltitle)+5, 68, 10)];
    if([[sender objectForKey:@"starlevel"] intValue]==0)
    {
        imageviewxin.image = LOADIMAGE(@"0xin", @"png");
        labelescore.text = @"0分";
    }
    else if([[sender objectForKey:@"starlevel"] intValue]==1)
    {
        imageviewxin.image = LOADIMAGE(@"1xin", @"png");
        labelescore.text = @"1分";
    }
    else if([[sender objectForKey:@"starlevel"] intValue]==2)
    {
        imageviewxin.image = LOADIMAGE(@"2xin", @"png");
        labelescore.text = @"2分";
    }
    else if([[sender objectForKey:@"starlevel"] intValue]==3)
    {
        imageviewxin.image = LOADIMAGE(@"3xin", @"png");
        labelescore.text = @"3分";
    }
    else if([[sender objectForKey:@"starlevel"] intValue]==4)
    {
        imageviewxin.image = LOADIMAGE(@"4xin", @"png");
        labelescore.text = @"4分";
    }
    else if([[sender objectForKey:@"starlevel"] intValue]==5)
    {
        imageviewxin.image = LOADIMAGE(@"5xin", @"png");
        labelescore.text = @"5分";
    }
    [view addSubview:imageviewxin];
    
    
    
    return view;
}

-(void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

#pragma mark ActionDelegate
-(void)DGClickFloorPicTop:(id)sender
{
    NearByFloorPicarrangementViewController *storedetail = [[NearByFloorPicarrangementViewController alloc] init];
    storedetail.FCbuildingzoneid = _FCbuildingzoneid;
    [self.navigationController pushViewController:storedetail animated:YES];
}

#pragma mark IBaction
-(void)gotopersonmanger:(id)sender
{
    //    WaterPersonHpViewController *waterperson = [[WaterPersonHpViewController alloc] init];
    //    waterperson.FCelectricianid = self.FCelectricianid;
    //    [self.navigationController pushViewController:waterperson animated:YES];
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
    
    UIImageView *imagebg = [AddCustomView CusViewLine:CGRectMake(0, 5, SCREEN_WIDTH, 40) BGColor:[UIColor whiteColor]];
    [view addSubview:imagebg];
    
    UILabel *label = [AddCustomView CusViewLabelTitle:CGRectMake(20, 15, 150, 20) BGColor:[UIColor clearColor] Title:@"签约入驻水电工" TitleColor:[UIColor blackColor]];
    [view addSubview:label];
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
    NearByWaterElecPersonViewController *waterelec = [[NearByWaterElecPersonViewController alloc] init];
    waterelec.FCelectricianid = [dictemp objectForKey:@"electricianid"];
    [self.navigationController pushViewController:waterelec animated:YES];
}


#pragma mark 接口
-(void)getfloordetail:(NSString *)page PageSize:(NSString *)pagesize
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"buildingzoneid"]= _FCbuildingzoneid;
    params[@"page"] = page;
    params[@"pagesize"] = pagesize;
    [RequestInterface doGetJsonWithParametersNoAn:params App:app RequestCode:RQNearByFloorDetailCode ReqUrl:InterfaceRequestUrl ShowView:app.window alwaysdo:^{
        
    } Success:^(NSDictionary *dic) {
        DLog(@"dic====%@",dic);
        if([[dic objectForKey:@"success"] isEqualToString:@"true"])
        {
            FCdicbuildingzoneinfo = [[dic objectForKey:@"data"] objectForKey:@"buildingzoneinfo"];
            FCarraydata = [[dic objectForKey:@"data"] objectForKey:@"electricianlist"];
            [self addtabviewheader];
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
