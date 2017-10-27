//
//  NearByWaterElecitemHeader.h
//  TbeaGuardian
//
//  Created by xyy on 2017/10/9.
//  Copyright © 2017年 xyy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NearByWaterElecitemHeader : UIView
{
    AppDelegate *app;
    
    NSString *FCorderitemyear;  //从业年限
    NSString *FCorderitemscore; //评分
    NSString *FCorderitemdistance;  //距离
}

@property(nonatomic,strong)id<ActionDelegate>delegate1;
-(id)initWithFrame:(CGRect)frame DicFrom:(NSDictionary *)dicfrom;
@end
