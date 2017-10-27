//
//  NearByStoreGoodsitemHeader.h
//  TbeaGuardian
//
//  Created by xyy on 2017/9/27.
//  Copyright © 2017年 xyy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NearByStoreGoodsitemHeader : UIView
{
    AppDelegate *app;
    
    NSString *FCorderitemRecommend;  //推荐
    NSString *FCorderitemSaleNumber; //销量
    NSString *FCorderitemTime;  //新品
    NSString *FCorderitemPrice;  //价格
}

@property(nonatomic,strong)id<ActionDelegate>delegate1;
-(id)initWithFrame:(CGRect)frame DicFrom:(NSDictionary *)dicfrom SelectItem:(EnStorePageSelectItems)selectitem GoodSSelectItem:(EnStoreGoodsPageType)goodsselectitem;

@end
