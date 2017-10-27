//
//  DetectApplyNewViewController.m
//  TbeaGuardian
//
//  Created by xyy on 2017/9/15.
//  Copyright © 2017年 xyy. All rights reserved.
//

#import "DetectApplyNewViewController.h"

@interface DetectApplyNewViewController ()

@end

@implementation DetectApplyNewViewController

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
    [self getservicecode];
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
    UITextField *textfield1 = [tableview viewWithTag:EnDetectApplyNewTextfield1];
    UITextField *textfield2 = [tableview viewWithTag:EnDetectApplyNewTextfield2];
    UITextField *textfield3 = [tableview viewWithTag:EnDetectApplyNewTextfield3];

    FCsubscribetime = textfield2.text;
    FCnote = textfield3.text;
    
    [textfield1 resignFirstResponder];
    [textfield2 resignFirstResponder];
    [textfield3 resignFirstResponder];
;
}

#pragma mark UITextfieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if(textField.tag == EnDetectApplyNewTextfield2)
    {
        [self selecttasktime];
        return NO;
    }

    return YES;
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
//    UITextField *textfield1 = [tableview viewWithTag:EnDetectApplyNewTextfield1];
    UITextField *textfield2 = [tableview viewWithTag:EnDetectApplyNewTextfield2];
    UITextField *textfield3 = [tableview viewWithTag:EnDetectApplyNewTextfield3];
    
    FCsubscribetime = [textfield2.text length]>0?textfield2.text:FCsubscribetime;
    FCnote = [textfield3.text length]>0?textfield3.text:FCnote;

}


#pragma mark IBaction
-(void)selecttasktime
{
    [self keyboardHide:nil];
    DateTimePickerView *pickerView = [[DateTimePickerView alloc] init];
    self.datePickerView = pickerView;
    pickerView.delegate = self;
    pickerView.pickerViewMode = DatePickerViewDateTimeMode;
    [self.view addSubview:pickerView];
    [pickerView showDateTimePickerView];
}

- (void)didClickFinishDateTimePickerView:(NSString *)date
{
    UITextField *textfield = [tableview viewWithTag:EnDetectApplyNewTextfield2];
    textfield.text = date;
    FCsubscribetime =date;
}

-(void)Clicksave:(id)sender
{
    UITextField *textfield2 = [tableview viewWithTag:EnDetectApplyNewTextfield2];
    UITextField *textfield3 = [tableview viewWithTag:EnDetectApplyNewTextfield3];
    
    FCsubscribetime = [textfield2.text length]>0?textfield2.text:FCsubscribetime;
    FCnote = [textfield3.text length]>0?textfield3.text:FCnote;
    if(([FCvouchernumber length]==0)||([FCsubscribetime length]==0)||([FCnote length]==0))
    {
        [MBProgressHUD showError:@"请填写完全检测预约数据" toView:app.window];
    }
    else
    {
        [self uploadtaskinfo];
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
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 40;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
//    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,10)];
//    view.backgroundColor = COLORNOW(235,235, 235);
    
    return nil;
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
    
    switch (indexPath.row)
    {
            
        case 0:
            
            labelname.text = @"凭证号";
            [cell.contentView addSubview:labelname];
            

            textfield.textColor = COLORNOW(117, 117, 117);
            textfield.tag = EnDetectApplyNewTextfield1;
            textfield.text = FCvouchernumber;
            [cell.contentView addSubview:textfield];
            break;
        case 1:
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            labelname.text = @"预约时间";
            [cell.contentView addSubview:labelname];
            
            textfield.placeholder = @"选择时间";
            textfield.textColor = [UIColor blackColor];
            textfield.tag = EnDetectApplyNewTextfield2;
            textfield.text = FCsubscribetime;
            [cell.contentView addSubview:textfield];
            break;
        case 2:
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            labelname.text = @"备注";
            [cell.contentView addSubview:labelname];
            
            textfield.placeholder = @"填写备注内容";
            textfield.textColor = [UIColor blackColor];
            textfield.tag = EnDetectApplyNewTextfield3;
            textfield.text = FCnote;
            [cell.contentView addSubview:textfield];
            break;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma mark 接口
//获取服务凭证号
-(void)getservicecode
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    
    [RequestInterface doGetJsonWithParametersNoAn:params App:app RequestCode:RQDetectApplyServiceCode ReqUrl:InterfaceRequestUrl ShowView:app.window alwaysdo:^{
        
    } Success:^(NSDictionary *dic) {
        DLog(@"dic====%@",dic);
        if([[dic objectForKey:@"success"] isEqualToString:@"true"])
        {
            FCvouchernumber = [[[dic objectForKey:@"data"] objectForKey:@"voucherinfo"] objectForKey:@"vouchercode"];
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

//发起一个免费预约凭证
-(void)uploadtaskinfo
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"vouchercode"] = FCvouchernumber;
    params[@"subscribetime"] = FCsubscribetime;
    params[@"note"] = FCnote;
    
    DLog(@"params===%@",params);
    
    [RequestInterface doGetJsonWithParametersNoAn:params App:app RequestCode:RQDetectApplyNewService ReqUrl:InterfaceRequestUrl ShowView:app.window alwaysdo:^{
        
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
