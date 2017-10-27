//
//  NearByWaterElecPersonViewController.h
//  TbeaGuardian
//
//  Created by xyy on 2017/10/9.
//  Copyright © 2017年 xyy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NearByWaterElecPersonViewController : UIViewController<ActionDelegate>
{
    
    AppDelegate *app;
    EnWaterPersonHpFunctionType functiontype;
    NSDictionary *FCdicdata;
}

@property(nonatomic,strong)NSString *FCelectricianid;
@property(nonatomic,strong)id<ActionDelegate>delegate1;

@end
