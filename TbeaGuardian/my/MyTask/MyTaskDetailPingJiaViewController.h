//
//  MyTaskDetailPingJiaViewController.h
//  TbeaGuardian
//
//  Created by xyy on 2017/9/17.
//  Copyright © 2017年 xyy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyTaskDetailPingJiaViewController : UIViewController<DateTimePickerViewDelegate,ActionDelegate,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,UIScrollViewDelegate,UITextViewDelegate>
{
    UITableView *tableview;
    AppDelegate *app;
    
    NSString *FCStarLevel;
    NSString *FCAppraise;
    NSString *FCPictureList;
    UIImageView *FCimageadd;
    
    UIImageView *FCimagestart;
    
}
@property(nonatomic,strong)NSString *FCtaskcode;
@property(nonatomic,strong)NSString *FCapplyuserid;
@property(nonatomic,strong)NSString *FCtaskId;
@property(nonatomic,strong)NSDictionary *FCtaskperson;
@property (nonatomic, strong) DateTimePickerView *datePickerView;
@property(nonatomic,strong)id<ActionDelegate>delegate1;

@end
