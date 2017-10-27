//
//  ServiceReserveViewController.h
//  TbeaGuardian
//
//  Created by xyy on 2017/9/8.
//  Copyright © 2017年 xyy. All rights reserved.
//

/**预约服务首页**/

#import <UIKit/UIKit.h>

@interface ServiceReserveViewController : UIViewController<ActionDelegate>
{
    UITableView *tableview;
    AppDelegate *app;
    NSArray *FCsystemmessagelistt;
    NSDictionary *FCdicuserpersoninfo;
    UIView *FCviewmiddle;
}

@property(nonatomic,strong)id<ActionDelegate>delegate1;

@end
