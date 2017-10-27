//
//  NearByViewController.h
//  TbeaGuardian
//
//  Created by xyy on 2017/9/8.
//  Copyright © 2017年 xyy. All rights reserved.
//

/**附近首页**/

#import <UIKit/UIKit.h>

@interface NearByViewController : UIViewController<ActionDelegate,UITableViewDelegate,UITableViewDataSource>
{
    UITableView *tableview;
    AppDelegate *app;
    NSArray *FCarrayfocus;
    NSArray *FCarrayproduct;
    NSArray *FCarraymessage;
}

@property(nonatomic,strong)id<ActionDelegate>delegate1;

@end
