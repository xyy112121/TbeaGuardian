//
//  NearByFloorDetailHeader.m
//  TbeaGuardian
//
//  Created by xyy on 2017/10/13.
//  Copyright © 2017年 xyy. All rights reserved.
//

#import "NearByFloorDetailHeader.h"

@implementation NearByFloorDetailHeader

-(id)initWithFrame:(CGRect)frame DicFrom:(NSDictionary *)dicfrom
{
    self = [super initWithFrame:frame];
    if(self)
    {
        app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        self.backgroundColor = [UIColor whiteColor];
        [self initview:dicfrom];
        
    }
    return self;
}


-(void)initview:(NSDictionary  *)dicbaseinfo
{
    UIImageView *imageviewtop = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 160)];
    imageviewtop.image = LOADIMAGE(@"watertest", @"png");
    UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clicktopimage:)];
    imageviewtop.userInteractionEnabled = YES;
    [imageviewtop addGestureRecognizer:recognizer];
    [self addSubview:imageviewtop];
    
    UIImageView *imagebg = [[UIImageView alloc] initWithFrame:CGRectMake(0,160,SCREEN_WIDTH,XYViewHeight(self)-160)];
    imagebg.backgroundColor = [UIColor whiteColor];
    [self addSubview:imagebg];
    
    NSString *strname = [dicbaseinfo objectForKey:@"buildingzonename"];
    CGSize size = [AddInterface getlablesize:strname Fwidth:200 Fheight:20 Sfont:FONTMEDIUM(17.0f)];
    UILabel *lablename = [[UILabel alloc] initWithFrame:CGRectMake(20, XYViewBottom(imageviewtop)+10, size.width, 20)];
    lablename.text = strname;
    lablename.font = FONTMEDIUM(17.0f);
    lablename.textColor = [UIColor blackColor];
    lablename.backgroundColor = [UIColor clearColor];
    [self addSubview:lablename];
    
    
    
    UILabel *lableaddr = [[UILabel alloc] initWithFrame:CGRectMake(XYViewL(lablename), XYViewBottom(lablename)+5, SCREEN_WIDTH-30, 20)];
    lableaddr.text = [NSString stringWithFormat:@"地址：%@",[dicbaseinfo objectForKey:@"address"]];
    lableaddr.font = FONTN(14.0f);
    lableaddr.textColor = COLORNOW(117, 117, 117);
    lableaddr.backgroundColor = [UIColor clearColor];
    [self addSubview:lableaddr];
    
    UILabel *lablemobile = [[UILabel alloc] initWithFrame:CGRectMake(XYViewL(lablename), XYViewBottom(lableaddr), SCREEN_WIDTH-30, 20)];
    lablemobile.text = [NSString stringWithFormat:@"电话：%@",[dicbaseinfo objectForKey:@"mobilenumber"]];
    lablemobile.font = FONTN(14.0f);
    lablemobile.textColor = COLORNOW(117, 117, 117);
    lablemobile.backgroundColor = [UIColor clearColor];
    [self addSubview:lablemobile];
    
    UILabel *labelnum = [AddCustomView CusViewLabelForStyle:CGRectMake(SCREEN_WIDTH-50,XYViewHeight(imageviewtop)-40, 24, 24) BGColor:[UIColor blackColor] Title:@"10" TColor:[UIColor whiteColor] Font:FONTN(12.0f) LineNumber:1];
    labelnum.layer.cornerRadius = 12.0f;
    labelnum.clipsToBounds = YES;
    labelnum.textAlignment = NSTextAlignmentCenter;
    [self addSubview:labelnum];
    
}

-(void)clicktopimage:(UITapGestureRecognizer *)sender
{
    if([self.delegate1 respondsToSelector:@selector(DGClickFloorPicTop:)])
    {
        [self.delegate1 DGClickFloorPicTop:sender];
    }
    
}

@end
