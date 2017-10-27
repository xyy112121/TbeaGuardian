//
//  NearByFloorListViewController.h
//  TbeaGuardian
//
//  Created by xyy on 2017/10/11.
//  Copyright © 2017年 xyy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NearByFloorListViewController : UIViewController<ActionDelegate,XLsn0wLoopDelegate,UITableViewDelegate,UITableViewDataSource>
{
    AppDelegate *app;
    NSArray *FCarrayfocus;
    NSArray *FCarraydata;
    XLsn0wLoop *loop;
    UITableView *tableview;
    
    NSString *FCorderitem;
    NSString *FCorder;


    
    NearByWaterElecitemHeader *waterelecitemheader;
}

@property(nonatomic,strong)NSString *FCcompanyid;
@property(nonatomic,strong)id<ActionDelegate>delegate1;

@end
