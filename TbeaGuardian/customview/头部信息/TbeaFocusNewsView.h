//
//  TbeaFocusNewsView.h
//  TbeaGuardian
//
//  Created by xyy on 2017/9/13.
//  Copyright © 2017年 xyy. All rights reserved.
//

/*特变电工首页*/

#import <UIKit/UIKit.h>
#import "XLsn0wLoop.h"
@interface TbeaFocusNewsView : UIView<UIScrollViewDelegate,XLsn0wLoopDelegate>
{
    UIScrollView *scrollviewtop;
    NSTimer *timeernow;
    NSArray *arrayfocus;
}
@property(nonatomic,strong)id<ActionDelegate>delegate1;
@property (nonatomic, strong) XLsn0wLoop *loop;
-(id)initWithFrame:(CGRect)frame Focus:(NSArray *)focus;

@end
