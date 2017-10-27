//
//  NeayByBusinessmenLisViewController.h
//  TbeaGuardian
//
//  Created by xyy on 2017/9/19.
//  Copyright © 2017年 xyy. All rights reserved.
//

/**附近商家首页**/

#import <UIKit/UIKit.h>

@interface NeayByBusinessmenLisViewController : UIViewController<ActionDelegate,UITableViewDelegate,UITableViewDataSource>
{
    UITableView *tableview;
    AppDelegate *app;
    NSArray *FCarrayfocus;
    NSArray *FCarraydata;
    NSArray *FCarraytype;
    
    //参数
    NSString *FCcompanytypename;
    NSString *FCcompanytypeid;
    NSString *FCorderitem;
    NSString *FCorder;
}

@property(nonatomic,strong)id<ActionDelegate>delegate1;

@end
