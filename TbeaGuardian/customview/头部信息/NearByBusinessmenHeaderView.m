//
//  NearByBusinessmenHeaderView.m
//  TbeaGuardian
//
//  Created by xyy on 2017/9/20.
//  Copyright © 2017年 xyy. All rights reserved.
//

#import "NearByBusinessmenHeaderView.h"

@implementation NearByBusinessmenHeaderView

-(id)initWithFrame:(CGRect)frame Focus:(NSArray *)focus
{
    self = [super initWithFrame:frame];
    if (self)
    {
        arrayfocus = focus;
        [self initviewloop:arrayfocus];
    }
    return self;
}

-(void)initviewloop:(NSArray *)focus
{
    float nowheight = 180;
    //	if(iphone6)
    //		nowheight = nowheight*iphone6ratio;
    //	else if(iphone6p)
    //		nowheight = nowheight*iphone6pratio;
    
    
    self.backgroundColor = [UIColor clearColor];
    
    NSMutableArray *arraypiclist =  [[NSMutableArray alloc] init];
    for(int i=0;i<[arrayfocus count];i++)
    {
        NSDictionary *dictemp = [arrayfocus objectAtIndex:i];
        NSString *strpic = [dictemp objectForKey:@"picture"];
        [arraypiclist addObject:[strpic length]>0?strpic:@"123"];
    }
    
    self.loop = [[XLsn0wLoop alloc] initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH, nowheight)];
    [self addSubview:self.loop];
    self.loop.xlsn0wDelegate = self;
    self.loop.time = 5;
    [self.loop setPagePosition:PositionBottomCenter];
    [self.loop setPageColor:Colorredcolor andCurrentPageColor:[UIColor whiteColor]];
    //支持gif动态图
    self.loop.imageArray = arraypiclist;
    
    
    
}

#pragma mark XRCarouselViewDelegate
- (void)loopView:(XLsn0wLoop *)loopView clickImageAtIndex:(NSInteger)index {
    NSLog(@"点击了第%ld张图片", index);
    
    if([self.delegate1 respondsToSelector:@selector(DGFocusClickNumberPic:)])
    {
        //	NSArray *focus = [dicfocus objectForKey:@"list"];
        [self.delegate1 DGFocusClickNumberPic:@""];
    }
}

-(void)DGClickTopFunction:(id)sender
{
    
}


//-(void)changepicdescript:(int)currentindex
//{
//	NSArray *arrayfocus = [dicfocus objectForKey:@"list"];
//	NSDictionary *dictemp = [arrayfocus objectAtIndex:currentindex];
//	UILabel *labeltitle = [self viewWithTag:EnFocusTitleLabelTag];
//	labeltitle.text = [dictemp objectForKey:@"title"];
//}

-(void)photoTappedAd:(UIGestureRecognizer*)sender
{
    //	int tagnow = (int)[[sender view] tag];
}

@end
