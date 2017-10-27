//
//  RequestInterface.h
//  CcwbNews
//
//  Created by xyy520 on 16/5/19.
//  Copyright © 2016年 谢 毅. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RequestInterface : NSObject

+(AFHTTPSessionManager *)getHTTPManager;
+(AppDelegate *)getAppdelegate;




+(void)doGetJsonWithParametersNoAn:(NSDictionary * )parameters App:(AppDelegate *)app RequestCode:(NSString *)requestcode  ReqUrl:(NSString *)requrl ShowView:(UIView *)showview alwaysdo:(void(^)())always Success:(void (^)(NSDictionary * dic))success Failur:(void (^)(NSString * strmsg))failure;

+(void)doGetJsonWithArraypic:(NSArray * )arrayimage Parameter:(NSDictionary * )parameters App:(AppDelegate *)app RequestCode:(NSString *)requestcode ReqUrl:(NSString *)requrl ShowView:(UIView *)showview alwaysdo:(void(^)())always Success:(void (^)(NSDictionary * dic))success Failur:(void (^)(NSString * strmsg))failure;

+(void)doGetJsonWithParametersNoAn:(NSDictionary * )parameters App:(AppDelegate *)app RequestCode:(NSString *)requestcode ReqUrl:(NSString *)requrl ShowView:(UIView *)showview alwaysdo:(void(^)())always Success:(void (^)(NSDictionary * dic))success; //优商移植过来的接口
@end
