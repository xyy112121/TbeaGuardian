//
//  SearchNavigateView.m
//  TbeaGuardian
//
//  Created by xyy on 2017/9/27.
//  Copyright © 2017年 xyy. All rights reserved.
//

#import "SearchNavigateView.h"

@implementation SearchNavigateView

-(id)initWithFrame:(CGRect)frame FromFlag:(NSString *)from
{
    self = [super initWithFrame:frame];
    if (self)
    {
        fromflag = from;
        if([from isEqualToString:@"1"])
            [self initview];
        else if([from isEqualToString:@"2"])
            [self initviewnearbyproduct:@"商品"];
        else if([from isEqualToString:@"3"])
            [self initviewnearbyproduct:@"水电工"];
        else if([from isEqualToString:@"4"])
            [self initviewwithrightbutton:@"楼盘"];
            
    }
    return self;
}

-(void)initview
{
    self.backgroundColor = COLORNOW(0, 170, 238);
    
    UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(0, (self.frame.size.height-28)/2, SCREEN_WIDTH-120, 28)];
    imageview.layer.cornerRadius = 4.0f;
    imageview.clipsToBounds = YES;
    imageview.backgroundColor = [UIColor whiteColor];
    [self addSubview:imageview];
    
    UIImageView *imageviewsearch = [[UIImageView alloc] initWithFrame:CGRectMake(imageview.frame.origin.x+5,imageview.frame.origin.y+6, 16, 16)];
    imageviewsearch.image = LOADIMAGE(@"hp_searchicon", @"png");
    [self addSubview:imageviewsearch];
    
    
    UITextField *textfield = [[UITextField alloc] initWithFrame:CGRectMake(imageviewsearch.frame.origin.x+imageviewsearch.frame.size.width+3, imageview.frame.origin.y+2, imageview.frame.size.width-imageviewsearch.frame.size.width-10, 24)];
    textfield.backgroundColor = [UIColor clearColor];
    textfield.delegate = self;
    textfield.font = FONTN(14.0f);
    textfield.placeholder = @"输入关键词模糊查询";
    [self addSubview:textfield];
    
    UIButton *buttonright = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonright.frame = CGRectMake(XYViewWidth(self)-40, 0, 30, 44);
    buttonright.tag = 900;
    buttonright.backgroundColor = [UIColor clearColor];
    [buttonright setImage:LOADIMAGE(@"threewhitepoint", @"png") forState:UIControlStateNormal];
    [buttonright addTarget:self action: @selector(morepoint:) forControlEvents: UIControlEventTouchUpInside];
    [self addSubview:buttonright];
    
    UIButton *buttonright1 = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonright1.frame = CGRectMake(XYViewL(buttonright)-35, 0, 30, 44);
    buttonright1.tag = 900;
    buttonright1.backgroundColor = [UIColor clearColor];
    [buttonright1 setImage:LOADIMAGE(@"收藏", @"png") forState:UIControlStateNormal];
    [buttonright1 addTarget:self action: @selector(clickcollection:) forControlEvents: UIControlEventTouchUpInside];
    [self addSubview:buttonright1];
    
    UIButton *buttonright2 = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonright2.frame = CGRectMake(XYViewL(buttonright1)-35, 0, 30, 44);
    buttonright2.tag = 900;
    buttonright2.backgroundColor = [UIColor clearColor];
    [buttonright2 setImage:LOADIMAGE(@"商品分类", @"png") forState:UIControlStateNormal];
    [buttonright2 addTarget:self action: @selector(clickcategory:) forControlEvents: UIControlEventTouchUpInside];
    [self addSubview:buttonright2];

    imageview.frame = CGRectMake(0, (self.frame.size.height-28)/2, XYViewL(buttonright2)-10, 28);
    textfield.frame = CGRectMake(imageviewsearch.frame.origin.x+imageviewsearch.frame.size.width+3, imageview.frame.origin.y+2, XYViewL(buttonright2)-10-30-2, 24);
}

-(void)initviewnearbyproduct:(NSString *)productstr
{
    self.backgroundColor = COLORNOW(0, 170, 238);
    
    UILabel *labeltitle = [AddCustomView CusViewLabelTitle:CGRectMake(0, 2, 50, 40) BGColor:[UIColor clearColor] Title:productstr TitleColor:[UIColor whiteColor]];
    [self addSubview:labeltitle];
    
    UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(XYViewR(labeltitle)+10, (self.frame.size.height-28)/2, SCREEN_WIDTH-160, 28)];
    imageview.layer.cornerRadius = 4.0f;
    imageview.clipsToBounds = YES;
    imageview.backgroundColor = [UIColor whiteColor];
    [self addSubview:imageview];
    
    UIImageView *imageviewsearch = [[UIImageView alloc] initWithFrame:CGRectMake(imageview.frame.origin.x+5,imageview.frame.origin.y+6, 16, 16)];
    imageviewsearch.image = LOADIMAGE(@"hp_searchicon", @"png");
    [self addSubview:imageviewsearch];
    
    UITextField *textfield = [[UITextField alloc] initWithFrame:CGRectMake(imageviewsearch.frame.origin.x+imageviewsearch.frame.size.width+3, imageview.frame.origin.y+2, imageview.frame.size.width-imageviewsearch.frame.size.width-10, 24)];
    textfield.backgroundColor = [UIColor clearColor];
    textfield.delegate = self;
    textfield.font = FONTN(14.0f);
    textfield.placeholder = @"输入关键词模糊查询";
    [self addSubview:textfield];
    
    UIButton *buttonQrcode = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonQrcode.layer.borderColor = [UIColor clearColor].CGColor;
    buttonQrcode.frame= CGRectMake(SCREEN_WIDTH-50, 2, 40, 40);
    [buttonQrcode setImage:LOADIMAGE(@"hpscanqr", @"png") forState:UIControlStateNormal];
    [buttonQrcode addTarget:self action:@selector(gotoqrcode:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:buttonQrcode];
}

-(void)initviewwithrightbutton :(NSString *)productstr
{
    self.backgroundColor = COLORNOW(0, 170, 238);
    
    UILabel *labeltitle = [AddCustomView CusViewLabelTitle:CGRectMake(0, 2, 50, 40) BGColor:[UIColor clearColor] Title:productstr TitleColor:[UIColor whiteColor]];
    [self addSubview:labeltitle];
    
    UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(XYViewR(labeltitle)+10, (self.frame.size.height-28)/2, SCREEN_WIDTH-120, 28)];
    imageview.layer.cornerRadius = 4.0f;
    imageview.clipsToBounds = YES;
    imageview.backgroundColor = [UIColor whiteColor];
    [self addSubview:imageview];
    
    UIImageView *imageviewsearch = [[UIImageView alloc] initWithFrame:CGRectMake(imageview.frame.origin.x+5,imageview.frame.origin.y+6, 16, 16)];
    imageviewsearch.image = LOADIMAGE(@"hp_searchicon", @"png");
    [self addSubview:imageviewsearch];
    
    UITextField *textfield = [[UITextField alloc] initWithFrame:CGRectMake(imageviewsearch.frame.origin.x+imageviewsearch.frame.size.width+3, imageview.frame.origin.y+2, imageview.frame.size.width-imageviewsearch.frame.size.width-10, 24)];
    textfield.backgroundColor = [UIColor clearColor];
    textfield.delegate = self;
    textfield.font = FONTN(14.0f);
    textfield.placeholder = @"输入关键词模糊查询";
    [self addSubview:textfield];
    
    //    imageview.frame = CGRectMake(0, (self.frame.size.height-28)/2, XYViewL(buttonright2)-10, 28);
    //    textfield.frame = CGRectMake(imageviewsearch.frame.origin.x+imageviewsearch.frame.size.width+3, imageview.frame.origin.y+2, XYViewL(buttonright2)-10-30-2, 24);
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if([self.delegate1 respondsToSelector:@selector(DGClickGoToSearch:)])
    {
        [self.delegate1 DGClickGoToSearch:nil];
    }
    return NO;
}

-(void)morepoint:(id)sender
{
    if([self.delegate1 respondsToSelector:@selector(DGCLickScanCode:)])
    {
        [self.delegate1 DGCLickScanCode:nil];
    }
}

-(void)clickcollection:(id)sender
{
    if([self.delegate1 respondsToSelector:@selector(DGCLickScanCode:)])
    {
        [self.delegate1 DGCLickScanCode:nil];
    }
}

-(void)clickcategory:(id)sender
{
    if([self.delegate1 respondsToSelector:@selector(DGCLickNearByStoreGoodsCategory:)])
    {
        [self.delegate1 DGCLickNearByStoreGoodsCategory:nil];
    }
}

-(void)gotoqrcode:(id)sender
{
    
}


@end
