//
//  NearByFloorDetailViewController.h
//  TbeaGuardian
//
//  Created by xyy on 2017/10/12.
//  Copyright © 2017年 xyy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NearByFloorDetailViewController : UIViewController<ActionDelegate,UITableViewDelegate,UITableViewDataSource>
{
    
    AppDelegate *app;
    EnWaterPersonHpFunctionType functiontype;
    NSDictionary *FCdicbuildingzoneinfo;
    NSArray *FCarraydata;
    
    UITableView *tableview;
}

@property(nonatomic,strong)NSString *FCbuildingzoneid;
@property(nonatomic,strong)id<ActionDelegate>delegate1;

@end
