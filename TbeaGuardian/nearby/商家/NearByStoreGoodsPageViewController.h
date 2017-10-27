//
//  NearByStoreGoodsPageViewController.h
//  TbeaGuardian
//
//  Created by xyy on 2017/9/20.
//  Copyright © 2017年 xyy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NearByStoreGoodsitemHeader.h"
@interface NearByStoreGoodsPageViewController : UIViewController<XLsn0wLoopDelegate,ActionDelegate,UITableViewDelegate,UITableViewDataSource>
{
    UITableView *tableview;
    AppDelegate *app;
    NSArray *FCarraydata;
    NSDictionary *FCdicuserinfo;
    
    EnStorePageSelectItems enstoreselectitems;
    EnStoreGoodsPageType enstoregoodsselectitem;
    //参数
    NSArray *FCadvertiselist;
    NSArray *FCsystemmessagelist;
    
    NearByStoreGoodsitemHeader *goodsitemheader;
    NSString *FCorderitem;
    NSString *FCorder;
    NSString *FCorderitemRecommend;  //推荐
    NSString *FCorderitemSaleNumber; //销量
    NSString *FCorderitemTime;  //新品
    NSString *FCorderitemPrice;  //价格
    NSString *FCcommoditycategoryid;
    
    NSMutableArray *arrayheight;//动态列表高度
}

@property (nonatomic, strong) XLsn0wLoop *loop;
@property(nonatomic,strong)NSString *FCcompanyid;
@property(nonatomic,strong)id<ActionDelegate>delegate1;

@end
