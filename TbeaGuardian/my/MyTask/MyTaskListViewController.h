//
//  MyTaskListViewController.h
//  TbeaGuardian
//
//  Created by xyy on 2017/9/15.
//  Copyright © 2017年 xyy. All rights reserved.
//

/**我的任务列表**/

#import <UIKit/UIKit.h>

@interface MyTaskListViewController : UIViewController<ActionDelegate,UITableViewDelegate,UITableViewDataSource>
{
    UITableView *tableview;
    AppDelegate *app;
    
    NSArray *FCarraydata;
    EnMyTaskStatusType entaskstatus;
    
    NSString *FCorderid;
    NSString *FCorderitem;
}

@property(nonatomic,strong)id<ActionDelegate>delegate1;

@end
