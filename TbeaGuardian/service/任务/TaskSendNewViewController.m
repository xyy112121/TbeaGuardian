//
//  TaskSendNewViewController.m
//  TbeaGuardian
//
//  Created by xyy on 2017/9/14.
//  Copyright © 2017年 xyy. All rights reserved.
//

#import "TaskSendNewViewController.h"

@interface TaskSendNewViewController ()

@end

@implementation TaskSendNewViewController

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
    self.title = @"添加任务";
    self.view.backgroundColor = [UIColor whiteColor];
    app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    
    tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64)];
    tableview.backgroundColor = [UIColor clearColor];
    tableview.delegate = self;
    tableview.dataSource = self;
    [self.view addSubview:tableview];
    [self setExtraCellLineHidden:tableview];
    [self getcategorylist];
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
    
    UIButton *button = [AddCustomView CusViewButtonForRadius:CGRectMake(20, 40, SCREEN_WIDTH-40, 40) BGColor:COLORNOW(0, 170, 238) Title:@"发布" TitleColor:[UIColor whiteColor] FRadius:3.0f];
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
    UITextField *textfield1 = [tableview viewWithTag:EnTaskAddNewTaskTextfield1];
    UITextField *textfield2 = [tableview viewWithTag:EnTaskAddNewTaskTextfield2];
    UITextField *textfield3 = [tableview viewWithTag:EnTaskAddNewTaskTextfield3];
    UITextField *textfield4 = [tableview viewWithTag:EnTaskAddNewTaskTextfield4];
    UITextField *textfield5 = [tableview viewWithTag:EnTaskAddNewTaskTextfield5];
    UITextField *textfield6 = [tableview viewWithTag:EnTaskAddNewTaskTextfield6];
    UITextField *textfield7 = [tableview viewWithTag:EnTaskAddNewTaskTextfield7];
    UITextField *textfield8 = [tableview viewWithTag:EnTaskAddNewTaskTextfield8];
    UITextField *textfield9 = [tableview viewWithTag:EnTaskAddNewTaskTextfield9];
    FCtaskdescription = textfield2.text;
    FCserviceusername = textfield3.text;
    FCcontactmobile = textfield4.text;
    FCresidencezonename = textfield5.text;
    FCbudget =textfield8.text;
    FCnote = textfield9.text;

    [textfield1 resignFirstResponder];
    [textfield2 resignFirstResponder];
    [textfield3 resignFirstResponder];
    [textfield4 resignFirstResponder];
    [textfield5 resignFirstResponder];
    [textfield6 resignFirstResponder];
    [textfield7 resignFirstResponder];
    [textfield8 resignFirstResponder];
    [textfield9 resignFirstResponder];
}

#pragma mark UITextfieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if(textField.tag == EnTaskAddNewTaskTextfield1)
    {
        [self clickserviceitem];
        return NO;
    }
    else if(textField.tag == EnTaskAddNewTaskTextfield6)
    {
        [self clickaddress];
        return NO;
    }
    else if(textField.tag == EnTaskAddNewTaskTextfield7)
    {
        [self selecttasktime];
        return NO;
    }
    return YES;
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
//    UITextField *textfield1 = [tableview viewWithTag:EnTaskAddNewTaskTextfield1];
    UITextField *textfield2 = [tableview viewWithTag:EnTaskAddNewTaskTextfield2];
    UITextField *textfield3 = [tableview viewWithTag:EnTaskAddNewTaskTextfield3];
    UITextField *textfield4 = [tableview viewWithTag:EnTaskAddNewTaskTextfield4];
    UITextField *textfield5 = [tableview viewWithTag:EnTaskAddNewTaskTextfield5];
//   UITextField *textfield6 = [tableview viewWithTag:EnTaskAddNewTaskTextfield6];
//    UITextField *textfield7 = [tableview viewWithTag:EnTaskAddNewTaskTextfield7];
    UITextField *textfield8 = [tableview viewWithTag:EnTaskAddNewTaskTextfield8];
    UITextField *textfield9 = [tableview viewWithTag:EnTaskAddNewTaskTextfield9];
    FCtaskdescription = [textfield2.text length]>0?textfield2.text:FCtaskdescription;
    FCserviceusername = [textfield3.text length]>0?textfield3.text:FCserviceusername;
    FCcontactmobile = [textfield4.text length]>0?textfield4.text:FCcontactmobile;
    FCresidencezonename = [textfield5.text length]>0?textfield5.text:FCresidencezonename;
    FCbudget = [textfield8.text length]>0?textfield8.text:FCbudget;
    FCnote = [textfield9.text length]>0?textfield9.text:FCnote;
}

#pragma mark 弹窗求
-(void)clickserviceitem  // 选择服务项目
{
    [self keyboardHide:nil];
    NSMutableArray *arraytemp = [[NSMutableArray alloc] init];
    for(int i=0;i<[FCarraycategory count];i++)
    {
        NSDictionary *dictemp  = [FCarraycategory objectAtIndex:i];
        [arraytemp addObject:[dictemp objectForKey:@"name"]];
    }
    
    [ZJBLStoreShopTypeAlert showWithTitle:@"服务项目" titles:arraytemp deleGate1:self selectIndex:^(NSInteger selectIndex) {
    } selectValue:^(NSString *selectValue) {
        DLog(@"selectvalue====%@",selectValue);
        UITextField *textfield = [self.view viewWithTag:EnTaskAddNewTaskTextfield1];
        textfield.text = selectValue;
        FCtaskcategoryid = [AddInterface returnselectid:FCarraycategory SelectValue:selectValue];
        FCtaskcategoryname = selectValue;
    } showCloseButton:YES];
}


#pragma mark 选择地址
-(void)clickaddress  //选择地址
{
    [self keyboardHide:nil];
    AddressSelectInputViewController *addressselect = [[AddressSelectInputViewController alloc] init];
    addressselect.delegate1 = self;
    [self.navigationController pushViewController:addressselect animated:YES];
}

-(void)DGSelectAreaAddress:(NSString *)pstr City:(NSString *)city Area:(NSString *)area Address:(NSString *)address
{
    FCprovicename = pstr;
    FCcity = city;
    FCzone = area;
    FCaddress = address;
    FCstraddress = [NSString stringWithFormat:@"%@%@%@%@",pstr,city,area,address];
    UILabel *labelvalue = [tableview viewWithTag:EnTaskAddNewTaskTextfield6];
    labelvalue.text = FCstraddress;
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
    UITextField *textfield = [tableview viewWithTag:EnTaskAddNewTaskTextfield7];
    textfield.text = date;
    FCexpectservicetime =date;
}

-(void)Clicksave:(id)sender
{
//    UITextField *textfield1 = [tableview viewWithTag:EnTaskAddNewTaskTextfield1];
    UITextField *textfield2 = [tableview viewWithTag:EnTaskAddNewTaskTextfield2];
    UITextField *textfield3 = [tableview viewWithTag:EnTaskAddNewTaskTextfield3];
    UITextField *textfield4 = [tableview viewWithTag:EnTaskAddNewTaskTextfield4];
    UITextField *textfield5 = [tableview viewWithTag:EnTaskAddNewTaskTextfield5];
    //   UITextField *textfield6 = [tableview viewWithTag:EnTaskAddNewTaskTextfield6];
    //    UITextField *textfield7 = [tableview viewWithTag:EnTaskAddNewTaskTextfield7];
    UITextField *textfield8 = [tableview viewWithTag:EnTaskAddNewTaskTextfield8];
    UITextField *textfield9 = [tableview viewWithTag:EnTaskAddNewTaskTextfield9];
    FCtaskdescription = [textfield2.text length]>0?textfield2.text:FCtaskdescription;
    FCserviceusername = [textfield3.text length]>0?textfield3.text:FCserviceusername;
    FCcontactmobile = [textfield4.text length]>0?textfield4.text:FCcontactmobile;
    FCresidencezonename = [textfield5.text length]>0?textfield5.text:FCresidencezonename;
    FCbudget = [textfield8.text length]>0?textfield8.text:FCbudget;
    FCnote = [textfield9.text length]>0?textfield9.text:FCnote;
    if(([FCtaskdescription length]==0)||([FCserviceusername length]==0)||([FCcontactmobile length]==0)||([FCresidencezonename length]==0)||([FCbudget length]==0)||([FCnote length]==0)||([FCaddress length]==0)||([FCexpectservicetime length]==0))
    {
        [MBProgressHUD showError:@"请填写完全任务数据" toView:app.window];
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
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 40;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section == 0)
        return 2;
    else if(section == 1)
        return 4;
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
    
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma mark 接口
//获取任务分类
-(void)getcategorylist
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    
    [RequestInterface doGetJsonWithParametersNoAn:params App:app RequestCode:RQTaskAddNewsTaskCategoryCode ReqUrl:InterfaceRequestUrl ShowView:app.window alwaysdo:^{
        
    } Success:^(NSDictionary *dic) {
        DLog(@"dic====%@",dic);
        if([[dic objectForKey:@"success"] isEqualToString:@"true"])
        {
            FCarraycategory = [[dic objectForKey:@"data"] objectForKey:@"taskcategorylist"];
        }
        else
        {
            [MBProgressHUD showError:[dic objectForKey:@"msg"] toView:app.window];
        }
    } Failur:^(NSString *strmsg) {
        [MBProgressHUD showError:@"请求失败,请检查网络" toView:self.view];
        
    }];
}


-(void)uploadtaskinfo
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"taskid"] = @"";
    params[@"taskcategoryid"] = FCtaskcategoryid;
    params[@"taskdescription"] = FCtaskdescription;
    params[@"serviceusername"] = FCserviceusername;
    params[@"contactmobile"] = FCcontactmobile;
    params[@"residencezonename"] = FCresidencezonename;
    params[@"provicename"] = FCprovicename;
    params[@"cityname"] = FCcity;
    params[@"zonename"] = FCzone;
    params[@"address"] = FCaddress;
    params[@"expectservicetime"] = FCexpectservicetime;
    params[@"budget"] = FCbudget;
    params[@"note"] = FCnote;
    
    DLog(@"params===%@",params);
    
    [RequestInterface doGetJsonWithParametersNoAn:params App:app RequestCode:RQTaskAddNewsTaskInfoCode ReqUrl:InterfaceRequestUrl ShowView:app.window alwaysdo:^{
        
    } Success:^(NSDictionary *dic) {
        DLog(@"dic====%@",dic);
        if([[dic objectForKey:@"success"] isEqualToString:@"true"])
        {
            TaskSendNewDoneViewController *sendnewdone = [[TaskSendNewDoneViewController alloc] init];
            [self.navigationController pushViewController:sendnewdone animated:YES];
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
