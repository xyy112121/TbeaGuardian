//
//  MyWiringDiagramViewController.h
//  TbeaGuardian
//
//  Created by xyy on 2017/9/18.
//  Copyright © 2017年 xyy. All rights reserved.
//

/**我的布线图**/

#import <UIKit/UIKit.h>

@interface MyWiringDiagramViewController : UIViewController<ActionDelegate,UITextFieldDelegate>
{
    AppDelegate *app;
    NSMutableArray *FCarraydata;
    UIImageView *imageviewno;
    UIScrollView *scrollview;
}

@property(nonatomic,strong)NSString *FCfromflag; //1表示可以上传  0表示不可以上传
@property(nonatomic,strong)NSString *FCmettingid;
@property(nonatomic,strong)id<ActionDelegate>delegate1;


@end
