//
//  NearByWaterPersonInfoViewController.m
//  TbeaGuardian
//
//  Created by xyy on 2017/10/10.
//  Copyright © 2017年 xyy. All rights reserved.
//

#import "NearByWaterPersonInfoViewController.h"

@interface NearByWaterPersonInfoViewController ()

@end

@implementation NearByWaterPersonInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initview];
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(20, 42, 40, 40)];
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
    [self getwateruserhome];
}

-(void)viewheader
{
    
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 150)];
    view.backgroundColor = COLORNOW(0, 170, 238);
    
//    FCimageheader = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, XYViewHeight(view))];
//    [view addSubview:FCimageheader];
    
    UILabel *lable = [AddCustomView CusViewLabelForStyle:CGRectMake(20, XYViewHeight(view)-40, 100, 25) BGColor:[UIColor clearColor] Title:@"个人资料" TColor:[UIColor whiteColor] Font:FONTMEDIUM(22.0f) LineNumber:1];
    [view addSubview:lable];
    
    tableview.tableHeaderView = view;
}

-(void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
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
    if(indexPath.row == 6)
        return 80;
    return 50;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 7;
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
    
    CGSize size;
    if(indexPath.section == 0)
    {
        switch (indexPath.row)
        {
            case 0:
                labelname.text = @"姓名";
                [cell.contentView addSubview:labelname];
                
                labelvalue.text = [FCdicuserinfo objectForKey:@"personname"];
                [cell.contentView addSubview:labelvalue];
                
                break;
            case 1:
                labelname.text = @"性别";
                [cell.contentView addSubview:labelname];
                
                labelvalue.text = [FCdicuserinfo objectForKey:@"sex"];
                [cell.contentView addSubview:labelvalue];
                break;
            case 2:
                labelname.text = @"年龄";
                [cell.contentView addSubview:labelname];
                
                labelvalue.text = [FCdicuserinfo objectForKey:@"age"];
                [cell.contentView addSubview:labelvalue];
                break;
            case 3:
                
                labelname.text = @"工龄";
                [cell.contentView addSubview:labelname];
                
                labelvalue.text = [FCdicuserinfo objectForKey:@"workyear"];
                [cell.contentView addSubview:labelvalue];
                
                break;
            case 4:
                labelname.text = @"所在地区";
                [cell.contentView addSubview:labelname];
                
                labelvalue.text = [FCdicuserinfo objectForKey:@"belongtocompany"];
                [cell.contentView addSubview:labelvalue];
                break;
            case 5:
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                
                labelname.text = @"认证状态";
                [cell.contentView addSubview:labelname];
                
                labelvalue.text = [FCdicuserinfo objectForKey:@"whetheridentifyname"];
                labelvalue.frame = CGRectMake(XYViewL(labelvalue), XYViewTop(labelvalue), XYViewWidth(labelvalue)-40, XYViewHeight(labelvalue));
                labelvalue.textAlignment = NSTextAlignmentRight;
                [cell.contentView addSubview:labelvalue];
                break;
            case 6:
                labelname.text = @"个人介绍";
                [cell.contentView addSubview:labelname];
                
                size = [AddInterface getlablesize:[FCdicuserinfo objectForKey:@"introduce"] Fwidth:SCREEN_WIDTH-130 Fheight:60 Sfont:FONTN(15.0f)];
                labelvalue.frame = CGRectMake(XYViewL(labelvalue), XYViewTop(labelvalue), size.width, size.height);
                labelvalue.numberOfLines = 0;
                labelvalue.text = [FCdicuserinfo objectForKey:@"introduce"];
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
-(void)getwateruserhome
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"electricianid"]= _FCelectricianid;
    [RequestInterface doGetJsonWithParametersNoAn:params App:app RequestCode:RQWaterPersonInfoCode ReqUrl:InterfaceRequestUrl ShowView:app.window alwaysdo:^{
        
    } Success:^(NSDictionary *dic) {
        DLog(@"dic====%@",dic);
        if([[dic objectForKey:@"success"] isEqualToString:@"true"])
        {
            FCdicuserinfo = [[dic objectForKey:@"data"] objectForKey:@"electricianpersonalinfo"];
            [self viewheader];
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
