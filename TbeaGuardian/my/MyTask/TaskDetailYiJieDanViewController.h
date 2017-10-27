//
//  TaskDetailYiJieDanViewController.h
//  TbeaGuardian
//
//  Created by xyy on 2017/9/17.
//  Copyright © 2017年 xyy. All rights reserved.
//

/**任务  已接单详情**/

#import <UIKit/UIKit.h>

@interface TaskDetailYiJieDanViewController : UIViewController<DateTimePickerViewDelegate,ActionDelegate,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,UIScrollViewDelegate,UITextViewDelegate>
{
    UITableView *tableview;
    AppDelegate *app;
    
    
    NSString *FCtaskcategoryid;
    NSString *FCtaskcategoryname;
    NSString *FCtaskdescription;
    NSString *FCserviceusername;
    NSString *FCcontactmobile;
    NSString *FCresidencezonename;
    NSString *FCspecialmodelname;
    NSString *FCprovicename;
    NSString *FCcity;
    NSString *FCzone;
    NSString *FCaddress;
    NSString *FCstraddress;
    NSString *FCexpectservicetime;
    NSString *FCbudget;
    NSString *FCnote;
    
    NSArray *FCarraycategory;
    
    NSMutableArray *FCbidlist;
    PayPopConfirmView *alertpop;
}
@property(nonatomic,strong)NSString *FCtaskid;
@property (nonatomic, strong) DateTimePickerView *datePickerView;
@property(nonatomic,strong)id<ActionDelegate>delegate1;

@end
