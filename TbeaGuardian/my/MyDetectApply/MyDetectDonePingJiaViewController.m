//
//  MyDetectDonePingJiaViewController.m
//  TbeaGuardian
//
//  Created by xyy on 2017/9/16.
//  Copyright © 2017年 xyy. All rights reserved.
//

#import "MyDetectDonePingJiaViewController.h"

@interface MyDetectDonePingJiaViewController ()

@end

@implementation MyDetectDonePingJiaViewController

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
    self.title = @"免费检测预约";
    self.view.backgroundColor = [UIColor whiteColor];
    app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    
    tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64)];
    tableview.backgroundColor = [UIColor clearColor];
    tableview.delegate = self;
    tableview.dataSource = self;
    [self.view addSubview:tableview];
    [self setExtraCellLineHidden:tableview];
    [self footerview];
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    //设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。
    tapGestureRecognizer.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tapGestureRecognizer];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHidden:) name:UIKeyboardWillHideNotification object:nil];
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

-(void)footerview
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 100)];
    
    tableview.tableFooterView = view;
    
    UIButton *button = [AddCustomView CusViewButtonForRadius:CGRectMake(20, 40, SCREEN_WIDTH-40, 40) BGColor:COLORNOW(0, 170, 238) Title:@"确定" TitleColor:[UIColor whiteColor] FRadius:3.0f];
    [button addTarget:self action:@selector(Clicksave:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:button];
}

-(UIView *)viewselectstartlevel:(CGRect)frame
{
    UIView *view = [[UIView alloc] initWithFrame:frame];
    
    
    for(int i=0;i<5;i++)
    {
        UIButton *button = [AddCustomView CusViewButton:CGRectMake(32*i, 5, 30, 30)];
        [button addTarget:self action:@selector(addselectstart:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = EnMyDetectPingJiaStartLevelbt+i;
        [view addSubview:button];
    }
    FCimagestart = [[UIImageView alloc] initWithFrame:CGRectMake(5, 9, 150, 22)];
    FCimagestart.image = LOADIMAGE(@"4xin", @"png");
    [view addSubview:FCimagestart];
    FCStarLevel = @"4";
    return view;
}

#pragma mark 键盘控制
-(void)keyboardWillShow:(NSNotification *)notification
{
    //这样就拿到了键盘的位置大小信息frame，然后根据frame进行高度处理之类的信息
    CGRect frame = [[[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat keyboardHeight = frame.size.height;
    CGFloat height =CGRectGetHeight(self.view.frame)- keyboardHeight;
    
    /* 使用动画效果，过度更加平滑 */
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.2];
    {
        CGRect rect =
        tableview.frame;
        rect.size.height = height;
        tableview.frame = rect;
    }
    [UIView commitAnimations];
}

-(void)keyboardWillHidden:(NSNotification *)notification
{
    //    CGRect frame = [[[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    //    tableview.frame = CGRectMake(XYViewL(tableview), XYViewTop(tableview), XYViewWidth(tableview), SCREEN_HEIGHT-64);
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.2];
    {
        CGRect rect = tableview.frame;
        rect.size.height = CGRectGetHeight(self.view.frame);
        tableview.frame = rect;
    }
    [UIView commitAnimations];
}

-(void)keyboardHide:(id)sender
{
    VBTextView *textfield1 = [tableview viewWithTag:EnDetectPingJiaTextview1];
    FCAppraise = textfield1.text;
    [textfield1 resignFirstResponder];

}

#pragma mark UITextfieldDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //    UITextField *textfield1 = [tableview viewWithTag:EnDetectApplyNewTextfield1];
    VBTextView *textfield1 = [tableview viewWithTag:EnDetectPingJiaTextview1];
    FCAppraise = [textfield1.text length]>0?textfield1.text:FCAppraise;
    
}


#pragma mark IBaction
-(void)photoTappedAd:(UIGestureRecognizer *)sender
{
    __weak __typeof(self) weakSelf = self;
    
    [JPhotoMagenage JphotoGetFromSystemInController:self finish:^(UIImage *image) {
        FCimageadd.image = image;
        NSMutableArray *arrayimage = [[NSMutableArray alloc] init];
        [arrayimage addObject:image];
        [weakSelf uploadcustompic:arrayimage FromFlag:@"1"];
    } cancel:^{
        
    }];
    
}

-(void)addselectstart:(id)sender
{
    UIButton *button = (UIButton *)sender;
    int tagnow = (int)[button tag]-EnMyDetectPingJiaStartLevelbt;
    FCStarLevel = [NSString stringWithFormat:@"%d",tagnow+1];
    switch (tagnow)
    {
        case 0:
            FCimagestart.image = LOADIMAGE(@"1xin", @"png");
            break;
        case 1:
            FCimagestart.image = LOADIMAGE(@"2xin", @"png");
            break;
        case 2:
            FCimagestart.image = LOADIMAGE(@"3xin", @"png");
            break;
        case 3:
            FCimagestart.image = LOADIMAGE(@"4xin", @"png");
            break;
        case 4:
            FCimagestart.image = LOADIMAGE(@"5xin", @"png");
            break;

    }
}

-(void)Clicksave:(id)sender
{
    VBTextView *textfield2 = [tableview viewWithTag:EnDetectPingJiaTextview1];
    FCAppraise = textfield2.text;
    if(([FCStarLevel length]==0)||([FCAppraise length]==0)||([FCPictureList length]==0))
    {
        [MBProgressHUD showError:@"请填写完全检测预约数据" toView:app.window];
    }
    else
    {
        [self uploaddetectpingjiainfo];
    }
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
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if((indexPath.section == 0)&&(indexPath.row == 1))
        return 50;
    else if((indexPath.section == 1)&&(indexPath.row == 1))
        return 100;
    else if((indexPath.section == 1)&&(indexPath.row == 2))
        return 100;
    return 40;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section == 0)
        return 2;
    return 3;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,10)];
    view.backgroundColor = COLORNOW(235,235, 235);
    
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if(section == 0)
        return 0.01;
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
    
    UILabel *labelname = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 80, 20)];
    labelname.backgroundColor = [UIColor clearColor];
    labelname.textColor = [UIColor blackColor];
    labelname.font = FONTN(15.0f);
    
    UITextField *textfield = [[UITextField alloc] initWithFrame:CGRectMake(100, 5, SCREEN_WIDTH-110, 30)];
    textfield.textColor = [UIColor blackColor];
    textfield.backgroundColor = [UIColor clearColor];
    textfield.font = FONTN(15.0f);
    textfield.delegate = self;
    textfield.enabled = NO;
    
    UIImageView *imageview;
    VBTextView *vbtextview;
    
    switch (indexPath.section) {
        case 0:
            switch (indexPath.row)
            {
                    
                case 0:
                    
                    labelname.text = @"凭证号";
                    [cell.contentView addSubview:labelname];
                    
                    
                    textfield.textColor = COLORNOW(117, 117, 117);
                    textfield.tag = EnDetectApplyNewTextfield1;
                    textfield.text = _FCvouchernumber;
                    [cell.contentView addSubview:textfield];
                    break;
                case 1:
                    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                    labelname.text = @"检测人员";
                    labelname.frame = CGRectMake(10, 15, 80, 20);
                    [cell.contentView addSubview:labelname];
                    
                    imageview = [AddCustomView CusViewImageViewForRadius:CGRectMake(100, 10, 30, 30) Image:LOADIMAGE(@"testpic", @"png") FRadius:15.0f];
                    [imageview setImageWithURL:[NSURL URLWithString:[_FCdetectperson objectForKey:@"thumbpicture"]] placeholderImage:LOADIMAGE(@"testpic", @"png")];
                    
                    [cell.contentView addSubview:imageview];
                    
                    textfield.frame = CGRectMake(XYViewR(imageview)+5, 10, 170, 30);
                    textfield.text = [_FCdetectperson objectForKey:@"electricianname"];
                    [cell.contentView addSubview:textfield];
                    break;
            }
            break;
        case 1:
            switch (indexPath.row)
            {
                case 0:
                    labelname.text = @"评分";
                    [cell.contentView addSubview:labelname];
                    
                    [cell.contentView addSubview:[self viewselectstartlevel:CGRectMake(95, 0, 170, 40)]];
                    
                    break;
                    
                case 1:
                    labelname.text = @"评价内容";
                    labelname.frame = CGRectMake(10, 40, 80, 20);
                    [cell.contentView addSubview:labelname];
                    
                    vbtextview = [[VBTextView alloc] initWithFrame:CGRectMake(95, 10, SCREEN_WIDTH-100, 80)];
                    vbtextview.placeHolder = @"请输入内容";
                    vbtextview.tag = EnDetectPingJiaTextview1;
                    if([FCAppraise length]>0)
                        vbtextview.text = FCAppraise;
                    vbtextview.font = FONTN(15.0f);
                    vbtextview.delegate = self;
                    vbtextview.backgroundColor = [UIColor whiteColor];
                    [cell.contentView addSubview:vbtextview];
                    break;
                case 2:
                    labelname.text = @"照片上传";
                    [cell.contentView addSubview:labelname];
                    
                    FCimageadd = [[UIImageView alloc] initWithFrame:CGRectMake(100, 10, 80, 80)];
                    FCimageadd.image = LOADIMAGE(@"useraddpic", @"png");
                    FCimageadd.userInteractionEnabled = YES;
                    FCimageadd.tag = EnUserAuthorizaImageview1;
                    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(photoTappedAd:)];
                    [FCimageadd addGestureRecognizer:singleTap];
                    [cell.contentView addSubview:FCimageadd];
                    break;
            }
            break;
    }
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma mark 接口

-(void)uploadcustompic:(NSArray *)arrayimage FromFlag:(NSString *)fromflag
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    [RequestInterface doGetJsonWithArraypic:arrayimage Parameter:params App:app RequestCode:RQUploadpicReturnPicpath ReqUrl:InterfaceRequestUrl ShowView:app.window alwaysdo:^{
        
    } Success:^(NSDictionary *dic) {
        DLog(@"dic====%@",dic);
        if([[dic objectForKey:@"success"] isEqualToString:@"true"])
        {
            FCPictureList = [[[dic objectForKey:@"data"] objectForKey:@"pictureinfo"] objectForKey:@"picturesavenames"];
        }
        else
        {
            [MBProgressHUD showError:[dic objectForKey:@"msg"] toView:app.window];
        }
        
    } Failur:^(NSString *strmsg) {
        [MBProgressHUD showError:@"请求失败,请检查网络" toView:self.view];
    }];
}


-(void)uploaddetectpingjiainfo
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"checkresultid"] = _FCCheckResultId;
    params[@"starlevel"] = FCStarLevel;
    params[@"appraise"] = FCAppraise;
    params[@"picturelist"] = FCPictureList;
    DLog(@"params===%@",params);
    
    [RequestInterface doGetJsonWithParametersNoAn:params App:app RequestCode:RQUploaddetectPingJiaInfoCode ReqUrl:InterfaceRequestUrl ShowView:app.window alwaysdo:^{
        
    } Success:^(NSDictionary *dic) {
        DLog(@"dic====%@",dic);
        if([[dic objectForKey:@"success"] isEqualToString:@"true"])
        {
            [MBProgressHUD showSuccess:[dic objectForKey:@"msg"] toView:app.window];
            [self.navigationController popViewControllerAnimated:YES];
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
