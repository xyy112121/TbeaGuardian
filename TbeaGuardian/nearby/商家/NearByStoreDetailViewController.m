//
//  NearByStoreDetailViewController.m
//  TbeaGuardian
//
//  Created by xyy on 2017/9/28.
//  Copyright © 2017年 xyy. All rights reserved.
//

#import "NearByStoreDetailViewController.h"

@interface NearByStoreDetailViewController ()

@end

@implementation NearByStoreDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initview];
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(20, 22, 40, 40)];
    [button setImage:LOADIMAGE(@"returnback", @"png") forState:UIControlStateNormal];
    [button addTarget:self action: @selector(returnback) forControlEvents: UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    // Do any additional setup after loading the view.
}

#pragma mark 页面布局

-(void)initview
{
    self.title = @"店铺详情";
    self.view.backgroundColor = [UIColor whiteColor];
    app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, -20, SCREEN_WIDTH, SCREEN_HEIGHT)];
    tableview.backgroundColor = [UIColor clearColor];
    tableview.delegate = self;
    tableview.dataSource = self;
    [self.view addSubview:tableview];
    [self viewheader];
    [self setExtraCellLineHidden:tableview];
    [self getstoredetail];
}

-(void)viewheader
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 150)];
    view.backgroundColor = COLORNOW(0, 170, 238);
    
    FCimageheader = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, XYViewHeight(view))];
    [view addSubview:FCimageheader];
    
    UILabel *lable = [AddCustomView CusViewLabelForStyle:CGRectMake(20, XYViewHeight(view)-40, 100, 20) BGColor:[UIColor clearColor] Title:@"店铺详情" TColor:[UIColor whiteColor] Font:FONTMEDIUM(17.0f) LineNumber:1];
    [view addSubview:lable];
    
    tableview.tableHeaderView = view;
}

-(void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    self.navigationController.navigationBar.translucent = NO;
    [self.navigationController.navigationBar  setBackgroundImage:[[UIImage alloc] init] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    [self.navigationController.navigationBar setBarTintColor:COLORNOW(0, 170, 238)];
    UIColor* color = [UIColor whiteColor];
    NSDictionary* dict=[NSDictionary dictionaryWithObject:color forKey:NSForegroundColorAttributeName];
    self.navigationController.navigationBar.titleTextAttributes= dict;
}



#pragma mark IBaction
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
    return 50;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    static NSString *reuseIdetify = @"cell";
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdetify];
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    for(UIView *view in cell.contentView.subviews)
    {
        [view removeFromSuperview];
    }
    
    cell.backgroundColor = [UIColor whiteColor];
    
    
    UILabel *labelname = [[UILabel alloc] initWithFrame:CGRectMake(20, 15, 100, 20)];
    labelname.backgroundColor = [UIColor clearColor];
    labelname.textColor = COLORNOW(117, 117, 117);
    labelname.font = FONTN(15.0f);
    
    UILabel *labelvalue = [[UILabel alloc] initWithFrame:CGRectMake(120, 15, SCREEN_WIDTH-130, 20)];
    labelvalue.backgroundColor = [UIColor clearColor];
    labelvalue.textColor = [UIColor blackColor];
    labelvalue.font = FONTN(15.0f);
    
    UIImageView *imageviewicon = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-30, 16, 17, 18)];
    imageviewicon.image = LOADIMAGE(@"tbeateliconblue", @"png");
    
    
    if(indexPath.section == 0)
    {
        switch (indexPath.row)
        {
            case 0:
                labelname.text = @"店名";
                [cell.contentView addSubview:labelname];
                
                labelvalue.text = [FCdiccompanyinfo objectForKey:@"companyname"];
                [cell.contentView addSubview:labelvalue];
                
                break;
            case 1:
                labelname.text = @"店铺简介";
                [cell.contentView addSubview:labelname];
                
                labelvalue.text = [FCdiccompanyinfo objectForKey:@"description"];
                [cell.contentView addSubview:labelvalue];
                break;
            case 2:
                labelname.text = @"详细地址";
                [cell.contentView addSubview:labelname];
                
                labelvalue.text = [FCdiccompanyinfo objectForKey:@"address"];
                [cell.contentView addSubview:labelvalue];
                break;
            case 3:
                
                labelname.text = @"电话";
                [cell.contentView addSubview:labelname];
                
                labelvalue.text = [FCdiccompanyinfo objectForKey:@"mobilenumber"];
                [cell.contentView addSubview:labelvalue];

                
                [cell.contentView addSubview:imageviewicon];
                break;
            case 4:
                labelname.text = @"相关认证";
                [cell.contentView addSubview:labelname];
                
                labelvalue.text = [FCdiccompanyinfo objectForKey:@"whetheridentified"];
                labelvalue.textAlignment = NSTextAlignmentRight;
                [cell.contentView addSubview:labelvalue];
                break;
                
        }
    }
    
    
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}


#pragma mark 接口
//获取详情
-(void)getstoredetail
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"companyid"] = _FCcompanyid;
    
    
    [RequestInterface doGetJsonWithParametersNoAn:params App:app RequestCode:RQNearByStoreDetailInfoCode ReqUrl:InterfaceRequestUrl ShowView:app.window alwaysdo:^{
        
    } Success:^(NSDictionary *dic) {
        DLog(@"dic====%@",dic);
        if([[dic objectForKey:@"success"] isEqualToString:@"true"])
        {
            FCdiccompanyinfo = [[dic objectForKey:@"data"] objectForKey:@"companyinfo"];
            [FCimageheader setImageWithURL:[NSURL URLWithString:[FCdiccompanyinfo objectForKey:@"backgroundpicture"]]];
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
