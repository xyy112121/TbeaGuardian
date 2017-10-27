//
//  NearByFloorPicarrangementViewController.h
//  TbeaGuardian
//
//  Created by xyy on 2017/10/13.
//  Copyright © 2017年 xyy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LLPhotoBrowser.h"
@interface NearByFloorPicarrangementViewController : UIViewController<ActionDelegate,UITextFieldDelegate,LLPhotoBrowserDelegate>
{
    AppDelegate *app;
    NSMutableArray *FCarraydata;
    UIImageView *imageviewno;
    
}
@property(nonatomic,strong)NSMutableArray *photoArr;
@property(nonatomic,strong)NSString *FCbuildingzoneid;
@property(nonatomic,strong)id<ActionDelegate>delegate1;

@end
