//
//  NearByProductDetailViewController.h
//  TbeaGuardian
//
//  Created by 谢毅 on 2017/11/24.
//  Copyright © 2017年 xyy. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface NearByProductDetailViewController : UIViewController<WKUIDelegate,WKScriptMessageHandler,WKNavigationDelegate,ActionDelegate,LLPhotoBrowserDelegate,YBPopupMenuDelegate>
{
    AppDelegate *app;
    WKWebView   *wkwebview;
    WKUserContentController * userContentController;
    YBPopupMenu *ybpopmenu;
    NSMutableArray *FCphotoArr;
    NSArray *FCarraypic;
    int FCnowpage;
}
@property(nonatomic,strong)NSDictionary *FCdicproduct;
@property(nonatomic,strong)id<ActionDelegate>delegate1;
@property(nonatomic,strong)NSString *strurl;

@end
