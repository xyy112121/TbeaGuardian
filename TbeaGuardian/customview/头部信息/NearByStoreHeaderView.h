//
//  NearByStoreHeaderView.h
//  TbeaGuardian
//
//  Created by xyy on 2017/9/20.
//  Copyright © 2017年 xyy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NearByStoreHeaderView : UIView
{
    AppDelegate *app;
    UIView *viewstore;
    UIView *viewcommity;
    UIView *viewactivity;
    
    EnStoreGoodsPageType enstoregoodsselecttype;
    
}
@property(nonatomic,strong)id<ActionDelegate>delegate1;
-(id)initWithFrame:(CGRect)frame DicFrom:(NSDictionary *)dicfrom SelectItem:(EnStorePageSelectItems)selectitem;
-(id)initWithFrame:(CGRect)frame DicFrom:(NSDictionary *)dicfrom SelectItem:(EnStorePageSelectItems)selectitem GoodSSelectItem:(EnStoreGoodsPageType)goodsselectitem;
//-(void)updateselectitemcolor:(EnStoreGoodsPageType)goodstype Order:(NSString *)order;
@end
