//
//  MyDetectDetailQualifiedViewController.h
//  TbeaGuardian
//
//  Created by xyy on 2017/9/17.
//  Copyright © 2017年 xyy. All rights reserved.
//

/**检测详情 哪些合格哪些不合格**/

#import <UIKit/UIKit.h>

@interface MyDetectDetailQualifiedViewController : UIViewController<ActionDelegate,UITableViewDelegate,UITableViewDataSource>
{
    UITableView *tableview;
    AppDelegate *app;
    NSArray *FCelectricalcheckworklist;
    NSString *FCdescription;
}
@property(nonatomic,strong)NSString *FCCheckResultId;
@property(nonatomic,strong)NSMutableArray *FCarrayauthor;
@property(nonatomic,strong)id<ActionDelegate>delegate1;

@end
