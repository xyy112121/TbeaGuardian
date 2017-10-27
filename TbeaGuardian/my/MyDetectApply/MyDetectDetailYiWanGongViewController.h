//
//  MyDetectDetailYiWanGongViewController.h
//  TbeaGuardian
//
//  Created by xyy on 2017/9/16.
//  Copyright © 2017年 xyy. All rights reserved.
//
/**检测预约 已完工**/
#import <UIKit/UIKit.h>

@interface MyDetectDetailYiWanGongViewController : UIViewController<DateTimePickerViewDelegate,ActionDelegate,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,UIScrollViewDelegate,UITextViewDelegate>
{
    UITableView *tableview;
    AppDelegate *app;
    
    NSString *FCvouchercode;
    NSString *FCsubscribetime;
    NSString *FCstatus;
    NSString *FCdontime;
    NSDictionary *FCdetectperson;
    NSString *FCcheckresultid;
    
    NSDictionary *FCdicdetectdetai;
}
@property(nonatomic,strong)NSString *FCcheckid;
@property(nonatomic,strong)id<ActionDelegate>delegate1;


@end
