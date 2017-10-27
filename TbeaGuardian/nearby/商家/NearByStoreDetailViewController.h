//
//  NearByStoreDetailViewController.h
//  TbeaGuardian
//
//  Created by xyy on 2017/9/28.
//  Copyright © 2017年 xyy. All rights reserved.
//

/**店铺详情**/

#import <UIKit/UIKit.h>

@interface NearByStoreDetailViewController : UIViewController<ActionDelegate,UITableViewDelegate,UITableViewDataSource>
{
    UITableView *tableview;
    AppDelegate *app;
    NSDictionary *FCdiccompanyinfo;
    UIImageView *FCimageheader;
}
@property(nonatomic,strong)NSString *FCcompanyid;
@property(nonatomic,strong)id<ActionDelegate>delegate1;

@end
