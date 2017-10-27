//
//  SearchNavigateView.h
//  TbeaGuardian
//
//  Created by xyy on 2017/9/27.
//  Copyright © 2017年 xyy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchNavigateView : UIView<UITextFieldDelegate>
{
    NSString *fromflag;
}
@property(nonatomic,strong)id<ActionDelegate>delegate1;
-(id)initWithFrame:(CGRect)frame FromFlag:(NSString *)from;

@end
