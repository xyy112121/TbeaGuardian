//
//  NearByBusinessmenHeaderView.h
//  TbeaGuardian
//
//  Created by xyy on 2017/9/20.
//  Copyright © 2017年 xyy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XLsn0wLoop.h"
@interface NearByBusinessmenHeaderView : UIView<UIScrollViewDelegate,XLsn0wLoopDelegate>
{
    UIScrollView *scrollviewtop;
    NSTimer *timeernow;
    NSArray *arrayfocus;
}
@property(nonatomic,strong)id<ActionDelegate>delegate1;
@property (nonatomic, strong) XLsn0wLoop *loop;
-(id)initWithFrame:(CGRect)frame Focus:(NSArray *)focus;

@end
