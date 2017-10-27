//
//  MyDetectListViewController.h
//  TbeaGuardian
//
//  Created by xyy on 2017/9/16.
//  Copyright © 2017年 xyy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyDetectListViewController : UIViewController<ActionDelegate,UITableViewDelegate,UITableViewDataSource>
{
    UITableView *tableview;
    AppDelegate *app;
    
    NSArray *FCarraydata;
    EnMyTaskStatusType entaskstatus;
    
    NSArray *FCstatuslist;
    NSString *FCorderid;
    NSString *FCorderitem;
    NSString *FCcheckstatusid;
    
    //分别对应三种选择的排序状态
    NSString *FCordercode;
    NSString *FCorderstatus;
    NSString *FCorderdate;
    
}

@property(nonatomic,strong)id<ActionDelegate>delegate1;

@end
