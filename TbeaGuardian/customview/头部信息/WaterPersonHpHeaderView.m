//
//  WaterPersonHpHeaderView.m
//  TbeaCloudBusiness
//
//  Created by xyy520 on 17/5/31.
//  Copyright © 2017年 谢 毅. All rights reserved.
//

#import "WaterPersonHpHeaderView.h"

@implementation WaterPersonHpHeaderView

-(id)initWithFrame:(CGRect)frame DicFrom:(NSDictionary *)dicfrom
{
	self = [super initWithFrame:frame];
	if(self)
	{
		app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
		self.backgroundColor = [UIColor clearColor];
		[self initview:dicfrom];
		
	}
	return self;
}


-(void)initview:(NSDictionary  *)dicfrom
{
    NSDictionary *dicbaseinfo = dicfrom;
	UIImageView *imageviewtop = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 140)];
    [imageviewtop setImageWithURL:[NSURL URLWithString:[dicbaseinfo objectForKey:@"123"]] placeholderImage:LOADIMAGE(@"watertest", @"png")];
	[self addSubview:imageviewtop];
	
//	UIImageView *imagebg = [[UIImageView alloc] initWithFrame:CGRectMake(0,140,SCREEN_WIDTH,XYViewHeight(self)-140)];
//	imagebg.backgroundColor = [UIColor whiteColor];
//	[self addSubview:imagebg];
	
	NSString *strname = [dicbaseinfo objectForKey:@"companyname"];
	CGSize size = [AddInterface getlablesize:strname Fwidth:200 Fheight:20 Sfont:FONTMEDIUM(17.0f)];
	UILabel *lablename = [[UILabel alloc] initWithFrame:CGRectMake(20, XYViewBottom(imageviewtop)+10, size.width, 20)];
	lablename.text = strname;
	lablename.font = FONTMEDIUM(17.0f);
	lablename.textColor = [UIColor blackColor];
	lablename.backgroundColor = [UIColor clearColor];
	[self addSubview:lablename];
	
	UIImageView *imageusericon = [[UIImageView alloc] initWithFrame:CGRectMake(XYViewR(lablename)+5,XYViewTop(lablename)+5,25,10)];
    NSString *stricon = [dicbaseinfo objectForKey:@"companytypeicon"];
    [imageusericon setImageWithURL:[NSURL URLWithString:stricon]];
	[self addSubview:imageusericon];
	
    UIButton *buttonarrow = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonarrow.frame = CGRectMake(XYViewR(imageusericon)+10, XYViewTop(lablename)-5, 40, 30);
    buttonarrow.backgroundColor = [UIColor clearColor];
    [buttonarrow setImage:LOADIMAGE(@"tbeaarrowright", @"png") forState:UIControlStateNormal];
    [buttonarrow addTarget:self action:@selector(photoTappedAd:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:buttonarrow];
    
    UIImageView *imageusericonaddr = [[UIImageView alloc] initWithFrame:CGRectMake(XYViewL(lablename),XYViewBottom(lablename)+15,7,10)];
    imageusericonaddr.image = LOADIMAGE(@"melocationgray", @"png");
    [self addSubview:imageusericonaddr];
    
    UILabel *lableaddr = [[UILabel alloc] initWithFrame:CGRectMake(XYViewR(imageusericonaddr)+5, XYViewTop(imageusericonaddr)-5, 250, 20)];
    lableaddr.text = [dicbaseinfo objectForKey:@"address"];
    lableaddr.font = FONTN(13.0f);
    lableaddr.textColor = COLORNOW(117, 117, 117);
    lableaddr.backgroundColor = [UIColor clearColor];
    [self addSubview:lableaddr];
	
	UIImageView *imageuserheader = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-70,140-25,50,50)];
	imageuserheader.layer.cornerRadius =25;
	imageuserheader.clipsToBounds = YES;
    NSString *strpic = [dicbaseinfo objectForKey:@"companymasteruserthumbpicture"];
    [imageuserheader setImageWithURL:[NSURL URLWithString:strpic] placeholderImage:LOADIMAGE(@"testpic", @"png")];
	imageuserheader.userInteractionEnabled = YES;
	UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(photoTappedAd:)];
	[imageuserheader addGestureRecognizer:singleTap];
	[self addSubview:imageuserheader];
	
    UIImageView *imageline = [AddCustomView CusViewLine:CGRectMake(0, XYViewBottom(lableaddr)+10, SCREEN_WIDTH, 1) BGColor:COLORNOW(230, 230, 230)];
    [self addSubview:imageline];
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
    
}

-(void)clickcommitypage:(id)sender
{
    [self setviewbuttoncolor];
    UILabel *label2 = [self viewWithTag:EnNearByStoreHpControltag3];
    UILabel *label3 = [self viewWithTag:EnNearByStoreHpControltag4];
    label2.textColor = COLORNOW(0, 170, 238);
    label3.textColor = COLORNOW(0, 170, 238);
}

-(void)clickactivitypage:(id)sender
{
    [self setviewbuttoncolor];
    UILabel *label4 = [self viewWithTag:EnNearByStoreHpControltag5];
    UILabel *label5 = [self viewWithTag:EnNearByStoreHpControltag6];
    label4.textColor = COLORNOW(0, 170, 238);
    label5.textColor = COLORNOW(0, 170, 238);
}

-(void)photoTappedAd:(UIGestureRecognizer*)sender
{
	if([self.delegate1 respondsToSelector:@selector(DGCLickWaterPersonHeader:)])
	{
		[self.delegate1 DGCLickWaterPersonHeader:sender];
	}
}

-(void)gotomore:(id)sender
{
	
}

@end
