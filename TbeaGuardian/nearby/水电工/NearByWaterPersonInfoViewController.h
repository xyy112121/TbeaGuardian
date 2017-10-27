//
//  NearByWaterPersonInfoViewController.h
//  TbeaGuardian
//
//  Created by xyy on 2017/10/10.
//  Copyright © 2017年 xyy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NearByWaterPersonInfoViewController : UIViewController<ActionDelegate,UITableViewDelegate,UITableViewDataSource>
{
    UITableView *tableview;
    AppDelegate *app;
    NSDictionary *FCdicuserinfo;
    UIImageView *FCimageheader;
}
@property(nonatomic,strong)NSString *FCelectricianid;
@property(nonatomic,strong)id<ActionDelegate>delegate1;

@end
