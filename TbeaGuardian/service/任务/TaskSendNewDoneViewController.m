//
//  TaskSendNewDoneViewController.m
//  TbeaGuardian
//
//  Created by xyy on 2017/9/14.
//  Copyright © 2017年 xyy. All rights reserved.
//

#import "TaskSendNewDoneViewController.h"

@interface TaskSendNewDoneViewController ()

@end

@implementation TaskSendNewDoneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initview];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(2, 2, 60, 40)];
    UIButton *button = [[UIButton alloc] initWithFrame:contentView.bounds];
    button.layer.borderColor = [UIColor clearColor].CGColor;
    [button setImage:LOADIMAGE(@"returnback", @"png") forState:UIControlStateNormal];
    button.imageEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
    [button addTarget:self action: @selector(returnback) forControlEvents: UIControlEventTouchUpInside];
    [contentView addSubview:button];
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:contentView];
    self.navigationItem.leftBarButtonItem = barButtonItem;
    
    UIView *contentViewright = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    UIButton *buttonright = [[UIButton alloc] initWithFrame:contentViewright.bounds];
    [buttonright setTitle:@"查看" forState:UIControlStateNormal];
    buttonright.titleLabel.font = FONTN(15.0f);
    [buttonright setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [buttonright addTarget:self action: @selector(clicklook) forControlEvents: UIControlEventTouchUpInside];
    [contentViewright addSubview:buttonright];
    buttonright.imageEdgeInsets = UIEdgeInsetsMake(0,0, 0, -20);
    UIBarButtonItem *barButtonItemright = [[UIBarButtonItem alloc] initWithCustomView:contentViewright];
    self.navigationItem.rightBarButtonItem = barButtonItemright;

    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBar.translucent = NO;
    [self.navigationController.navigationBar  setBackgroundImage:[[UIImage alloc] init] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    [self.navigationController.navigationBar setBarTintColor:COLORNOW(0, 170, 238)];
    UIColor* color = [UIColor whiteColor];
    NSDictionary* dict=[NSDictionary dictionaryWithObject:color forKey:NSForegroundColorAttributeName];
    self.navigationController.navigationBar.titleTextAttributes= dict;
}



-(void)initview
{
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"任务发布成功";
    //初始化注册按钮之上
    [self initviewtop];
    
    
}

-(void)initviewtop
{
    UIImageView *imageviewicon = [[UIImageView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-70)/2, 50, 70, 70)];
    imageviewicon.image = LOADIMAGE(@"userdone", @"png");
    [self.view addSubview:imageviewicon];
    
    UILabel *labelname = [[UILabel alloc] initWithFrame:CGRectMake(XYViewL(imageviewicon), XYViewBottom(imageviewicon)+5, XYViewWidth(imageviewicon), 20)];
    labelname.text = @"更换成功";
    labelname.font = FONTN(16.0f);
    labelname.backgroundColor = [UIColor clearColor];
    labelname.textAlignment = NSTextAlignmentCenter;
    labelname.textColor = [UIColor blackColor];
    [self.view addSubview:labelname];
    
   
}



#pragma mark IBaction
-(void)returnback
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)clicklook
{
    TaskDetailViewController *taskdetail = [[TaskDetailViewController alloc] init];
    taskdetail.FCtaskid = @"";
    [self.navigationController pushViewController:taskdetail animated:YES];
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
