//
//  NearByViewCommdityCategoryController.h
//  TbeaGuardian
//
//  Created by xyy on 2017/9/27.
//  Copyright © 2017年 xyy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NearByViewCommdityCategoryController : UIViewController<ActionDelegate,UITableViewDelegate,UITableViewDataSource>
{
    UITableView *tableview;
    AppDelegate *app;
    NSArray *FCarraydata;
}

@property(nonatomic,strong)id<ActionDelegate>delegate1;

@end
