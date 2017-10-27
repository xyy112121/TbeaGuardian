//
//  MyDetectDonePingJiaViewController.h
//  TbeaGuardian
//
//  Created by xyy on 2017/9/16.
//  Copyright © 2017年 xyy. All rights reserved.
//
/**已完工 评价**/
#import <UIKit/UIKit.h>

@interface MyDetectDonePingJiaViewController : UIViewController<DateTimePickerViewDelegate,ActionDelegate,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,UIScrollViewDelegate,UITextViewDelegate>
{
    UITableView *tableview;
    AppDelegate *app;
    
    NSString *FCStarLevel;
    NSString *FCAppraise;
    NSString *FCPictureList;
    UIImageView *FCimageadd;
    
    UIImageView *FCimagestart;
    
}
@property(nonatomic,strong)NSString *FCCheckResultId;
@property(nonatomic,strong)NSString *FCvouchernumber;
@property(nonatomic,strong)NSDictionary *FCdetectperson;
@property (nonatomic, strong) DateTimePickerView *datePickerView;
@property(nonatomic,strong)id<ActionDelegate>delegate1;


@end
