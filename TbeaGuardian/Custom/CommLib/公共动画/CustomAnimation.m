//
//  CustomAnimation.m
//  TbeaGuardian
//
//  Created by xyy on 2017/9/22.
//  Copyright © 2017年 xyy. All rights reserved.
//

#import "CustomAnimation.h"

@implementation CustomAnimation

/**
 抖动动画 一般是点击按钮的时候小幅度动画效果
 **/
+(void)CAshakeanimation:(id)sender
{
    UIView *view = sender;
    CABasicAnimation* shake = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    //设置抖动幅度
    shake.fromValue = [NSNumber numberWithFloat:+0.01];
    shake.toValue = [NSNumber numberWithFloat:-0.01];
    shake.duration = 0.1;
    shake.autoreverses = YES; //是否重复
    shake.repeatCount = 1;
    [view.layer addAnimation:shake forKey:@"imageView"];
}

/**
 点击动画 以xy轴左右 放大，缩小 部分
 **/
+(void)CAPOPSpringAnimation:(id)sender
{
    UIView *view = sender;
    POPSpringAnimation *sprintAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPViewScaleXY];
    sprintAnimation.fromValue = [NSValue valueWithCGPoint:CGPointMake(1.02, 1.02)];
    sprintAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(1, 1)];
    sprintAnimation.springBounciness=15;    // 弹簧弹力 取值范围为[0, 20]，默认值为4
    sprintAnimation.springSpeed=10;
    [view pop_addAnimation:sprintAnimation forKey:@"springAnimation"];
}

@end
