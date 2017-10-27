//
//  AndyDropDownList.h
//  AndyDropDownList
//
//  Created by 933 on 16/1/29.
//  Copyright © 2016年 Andy. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AndyDropDownDelegate <NSObject>

/**
 *  代理
 */
-(void)dropDownListParame:(NSString *)aStr;
-(void)setAndyDropHideflag:(id)sender;
@end

@interface AndyDropDownList : UIView

/**
 *  下拉列表
 *  @param array       数据源
 *  @param rowHeight   行高
 *  @param v           控制器>>>可根据需求修改
 */
-(id)initWithListDataSource:(NSArray *)array
                  rowHeight:(CGFloat)rowHeight
                       view:(UIView *)v;


-(id)initWithListDataSource:(NSArray *)array
				  rowHeight:(CGFloat)rowHeight
					   view:(UIView *)v
					  Frame:(CGRect)frame;

/**
 *  设置代理
 */
@property(nonatomic,assign)id<AndyDropDownDelegate>delegate;

/**
 *   显示下拉列表
 */
-(void)showList;
/**
 *   隐藏
 */
-(void)hiddenList;
@end
