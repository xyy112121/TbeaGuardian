//
//  NearByStoreHeaderView.m
//  TbeaGuardian
//
//  Created by xyy on 2017/9/20.
//  Copyright © 2017年 xyy. All rights reserved.
//

#import "NearByStoreHeaderView.h"

@implementation NearByStoreHeaderView

-(id)initWithFrame:(CGRect)frame DicFrom:(NSDictionary *)dicfrom SelectItem:(EnStorePageSelectItems)selectitem
{
    self = [super initWithFrame:frame];
    if(self)
    {
        app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        self.backgroundColor = [UIColor whiteColor];
        if(selectitem == EnStorePageSlectStore)
            [self initview:dicfrom SelectItem:selectitem];
        else if(selectitem == EnStorePageSlectGoods)
            [self initview:dicfrom SelectItem:selectitem];
        else if(selectitem == EnStorePageActivity)
            [self initview:dicfrom SelectItem:selectitem];
        
    }
    return self;
}

-(id)initWithFrame:(CGRect)frame DicFrom:(NSDictionary *)dicfrom SelectItem:(EnStorePageSelectItems)selectitem GoodSSelectItem:(EnStoreGoodsPageType)goodsselectitem
{
    self = [super initWithFrame:frame];
    if(self)
    {
        app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        self.backgroundColor = [UIColor whiteColor];
        if(selectitem == EnStorePageSlectStore)
            [self initview:dicfrom SelectItem:selectitem];
        else if(selectitem == EnStorePageSlectGoods)
            [self initview:dicfrom SelectItem:selectitem GoodsItem:goodsselectitem];
        
    }
    return self;
}

//全部商品的header
-(void)initview:(NSDictionary *)dicfrom SelectItem:(EnStorePageSelectItems)selectitem GoodsItem:(EnStoreGoodsPageType)goodsselectitem
{
    viewstore = [self initstorebutton:CGRectMake(0, 0, SCREEN_WIDTH/3, 50)];
    [self addSubview:viewstore];
    
    viewcommity = [self initcommitybutton:CGRectMake(SCREEN_WIDTH/3, 0, SCREEN_WIDTH/3, 50)];
    [self addSubview:viewcommity];
    
    viewactivity = [self initactivitybutton:CGRectMake(SCREEN_WIDTH/3*2, 0, SCREEN_WIDTH/3, 50)];
    [self addSubview:viewactivity];
    
    [self setviewbuttoncolor];
    if(selectitem == EnStorePageSlectStore)
    {
        UIImageView *imageview = [self viewWithTag:EnNearByStoreHpControltag1];
        UILabel *label1 = [self viewWithTag:EnNearByStoreHpControltag2];
        imageview.image = LOADIMAGE(@"storeiconblue", @"png");
        label1.textColor = COLORNOW(0, 170, 238);
    }
    else if(selectitem == EnStorePageSlectGoods)
    {
        UILabel *label2 = [self viewWithTag:EnNearByStoreHpControltag3];
        UILabel *label3 = [self viewWithTag:EnNearByStoreHpControltag4];
        label2.textColor = COLORNOW(0, 170, 238);
        label3.textColor = COLORNOW(0, 170, 238);
    }
    else
    {
        UILabel *label4 = [self viewWithTag:EnNearByStoreHpControltag5];
        UILabel *label5 = [self viewWithTag:EnNearByStoreHpControltag6];
        label4.textColor = COLORNOW(0, 170, 238);
        label5.textColor = COLORNOW(0, 170, 238);
    }
    
    UIImageView *imageline1 = [AddCustomView CusViewLine:CGRectMake(0, XYViewBottom(viewstore)+5, SCREEN_WIDTH, 1) BGColor:COLORNOW(230, 230, 230)];
    [self addSubview:imageline1];
    
    if(selectitem == EnStorePageSlectStore)
        [self clickstorepage:nil];
    else if(selectitem == EnStorePageSlectStore)
        [self clickcommitypage:nil];
    else if(selectitem == EnStorePageSlectStore)
        [self clickactivitypage:nil];
    
//    UIView *viewitem = [self getsectionorderitem:goodsselectitem Frame:CGRectMake(0, 55, SCREEN_WIDTH, 40)];
//    [self addSubview:viewitem];
}

//店铺首页的header
-(void)initview:(NSDictionary *)dicfrom SelectItem:(EnStorePageSelectItems)selectitem
{
    viewstore = [self initstorebutton:CGRectMake(0, 0, SCREEN_WIDTH/3, 50)];
    [self addSubview:viewstore];
    
    viewcommity = [self initcommitybutton:CGRectMake(SCREEN_WIDTH/3, 0, SCREEN_WIDTH/3, 50)];
    [self addSubview:viewcommity];
    
    viewactivity = [self initactivitybutton:CGRectMake(SCREEN_WIDTH/3*2, 0, SCREEN_WIDTH/3, 50)];
    [self addSubview:viewactivity];
    
    [self setviewbuttoncolor];
    if(selectitem == EnStorePageSlectStore)
    {
        UIImageView *imageview = [self viewWithTag:EnNearByStoreHpControltag1];
        UILabel *label1 = [self viewWithTag:EnNearByStoreHpControltag2];
        imageview.image = LOADIMAGE(@"storeiconblue", @"png");
        label1.textColor = COLORNOW(0, 170, 238);
    }
    else if(selectitem == EnStorePageSlectGoods)
    {
        UILabel *label2 = [self viewWithTag:EnNearByStoreHpControltag3];
        UILabel *label3 = [self viewWithTag:EnNearByStoreHpControltag4];
        label2.textColor = COLORNOW(0, 170, 238);
        label3.textColor = COLORNOW(0, 170, 238);
    }
    else
    {
        UILabel *label4 = [self viewWithTag:EnNearByStoreHpControltag5];
        UILabel *label5 = [self viewWithTag:EnNearByStoreHpControltag6];
        label4.textColor = COLORNOW(0, 170, 238);
        label5.textColor = COLORNOW(0, 170, 238);
    }
    
    UIImageView *imageline1 = [AddCustomView CusViewLine:CGRectMake(0, XYViewBottom(viewstore)+5, SCREEN_WIDTH, 1) BGColor:COLORNOW(230, 230, 230)];
    [self addSubview:imageline1];
    
    if(selectitem == EnStorePageSlectStore)
        [self clickstorepage:nil];
    else if(selectitem == EnStorePageSlectStore)
        [self clickcommitypage:nil];
    else if(selectitem == EnStorePageSlectStore)
        [self clickactivitypage:nil];
}



-(UIView *)initstorebutton:(CGRect)frame
{
    UIView *viewstoretemp = [[UIView alloc] initWithFrame:frame];
    viewstoretemp.backgroundColor = [UIColor clearColor];
    
    UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake((frame.size.width-18)/2, 8, 18, 18)];
    imageview.image = LOADIMAGE(@"storeiconblue", @"png");
    imageview.tag = EnNearByStoreHpControltag1;
    [viewstoretemp addSubview:imageview];
    
    UILabel *labelname = [AddCustomView CusViewLabelForStyle:CGRectMake(0, 30, frame.size.width, 20) BGColor:[UIColor clearColor] Title:@"店铺首页" TColor:COLORNOW(0, 170, 238) Font:FONTN(15.0f) LineNumber:1];
    labelname.textAlignment =NSTextAlignmentCenter;
    labelname.tag = EnNearByStoreHpControltag2;
    [viewstoretemp addSubview:labelname];
    
    UIButton *buttonstore = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonstore.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
    buttonstore.backgroundColor = [UIColor clearColor];
    [buttonstore addTarget:self action:@selector(clickstorepage:) forControlEvents:UIControlEventTouchUpInside];
    [viewstoretemp addSubview:buttonstore];
    
    return viewstoretemp;
}

-(UIButton *)initbutton:(NSString *)title Frame:(CGRect)frame
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    
    button.titleLabel.font = FONTN(15.0f);
    
    return button;
}

-(UIView *)initcommitybutton:(CGRect)frame
{
    UIView *viewcommitytemp = [[UIView alloc] initWithFrame:frame];
    viewcommitytemp.backgroundColor = [UIColor clearColor];
    
    UILabel *labelnumber = [AddCustomView CusViewLabelForStyle:CGRectMake(0, 3, frame.size.width, 30) BGColor:[UIColor clearColor] Title:@"56" TColor:[UIColor blackColor] Font:FONTB(17.0f) LineNumber:1];
    labelnumber.textAlignment =NSTextAlignmentCenter;
    labelnumber.tag = EnNearByStoreHpControltag3;
    [viewcommitytemp addSubview:labelnumber];
    
    UILabel *labelname = [AddCustomView CusViewLabelForStyle:CGRectMake(0, 30, frame.size.width, 20) BGColor:[UIColor clearColor] Title:@"全部商品" TColor:[UIColor blackColor] Font:FONTN(15.0f) LineNumber:1];
    labelname.textAlignment =NSTextAlignmentCenter;
    labelname.tag = EnNearByStoreHpControltag4;
    [viewcommitytemp addSubview:labelname];
    
    UIButton *buttonstore = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonstore.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
    buttonstore.backgroundColor = [UIColor clearColor];
    [buttonstore addTarget:self action:@selector(clickcommitypage:) forControlEvents:UIControlEventTouchUpInside];
    [viewcommitytemp addSubview:buttonstore];
    
    return viewcommitytemp;
}

-(UIView *)initactivitybutton:(CGRect)frame
{
    UIView *viewcommitytemp = [[UIView alloc] initWithFrame:frame];
    viewcommitytemp.backgroundColor = [UIColor clearColor];
    
    UILabel *labelnumber = [AddCustomView CusViewLabelForStyle:CGRectMake(0, 3, frame.size.width, 30) BGColor:[UIColor clearColor] Title:@"46" TColor:[UIColor blackColor] Font:FONTB(17.0f) LineNumber:1];
    labelnumber.textAlignment =NSTextAlignmentCenter;
    labelnumber.tag = EnNearByStoreHpControltag5;
    [viewcommitytemp addSubview:labelnumber];
    
    UILabel *labelname = [AddCustomView CusViewLabelForStyle:CGRectMake(0, 30, frame.size.width, 20) BGColor:[UIColor clearColor] Title:@"店铺动态" TColor:[UIColor blackColor] Font:FONTN(15.0f) LineNumber:1];
    labelname.textAlignment =NSTextAlignmentCenter;
    labelname.tag = EnNearByStoreHpControltag6;
    [viewcommitytemp addSubview:labelname];
    
    UIButton *buttonstore = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonstore.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
    buttonstore.backgroundColor = [UIColor clearColor];
    [buttonstore addTarget:self action:@selector(clickactivitypage:) forControlEvents:UIControlEventTouchUpInside];
    [viewcommitytemp addSubview:buttonstore];
    
    return viewcommitytemp;
}

-(void)setviewbuttoncolor
{
    UIImageView *imageview = [self viewWithTag:EnNearByStoreHpControltag1];
    UILabel *label1 = [self viewWithTag:EnNearByStoreHpControltag2];
    UILabel *label2 = [self viewWithTag:EnNearByStoreHpControltag3];
    UILabel *label3 = [self viewWithTag:EnNearByStoreHpControltag4];
    UILabel *label4 = [self viewWithTag:EnNearByStoreHpControltag5];
    UILabel *label5 = [self viewWithTag:EnNearByStoreHpControltag6];
    imageview.image = LOADIMAGE(@"storeiconblack", @"png");
    label1.textColor = [UIColor blackColor];
    label2.textColor = [UIColor blackColor];
    label3.textColor = [UIColor blackColor];
    label4.textColor = [UIColor blackColor];
    label5.textColor = [UIColor blackColor];
}

-(void)clickstorepage:(id)sender
{
    [self setviewbuttoncolor];
    UIImageView *imageview = [self viewWithTag:EnNearByStoreHpControltag1];
    UILabel *label1 = [self viewWithTag:EnNearByStoreHpControltag2];
    imageview.image = LOADIMAGE(@"storeiconblue", @"png");
    label1.textColor = COLORNOW(0, 170, 238);
    
    if([_delegate1 respondsToSelector:@selector(DGClickNearByStoreHp:)])
    {
        [_delegate1 DGClickNearByStoreHp:sender];
    }
}

-(void)clickcommitypage:(id)sender
{
    [self setviewbuttoncolor];
    UILabel *label2 = [self viewWithTag:EnNearByStoreHpControltag3];
    UILabel *label3 = [self viewWithTag:EnNearByStoreHpControltag4];
    label2.textColor = COLORNOW(0, 170, 238);
    label3.textColor = COLORNOW(0, 170, 238);
    
    if([_delegate1 respondsToSelector:@selector(DGClickNearByAllCommity:)])
    {
        [_delegate1 DGClickNearByAllCommity:sender];
    }
}

-(void)clickactivitypage:(id)sender
{
    [self setviewbuttoncolor];
    UILabel *label4 = [self viewWithTag:EnNearByStoreHpControltag5];
    UILabel *label5 = [self viewWithTag:EnNearByStoreHpControltag6];
    label4.textColor = COLORNOW(0, 170, 238);
    label5.textColor = COLORNOW(0, 170, 238);
    
    if([_delegate1 respondsToSelector:@selector(DGClickNearByAllActivity:)])
    {
        [_delegate1 DGClickNearByAllActivity:sender];
    }
    
}




@end
