//
//  DetectApplyNewViewController.h
//  TbeaGuardian
//
//  Created by xyy on 2017/9/15.
//  Copyright © 2017年 xyy. All rights reserved.
//

/*申请一个新的免费检测预约*/

#import <UIKit/UIKit.h>

@interface DetectApplyNewViewController : UIViewController<DateTimePickerViewDelegate,ActionDelegate,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,UIScrollViewDelegate,UITextViewDelegate>
{
    UITableView *tableview;
    AppDelegate *app;
    
    NSString *FCvouchernumber;
    NSString *FCsubscribetime;
    NSString *FCnote;
    
}
@property (nonatomic, strong) DateTimePickerView *datePickerView;
@property(nonatomic,strong)id<ActionDelegate>delegate1;


@end
