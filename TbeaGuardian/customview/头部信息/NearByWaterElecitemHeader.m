//
//  NearByWaterElecitemHeader.m
//  TbeaGuardian
//
//  Created by xyy on 2017/10/9.
//  Copyright © 2017年 xyy. All rights reserved.
//

#import "NearByWaterElecitemHeader.h"

@implementation NearByWaterElecitemHeader

-(id)initWithFrame:(CGRect)frame DicFrom:(NSDictionary *)dicfrom
{
    self = [super initWithFrame:frame];
    if(self)
    {
        app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        self.backgroundColor = [UIColor whiteColor];
        FCorderitemyear = @"";
        FCorderitemscore = @"";
        FCorderitemdistance = @"";
        [self initview];
        
    }
    return self;
}

-(void)initview
{
    UIImageView *imageline = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
    imageline.backgroundColor = COLORNOW(220, 220, 220);
    [self addSubview:imageline];
    
    
    ButtonItemLayoutView *button1 = [[ButtonItemLayoutView alloc] initWithFrame:CGRectMake(0,0,SCREEN_WIDTH/3,40)];
    [button1.button addTarget:self action:@selector(clickyear:) forControlEvents:UIControlEventTouchUpInside];
    button1.tag = EnMallStoreMangerLinkTypeSelectItem1;
    [button1 updatebuttonitem:EnButtonTextCenter TextStr:@"从业年限" Font:FONTN(14.0f) Color:COLORNOW(117, 117, 117) Image:LOADIMAGE(@"arrawgray", @"png")];
    [self addSubview:button1];
    
    ButtonItemLayoutView *button2 = [[ButtonItemLayoutView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/3,0,SCREEN_WIDTH/3,40)];
    [button2.button addTarget:self action:@selector(clickscore:) forControlEvents:UIControlEventTouchUpInside];
    button2.tag = EnMallStoreMangerLinkTypeSelectItem2;
    [button2 updatebuttonitem:EnButtonTextCenter TextStr:@"评分" Font:FONTN(14.0f) Color:COLORNOW(117, 117, 117) Image:LOADIMAGE(@"arrawgray", @"png")];
    [self addSubview:button2];
    
    ButtonItemLayoutView *button3 = [[ButtonItemLayoutView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/3*2,0,SCREEN_WIDTH/3,40)];
    [button3.button addTarget:self action:@selector(clickdistance:) forControlEvents:UIControlEventTouchUpInside];
    button3.tag = EnMallStoreMangerLinkTypeSelectItem3;
    [button3 updatebuttonitem:EnButtonTextCenter TextStr:@"距离" Font:FONTN(14.0f) Color:COLORNOW(117, 117, 117) Image:LOADIMAGE(@"arrawgray", @"png")];
    [self addSubview:button3];
    
    UIImageView *imageline1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 39, SCREEN_WIDTH, 1)];
    imageline1.backgroundColor = COLORNOW(220, 220, 220);
    [self addSubview:imageline1];
}

-(void)setlayoutbutton
{
    ButtonItemLayoutView *button1 = [self viewWithTag:EnMallStoreMangerLinkTypeSelectItem1];
    ButtonItemLayoutView *button2 = [self viewWithTag:EnMallStoreMangerLinkTypeSelectItem2];
    ButtonItemLayoutView *button3 = [self viewWithTag:EnMallStoreMangerLinkTypeSelectItem3];
    [button1 updateimage:LOADIMAGE(@"arrawgray", @"png")];
    [button1 updatelablecolor:COLORNOW(117, 117, 117)];
    [button2 updateimage:LOADIMAGE(@"arrawgray", @"png")];
    [button2 updatelablecolor:COLORNOW(117, 117, 117)];
    [button3 updateimage:LOADIMAGE(@"arrawgray", @"png")];
    [button3 updatelablecolor:COLORNOW(117, 117, 117)];
}

-(void)clickyear:(id)sender
{
    [self setlayoutbutton];
    ButtonItemLayoutView *button1 = [self viewWithTag:EnMallStoreMangerLinkTypeSelectItem1];
    
    //FCorderitemyear = @"";
    FCorderitemscore = @"";
    FCorderitemdistance = @"";
    
    [button1 updatelablecolor:COLORNOW(0, 170, 238)];
    if([FCorderitemyear length]==0)
    {
        FCorderitemyear = @"desc";
        [button1 updateimage:LOADIMAGE(@"arrawgrayblue", @"png")];
    }
    else if([FCorderitemyear isEqualToString:@"desc"])
    {
        FCorderitemyear = @"asc";
        [button1 updateimage:LOADIMAGE(@"arrawbluegray", @"png")];
    }
    else if([FCorderitemyear isEqualToString:@"asc"])
    {
        FCorderitemyear = @"desc";
        [button1 updateimage:LOADIMAGE(@"arrawgrayblue", @"png")];
    }
    if([self.delegate1 respondsToSelector:@selector(DGSelectGoodsItemSort:OrderItem:)])
    {
        [self.delegate1 DGSelectGoodsItemSort:FCorderitemyear OrderItem:@"workyea"];
    }
}

-(void)clickscore:(id)sender
{
    [self setlayoutbutton];
    ButtonItemLayoutView *button1 = [self viewWithTag:EnMallStoreMangerLinkTypeSelectItem2];
    [button1 updatelablecolor:COLORNOW(0, 170, 238)];
    
    FCorderitemyear = @"";
    //FCorderitemscore = @"";
    FCorderitemdistance = @"";
    
    if([FCorderitemscore length]==0)
    {
        FCorderitemscore = @"desc";
        [button1 updateimage:LOADIMAGE(@"arrawgrayblue", @"png")];
    }
    else if([FCorderitemscore isEqualToString:@"desc"])
    {
        FCorderitemscore = @"asc";
        [button1 updateimage:LOADIMAGE(@"arrawbluegray", @"png")];
    }
    else if([FCorderitemscore isEqualToString:@"asc"])
    {
        FCorderitemscore = @"desc";
        [button1 updateimage:LOADIMAGE(@"arrawgrayblue", @"png")];
    }
    if([self.delegate1 respondsToSelector:@selector(DGSelectGoodsItemSort:OrderItem:)])
    {
        [self.delegate1 DGSelectGoodsItemSort:FCorderitemscore OrderItem:@"starlevel"];
    }
}

-(void)clickdistance:(id)sender
{
    [self setlayoutbutton];
    ButtonItemLayoutView *button1 = [self viewWithTag:EnMallStoreMangerLinkTypeSelectItem3];
    [button1 updatelablecolor:COLORNOW(0, 170, 238)];
    
    FCorderitemyear = @"";
    FCorderitemscore = @"";
    //FCorderitemdistance = @"";
    
    if([FCorderitemdistance length]==0)
    {
        FCorderitemdistance = @"desc";
        [button1 updateimage:LOADIMAGE(@"arrawgrayblue", @"png")];
    }
    else if([FCorderitemdistance isEqualToString:@"desc"])
    {
        FCorderitemdistance = @"asc";
        [button1 updateimage:LOADIMAGE(@"arrawbluegray", @"png")];
    }
    else if([FCorderitemdistance isEqualToString:@"asc"])
    {
        FCorderitemdistance = @"desc";
        [button1 updateimage:LOADIMAGE(@"arrawgrayblue", @"png")];
    }
    if([self.delegate1 respondsToSelector:@selector(DGSelectGoodsItemSort:OrderItem:)])
    {
        [self.delegate1 DGSelectGoodsItemSort:FCorderitemdistance OrderItem:@"distance"];
    }
}

@end
