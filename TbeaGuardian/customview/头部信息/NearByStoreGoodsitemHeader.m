//
//  NearByStoreGoodsitemHeader.m
//  TbeaGuardian
//
//  Created by xyy on 2017/9/27.
//  Copyright © 2017年 xyy. All rights reserved.
//

#import "NearByStoreGoodsitemHeader.h"

@implementation NearByStoreGoodsitemHeader

-(id)initWithFrame:(CGRect)frame DicFrom:(NSDictionary *)dicfrom SelectItem:(EnStorePageSelectItems)selectitem GoodSSelectItem:(EnStoreGoodsPageType)goodsselectitem
{
    self = [super initWithFrame:frame];
    if(self)
    {
        app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        self.backgroundColor = [UIColor whiteColor];
        FCorderitemRecommend = @"";
        FCorderitemSaleNumber = @"";
        FCorderitemPrice = @"";
        FCorderitemTime =@"";
        [self initview:goodsselectitem];
        
    }
    return self;
}

-(void)initview:(EnStoreGoodsPageType)goodsselectitem
{
    UIImageView *imageline = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
    imageline.backgroundColor = COLORNOW(220, 220, 220);
    [self addSubview:imageline];
    
    
    ButtonItemLayoutView *button1 = [[ButtonItemLayoutView alloc] initWithFrame:CGRectMake(0,0,SCREEN_WIDTH/4,40)];
    [button1.button addTarget:self action:@selector(clickrecomment:) forControlEvents:UIControlEventTouchUpInside];
    button1.tag = EnMallStoreMangerLinkTypeSelectItem1;
    [button1 updatebuttonitem:EnButtonTextCenter TextStr:@"推荐" Font:FONTN(14.0f) Color:COLORNOW(117, 117, 117) Image:LOADIMAGE(@"arrawgray", @"png")];
    [self addSubview:button1];
//    if(goodsselectitem == EnStoreGOodsPageRecommand)
//        [button1 updatelablecolor:COLORNOW(0, 170, 236)];
    
    ButtonItemLayoutView *button2 = [[ButtonItemLayoutView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/4,0,SCREEN_WIDTH/4,40)];
    [button2.button addTarget:self action:@selector(clicksalenumber:) forControlEvents:UIControlEventTouchUpInside];
    button2.tag = EnMallStoreMangerLinkTypeSelectItem2;
    [button2 updatebuttonitem:EnButtonTextCenter TextStr:@"销量" Font:FONTN(14.0f) Color:COLORNOW(117, 117, 117) Image:LOADIMAGE(@"arrawgray", @"png")];
    [self addSubview:button2];
    if(goodsselectitem == EnStoreGOodsPageSaleNumber)
        [button2 updatelablecolor:COLORNOW(0, 170, 236)];
    
    ButtonItemLayoutView *button3 = [[ButtonItemLayoutView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/4*2,0,SCREEN_WIDTH/4,40)];
    [button3.button addTarget:self action:@selector(clicktime:) forControlEvents:UIControlEventTouchUpInside];
    button3.tag = EnMallStoreMangerLinkTypeSelectItem3;
    [button3 updatebuttonitem:EnButtonTextCenter TextStr:@"新品" Font:FONTN(14.0f) Color:COLORNOW(117, 117, 117) Image:LOADIMAGE(@"arrawgray", @"png")];
    [self addSubview:button3];
    if(goodsselectitem == EnStoreGOodsPageTime)
        [button3 updatelablecolor:COLORNOW(0, 170, 236)];
    
    ButtonItemLayoutView *buttonitemmoney = [[ButtonItemLayoutView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/4*3, 0, SCREEN_WIDTH/4, 40)];
    [buttonitemmoney.button addTarget:self action:@selector(clickprice:) forControlEvents:UIControlEventTouchUpInside];
    buttonitemmoney.tag = EnMallStoreMangerLinkTypeSelectItem4;
    [buttonitemmoney updatebuttonitem:EnButtonTextCenter TextStr:@"价格" Font:FONTN(14.0f) Color:COLORNOW(117, 117, 117) Image:LOADIMAGE(@"arrawgray", @"png")];
    [self addSubview:buttonitemmoney];
    if(goodsselectitem == EnStoreGOodsPagePrice)
        [buttonitemmoney updatelablecolor:COLORNOW(0, 170, 236)];
    
    UIImageView *imageline1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 39, SCREEN_WIDTH, 1)];
    imageline1.backgroundColor = COLORNOW(220, 220, 220);
    [self addSubview:imageline1];
}

-(void)setlayoutbutton
{
    ButtonItemLayoutView *button1 = [self viewWithTag:EnMallStoreMangerLinkTypeSelectItem1];
    ButtonItemLayoutView *button2 = [self viewWithTag:EnMallStoreMangerLinkTypeSelectItem2];
    ButtonItemLayoutView *button3 = [self viewWithTag:EnMallStoreMangerLinkTypeSelectItem3];
    ButtonItemLayoutView *button4 = [self viewWithTag:EnMallStoreMangerLinkTypeSelectItem4];
    [button1 updateimage:LOADIMAGE(@"arrawgray", @"png")];
    [button1 updatelablecolor:COLORNOW(117, 117, 117)];
    [button2 updateimage:LOADIMAGE(@"arrawgray", @"png")];
    [button2 updatelablecolor:COLORNOW(117, 117, 117)];
    [button3 updateimage:LOADIMAGE(@"arrawgray", @"png")];
    [button3 updatelablecolor:COLORNOW(117, 117, 117)];
    [button4 updateimage:LOADIMAGE(@"arrawgray", @"png")];
    [button4 updatelablecolor:COLORNOW(117, 117, 117)];
}

-(void)clickrecomment:(id)sender
{
    [self setlayoutbutton];
    ButtonItemLayoutView *button1 = [self viewWithTag:EnMallStoreMangerLinkTypeSelectItem1];
    
    FCorderitemSaleNumber = @"";
    FCorderitemTime = @"";
    FCorderitemPrice = @"";
    
    [button1 updatelablecolor:COLORNOW(0, 170, 238)];
    if([FCorderitemRecommend length]==0)
    {
        FCorderitemRecommend = @"desc";
        [button1 updateimage:LOADIMAGE(@"arrawgrayblue", @"png")];
    }
    else if([FCorderitemRecommend isEqualToString:@"desc"])
    {
        FCorderitemRecommend = @"asc";
        [button1 updateimage:LOADIMAGE(@"arrawbluegray", @"png")];
    }
    else if([FCorderitemRecommend isEqualToString:@"asc"])
    {
        FCorderitemRecommend = @"desc";
        [button1 updateimage:LOADIMAGE(@"arrawgrayblue", @"png")];
    }
    if([self.delegate1 respondsToSelector:@selector(DGSelectGoodsItemSort:OrderItem:)])
    {
        [self.delegate1 DGSelectGoodsItemSort:FCorderitemRecommend OrderItem:@"recommend"];
    }
}

-(void)clicksalenumber:(id)sender
{
    [self setlayoutbutton];
    ButtonItemLayoutView *button1 = [self viewWithTag:EnMallStoreMangerLinkTypeSelectItem2];
    [button1 updatelablecolor:COLORNOW(0, 170, 238)];

    FCorderitemRecommend = @"";
    FCorderitemTime = @"";
    FCorderitemPrice = @"";
    
    if([FCorderitemSaleNumber length]==0)
    {
        FCorderitemSaleNumber = @"desc";
        [button1 updateimage:LOADIMAGE(@"arrawgrayblue", @"png")];
    }
    else if([FCorderitemSaleNumber isEqualToString:@"desc"])
    {
        FCorderitemSaleNumber = @"asc";
        [button1 updateimage:LOADIMAGE(@"arrawbluegray", @"png")];
    }
    else if([FCorderitemSaleNumber isEqualToString:@"asc"])
    {
        FCorderitemSaleNumber = @"desc";
        [button1 updateimage:LOADIMAGE(@"arrawgrayblue", @"png")];
    }
    if([self.delegate1 respondsToSelector:@selector(DGSelectGoodsItemSort:OrderItem:)])
    {
        [self.delegate1 DGSelectGoodsItemSort:FCorderitemSaleNumber OrderItem:@"salenumber"];
    }
}

-(void)clicktime:(id)sender
{
    [self setlayoutbutton];
    ButtonItemLayoutView *button1 = [self viewWithTag:EnMallStoreMangerLinkTypeSelectItem3];
    [button1 updatelablecolor:COLORNOW(0, 170, 238)];

    FCorderitemRecommend = @"";
    FCorderitemSaleNumber = @"";
    FCorderitemPrice = @"";
    
    if([FCorderitemTime length]==0)
    {
        FCorderitemTime = @"desc";
        [button1 updateimage:LOADIMAGE(@"arrawgrayblue", @"png")];
    }
    else if([FCorderitemTime isEqualToString:@"desc"])
    {
        FCorderitemTime = @"asc";
        [button1 updateimage:LOADIMAGE(@"arrawbluegray", @"png")];
    }
    else if([FCorderitemTime isEqualToString:@"asc"])
    {
        FCorderitemTime = @"desc";
        [button1 updateimage:LOADIMAGE(@"arrawgrayblue", @"png")];
    }
    if([self.delegate1 respondsToSelector:@selector(DGSelectGoodsItemSort:OrderItem:)])
    {
        [self.delegate1 DGSelectGoodsItemSort:FCorderitemTime OrderItem:@"time"];
    }
}

-(void)clickprice:(id)sender
{
    [self setlayoutbutton];
    ButtonItemLayoutView *button1 = [self viewWithTag:EnMallStoreMangerLinkTypeSelectItem4];
    [button1 updatelablecolor:COLORNOW(0, 170, 238)];
    
    FCorderitemRecommend = @"";
    FCorderitemSaleNumber = @"";
    FCorderitemTime = @"";
    
    if([FCorderitemPrice length]==0)
    {
        FCorderitemPrice = @"desc";
        [button1 updateimage:LOADIMAGE(@"arrawgrayblue", @"png")];
    }
    else if([FCorderitemPrice isEqualToString:@"desc"])
    {
        FCorderitemPrice = @"asc";
        [button1 updateimage:LOADIMAGE(@"arrawbluegray", @"png")];
    }
    else if([FCorderitemPrice isEqualToString:@"asc"])
    {
        FCorderitemPrice = @"desc";
        [button1 updateimage:LOADIMAGE(@"arrawgrayblue", @"png")];
    }
    if([self.delegate1 respondsToSelector:@selector(DGSelectGoodsItemSort:OrderItem:)])
    {
        [self.delegate1 DGSelectGoodsItemSort:FCorderitemPrice OrderItem:@"price"];
    }
}

@end
