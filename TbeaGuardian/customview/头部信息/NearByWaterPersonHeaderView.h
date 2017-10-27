//
//  NearByWaterPersonHeaderView.h
//  TbeaGuardian
//
//  Created by xyy on 2017/10/10.
//  Copyright © 2017年 xyy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NearByWaterPersonHeaderView : UIView
{
    AppDelegate *app;
}
@property(nonatomic,strong)id<ActionDelegate>delegate1;
-(id)initWithFrame:(CGRect)frame DicFrom:(NSDictionary *)dicfrom;
@end
