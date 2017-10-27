//
//  TaskDetailYiJieDanViewController.m
//  TbeaGuardian
//
//  Created by xyy on 2017/9/17.
//  Copyright © 2017年 xyy. All rights reserved.
//

#import "TaskDetailYiJieDanViewController.h"

@interface TaskDetailYiJieDanViewController ()

@end

@implementation TaskDetailYiJieDanViewController

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

#pragma mark 页面布局
-(void)initview
{
    self.title = @"任务详情";
    self.view.backgroundColor = [UIColor whiteColor];
    app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    FCbidlist = [[NSMutableArray alloc] init];
    
    tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64)];
    tableview.backgroundColor = [UIColor clearColor];
    [self.view addSubview:tableview];
    [self setExtraCellLineHidden:tableview];
    [self gettaskyijiedandetail];
    [self footerview];
}

-(void)footerview
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 100)];
    
    tableview.tableFooterView = view;
    
    UIButton *button = [AddCustomView CusViewButtonForRadius:CGRectMake(20, 40, SCREEN_WIDTH-40, 40) BGColor:COLORNOW(0, 170, 238) Title:@"完工确认" TitleColor:[UIColor whiteColor] FRadius:3.0f];
    [button addTarget:self action:@selector(clickdonetask:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:button];
}


-(UIView *)viewcell:(CGRect)frame Dicbid:(NSDictionary *)dic IndexPath:(NSIndexPath *)indexpath
{
    UIView *view = [[UIView alloc] initWithFrame:frame];
    float nowwidth = (SCREEN_WIDTH-20)/4;
    
    UIImageView *imageheader = [[UIImageView alloc] initWithFrame:CGRectMake(20, 10, 40, 40)];
    NSString *strpic = [dic objectForKey:@"thumbpicture"];//[InterfaceResource stringByAppendingString:[[dic objectForKey:@"thumbpicture"] length]>0?[dic objectForKey:@"thumbpicture"]:@"noimage.png"];
    [imageheader setImageWithURL:[NSURL URLWithString:strpic] placeholderImage:LOADIMAGE(@"testpic", @"png")];
    imageheader.layer.cornerRadius = 20.0f;
    imageheader.clipsToBounds = YES;
    imageheader.contentMode = UIViewContentModeScaleAspectFill;
    [view addSubview:imageheader];
    
    NSString *strname = [dic objectForKey:@"personname"];
    CGSize size = [AddInterface getlablesize:strname Fwidth:nowwidth*2-50 Fheight:20 Sfont:FONTN(14.0f)];
    UILabel *lablename = [[UILabel alloc] initWithFrame:CGRectMake(XYViewR(imageheader)+5, XYViewTop(imageheader), size.width, 20)];
    lablename.text =strname;
    lablename.font = FONTN(14.0f);
    lablename.textColor = [UIColor blackColor];
    lablename.backgroundColor = [UIColor clearColor];
    [view addSubview:lablename];
    
    UILabel *lableaddr = [[UILabel alloc] initWithFrame:CGRectMake(XYViewL(lablename), XYViewBottom(lablename), nowwidth*2-50 , 20)];
    lableaddr.text = [dic objectForKey:@"cityzone"];
    lableaddr.font = FONTN(12.0f);
    lableaddr.textColor = COLORNOW(160, 160, 160);
    lableaddr.backgroundColor = [UIColor clearColor];
    [view addSubview:lableaddr];
    
    UILabel *lablemoney = [[UILabel alloc] initWithFrame:CGRectMake(10+nowwidth*2, 20, nowwidth, 20)];
    lablemoney.text = [NSString stringWithFormat:@"￥%@",[dic objectForKey:@"fee"]];
    lablemoney.font = FONTN(14.0f);
    lablemoney.textColor = COLORNOW(117, 117, 117);
    lablemoney.backgroundColor = [UIColor clearColor];
    lablemoney.textAlignment = NSTextAlignmentCenter;
    [view addSubview:lablemoney];
    
    UIImageView *imageviewicon = [AddCustomView CusViewImageView:CGRectMake(SCREEN_WIDTH-15-30, 15, 30, 30) Image:LOADIMAGE(@"生活服务", @"png")];
    [view addSubview:imageviewicon];
    return view;
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

#pragma mark IBaction

-(void)clickdonetask:(id)sender
{
    [self getdonetask];
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
    if([FCbidlist count]>0)
        return 4;
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section==3)
        return 60;
    return 40;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section == 0)
        return 2;
    else if(section == 1)
        return 4;
    else if(section == 3)
        return [FCbidlist count];
    return 3;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if(section == 3)
    {
        UIView *viewselectitem = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
        viewselectitem.backgroundColor = [UIColor whiteColor];
        
        UIImageView *line = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10)];
        line.backgroundColor = COLORNOW(235, 235, 235);
        [viewselectitem addSubview:line];
        
        UIImageView *line1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 49, SCREEN_WIDTH, 0.7)];
        line1.backgroundColor = COLORNOW(200, 200, 200);
        [viewselectitem addSubview:line1];
        
        float widthnow = (SCREEN_WIDTH-20)/4;
        //规格
        ButtonItemLayoutView *buttonleft = [[ButtonItemLayoutView alloc] initWithFrame:CGRectMake(10, 10, widthnow*2, 39)];
        buttonleft.tag = EnTbeaProductInstroduceSelect1;
        [buttonleft updatebuttonitem:EnButtonTextLeft TextStr:@"竞价人员" Font:FONTN(14.0f) Color:[UIColor blackColor] Image:nil];
        [viewselectitem addSubview:buttonleft];
        
        //型号
        ButtonItemLayoutView *buttonmiddle = [[ButtonItemLayoutView alloc] initWithFrame:CGRectMake(10+widthnow*2, 10, widthnow, 39)];
        buttonmiddle.tag = EnTbeaProductInstroduceSelect2;
        [buttonmiddle updatebuttonitem:EnButtonTextCenter TextStr:@"出价" Font:FONTN(14.0f) Color:[UIColor blackColor] Image:nil];
        [viewselectitem addSubview:buttonmiddle];
        
        //最新产品
        ButtonItemLayoutView *buttonright = [[ButtonItemLayoutView alloc] initWithFrame:CGRectMake(10+widthnow*3, 10, widthnow, 39)];
        buttonright.tag = EnTbeaProductInstroduceSelect3;
        [buttonright updatebuttonitem:EnButtonTextRight TextStr:@"电话联系" Font:FONTN(14.0f) Color:[UIColor blackColor] Image:nil];
        [viewselectitem addSubview:buttonright];
        
        
        return viewselectitem;
    }
    else
    {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,10)];
        view.backgroundColor = COLORNOW(235,235, 235);
        
        return view;
    }
}



- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if(section == 0)
        return 0.01;
    else if(section == 3)
        return 50;
    return 10;
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
    
    UILabel *labelname = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, 80, 20)];
    labelname.backgroundColor = [UIColor clearColor];
    labelname.textColor = [UIColor blackColor];
    labelname.font = FONTN(15.0f);
    
    UITextField *textfield = [[UITextField alloc] initWithFrame:CGRectMake(100, 5, SCREEN_WIDTH-110, 30)];
    textfield.textColor = [UIColor blackColor];
    textfield.backgroundColor = [UIColor clearColor];
    textfield.font = FONTN(15.0f);
    textfield.delegate = self;
    textfield.enabled = NO;
    
    if(indexPath.section == 0)
    {
        switch (indexPath.row)
        {
                
            case 0:
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                labelname.text = @"服务项目";
                [cell.contentView addSubview:labelname];
                
                textfield.placeholder = @"选择服务项目";
                textfield.textColor = COLORNOW(117, 117, 117);
                textfield.tag = EnTaskAddNewTaskTextfield1;
                textfield.text = FCtaskcategoryname;
                [cell.contentView addSubview:textfield];
                break;
            case 1:
                
                labelname.text = @"服务描述";
                [cell.contentView addSubview:labelname];
                
                textfield.placeholder = @"填写描述";
                textfield.textColor = [UIColor blackColor];
                textfield.tag = EnTaskAddNewTaskTextfield2;
                textfield.text = FCtaskdescription;
                [cell.contentView addSubview:textfield];
                break;
        }
    }
    else if(indexPath.section == 1)
    {
        switch (indexPath.row)
        {
            case 0:
                labelname.text = @"业主姓名";
                [cell.contentView addSubview:labelname];
                
                textfield.placeholder = @"填写姓名";
                textfield.textColor = [UIColor blackColor];
                textfield.tag = EnTaskAddNewTaskTextfield3;
                textfield.text = FCserviceusername;
                [cell.contentView addSubview:textfield];
                break;
            case 1:
                labelname.text = @"电话号码";
                [cell.contentView addSubview:labelname];
                
                textfield.placeholder = @"填写电话";
                textfield.textColor = [UIColor blackColor];
                textfield.tag = EnTaskAddNewTaskTextfield4;
                textfield.text = FCcontactmobile;
                [cell.contentView addSubview:textfield];
                break;
            case 2:
                labelname.text = @"楼盘小区";
                [cell.contentView addSubview:labelname];
                
                textfield.placeholder = @"填写楼盘小区";
                textfield.textColor = [UIColor blackColor];
                textfield.tag = EnTaskAddNewTaskTextfield5;
                textfield.text = FCserviceusername;
                [cell.contentView addSubview:textfield];
                break;
            case 3:
                labelname.text = @"详细地址";
                [cell.contentView addSubview:labelname];
                
                textfield.placeholder = @"填写地址";
                textfield.textColor = [UIColor blackColor];
                textfield.tag = EnTaskAddNewTaskTextfield6;
                textfield.text = FCstraddress;
                [cell.contentView addSubview:textfield];
                break;
                
        }
    }
    else if(indexPath.section == 2)
    {
        switch (indexPath.row)
        {
            case 0:
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                labelname.text = @"服务时间";
                [cell.contentView addSubview:labelname];
                
                textfield.placeholder = @"选择服务时间";
                textfield.textColor = COLORNOW(117, 117, 117);
                textfield.tag = EnTaskAddNewTaskTextfield7;
                textfield.text = FCexpectservicetime;
                [cell.contentView addSubview:textfield];
                break;
            case 1:
                labelname.text = @"预算费用";
                [cell.contentView addSubview:labelname];
                
                textfield.placeholder = @"填写预算";
                textfield.textColor = [UIColor blackColor];
                textfield.tag = EnTaskAddNewTaskTextfield8;
                textfield.text = FCbudget;
                [cell.contentView addSubview:textfield];
                break;
            case 2:
                labelname.text = @"备注";
                [cell.contentView addSubview:labelname];
                
                textfield.placeholder = @"填写备注";
                textfield.textColor = [UIColor blackColor];
                textfield.tag = EnTaskAddNewTaskTextfield9;
                textfield.text = FCnote;
                [cell.contentView addSubview:textfield];
                break;
        }
        
    }
    else if(indexPath.section == 3)
    {
        NSDictionary *dictemp = [FCbidlist objectAtIndex:indexPath.row];
        UIView *view = [self viewcell:CGRectMake(0, 0, SCREEN_WIDTH, 60) Dicbid:dictemp IndexPath:indexPath];
        [cell.contentView addSubview:view];
    }
    
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 3)
    {
        NSDictionary *dictemp = [FCbidlist objectAtIndex:indexPath.row];
        NSMutableString* str=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",[dictemp objectForKey:@"mobilenumber"]];
   //     [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str] options:@{} completionHandler:^(BOOL success) {
            
        }];
    }
}

#pragma mark 接口


//确认完工
-(void)getdonetask
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"electricalcheckid"] = _FCtaskid;
    
    DLog(@"params===%@",params);
    
    [RequestInterface doGetJsonWithParametersNoAn:params App:app RequestCode:RQMyTaskDoneOverCode ReqUrl:InterfaceRequestUrl ShowView:app.window alwaysdo:^{
        
    } Success:^(NSDictionary *dic) {
        DLog(@"dic====%@",dic);
        if([[dic objectForKey:@"success"] isEqualToString:@"true"])
        {
            [MBProgressHUD showSuccess:[dic objectForKey:@"msg"] toView:app.window];
            [self returnback];
        }
        else
        {
            [MBProgressHUD showError:[dic objectForKey:@"msg"] toView:app.window];
        }
    } Failur:^(NSString *strmsg) {
        [MBProgressHUD showError:@"请求失败,请检查网络" toView:self.view];
        
    }];
}

//获取已接单任务详情
-(void)gettaskyijiedandetail
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"taskid"] = _FCtaskid;
    
    [RequestInterface doGetJsonWithParametersNoAn:params App:app RequestCode:RQTaskYiJieDanDetailCode ReqUrl:InterfaceRequestUrl ShowView:app.window alwaysdo:^{
        
    } Success:^(NSDictionary *dic) {
        DLog(@"dic====%@",dic);
        if([[dic objectForKey:@"success"] isEqualToString:@"true"])
        {
            NSDictionary *dichereinfo = [[dic objectForKey:@"data"] objectForKey:@"hireinfo"];
            [FCbidlist removeAllObjects];
            [FCbidlist addObject:dichereinfo];
            
            _FCtaskid = [[[dic objectForKey:@"data"] objectForKey:@"taskinfo"] objectForKey:@"taskid"];
            FCtaskcategoryid = [[[dic objectForKey:@"data"] objectForKey:@"taskinfo"] objectForKey:@"taskcategoryid"];
            FCtaskcategoryname = [[[dic objectForKey:@"data"] objectForKey:@"taskinfo"] objectForKey:@"taskcategoryname"];
            FCtaskdescription =[[[dic objectForKey:@"data"] objectForKey:@"taskinfo"] objectForKey:@"taskdescription"];
            FCserviceusername=[[[dic objectForKey:@"data"] objectForKey:@"taskinfo"] objectForKey:@"serviceusername"];
            FCcontactmobile=[[[dic objectForKey:@"data"] objectForKey:@"taskinfo"] objectForKey:@"contactmobile"];
            FCresidencezonename=[[[dic objectForKey:@"data"] objectForKey:@"taskinfo"] objectForKey:@"residencezonename"];
            FCprovicename=[[[dic objectForKey:@"data"] objectForKey:@"taskinfo"] objectForKey:@"provicename"];
            FCcity=[[[dic objectForKey:@"data"] objectForKey:@"taskinfo"] objectForKey:@"cityname"];
            FCzone=[[[dic objectForKey:@"data"] objectForKey:@"taskinfo"] objectForKey:@"zonename"];
            FCaddress=[[[dic objectForKey:@"data"] objectForKey:@"taskinfo"] objectForKey:@"address"];
            FCstraddress = [NSString stringWithFormat:@"%@%@%@%@",FCprovicename,FCcity,FCzone,FCaddress];
            FCexpectservicetime=[[[dic objectForKey:@"data"] objectForKey:@"taskinfo"] objectForKey:@"expectservicetime"];
            FCbudget=[NSString stringWithFormat:@"%@",[[[dic objectForKey:@"data"] objectForKey:@"taskinfo"] objectForKey:@"budget"]];
            FCnote=[[[dic objectForKey:@"data"] objectForKey:@"taskinfo"] objectForKey:@"note"];
            tableview.delegate = self;
            tableview.dataSource = self;
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
