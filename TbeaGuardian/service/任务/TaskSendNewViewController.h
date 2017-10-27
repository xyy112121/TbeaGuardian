//
//  TaskSendNewViewController.h
//  TbeaGuardian
//
//  Created by xyy on 2017/9/14.
//  Copyright © 2017年 xyy. All rights reserved.
//

/**
 发布任务
 **/

#import <UIKit/UIKit.h>

@interface TaskSendNewViewController : UIViewController<DateTimePickerViewDelegate,ActionDelegate,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,UIScrollViewDelegate,UITextViewDelegate>
{
    UITableView *tableview;
    AppDelegate *app;
    
    NSString *FCtaskid;
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

}
@property (nonatomic, strong) DateTimePickerView *datePickerView;
@property(nonatomic,strong)id<ActionDelegate>delegate1;

@end
