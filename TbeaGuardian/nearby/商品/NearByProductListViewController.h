//
//  NearByProductListViewController.h
//  TbeaGuardian
//
//  Created by xyy on 2017/10/9.
//  Copyright © 2017年 xyy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NearByProductListViewController : UIViewController<ActionDelegate,XLsn0wLoopDelegate,UITableViewDelegate,UITableViewDataSource>
{
    AppDelegate *app;
    NSArray *FCarrayfocus;
    NSArray *FCarraydata;
    XLsn0wLoop *loop;
    UITableView *tableview;
    
    NSString *FCorderitem;
    NSString *FCorder;
    NSString *FCorderitemRecommend;  //推荐
    NSString *FCorderitemSaleNumber; //销量
    NSString *FCorderitemTime;  //新品
    NSString *FCorderitemPrice;  //价格
    NSString *FCcommoditycategoryid;
    
    NearByStoreGoodsitemHeader *goodsitemheader;
}

@property(nonatomic,strong)NSString *FCcompanyid;
@property(nonatomic,strong)id<ActionDelegate>delegate1;

@end
