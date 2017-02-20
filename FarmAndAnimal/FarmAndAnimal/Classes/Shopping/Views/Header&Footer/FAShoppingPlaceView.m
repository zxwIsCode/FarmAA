//
//  FAShoppingPlaceView.m
//  FarmAndAnimal
//
//  Created by 李保东 on 17/1/16.
//  Copyright © 2017年 DaviD. All rights reserved.
//

#import "FAShoppingPlaceView.h"


@interface FAShoppingPlaceView ()

@property(nonatomic,strong)UIImageView *placeImage;

@property(nonatomic,strong)UILabel *placeNameAndTeleLable;

@property(nonatomic,strong)UILabel *placeAddressLable;

@property(nonatomic,strong)UIImageView *nextAllPlace;

@property(nonatomic,strong)UIImageView *lineImageView;

@end

@implementation FAShoppingPlaceView

+(instancetype)PlaceView {
    return [[self alloc]init];
}

-(instancetype)initWithFrame:(CGRect)frame {
    if (self =[super initWithFrame:frame]) {
        
        CGFloat selfH = kShoppingPlaceViewHeight;
        
        self.placeImage =[[UIImageView alloc]init];
        self.placeNameAndTeleLable =[[UILabel alloc]init];
        self.placeAddressLable =[[UILabel alloc]init];
        self.nextAllPlace =[[UIImageView alloc]init];
        self.lineImageView =[[UIImageView alloc]init];
        
        CGFloat placeImageWH =30 *kAppScale;
        CGFloat nextAllPlaceWH =30 *kAppScale;
        CGFloat spacing =10 *kAppScale;
        CGFloat placeImageCenterY =selfH *0.5;
        
        CGFloat placeNameAndTeleLableX = spacing + placeImageWH +spacing;
        CGFloat placeNameAndTeleLableMaxX =SCREEN_WIDTH - ( spacing + placeImageWH +spacing);
        CGFloat placeNameAndTeleLableW = placeNameAndTeleLableMaxX -placeNameAndTeleLableX;
        
        self.placeImage.bounds =CGRectMake(0, 0, placeImageWH, placeImageWH);
        self.placeImage.center =CGPointMake(spacing + placeImageWH *0.5, placeImageCenterY);
        
        self.placeNameAndTeleLable.frame =CGRectMake(CGRectGetMaxX(self.placeImage.frame) +spacing, spacing, placeNameAndTeleLableW, 20 *kAppScale);
        self.placeAddressLable.frame =CGRectMake(CGRectGetMinX(self.placeNameAndTeleLable.frame), CGRectGetMaxY(self.placeNameAndTeleLable.frame) +spacing, placeNameAndTeleLableW, 44 *kAppScale);
        
        self.nextAllPlace.bounds =CGRectMake(0, 0, nextAllPlaceWH, nextAllPlaceWH);
        self.nextAllPlace.center =CGPointMake(CGRectGetMaxX(self.placeNameAndTeleLable.frame) +spacing + nextAllPlaceWH *0.5, placeImageCenterY);
        self.lineImageView.frame =CGRectMake(0, selfH -5 *kAppScale, SCREEN_WIDTH, 5 *kAppScale);
        
        self.placeNameAndTeleLable.text =@"动力无限      180778989";
        self.placeAddressLable.text =@"很难设计呢偶尔份额及丰富可 佛法及方法即可见附件二feffeeffkf";
        self.placeAddressLable.numberOfLines =0;
        
        self.placeImage.backgroundColor =[UIColor purpleColor];
        self.placeNameAndTeleLable.backgroundColor =[UIColor redColor];
        self.placeAddressLable.backgroundColor =[UIColor blueColor];
        self.nextAllPlace.backgroundColor =[UIColor orangeColor];
        self.lineImageView.backgroundColor =[UIColor redColor];
        
        [self addSubview:self.placeImage];
        [self addSubview:self.placeNameAndTeleLable];
        [self addSubview:self.placeAddressLable];
        [self addSubview:self.nextAllPlace];
        [self addSubview:self.lineImageView];
                
    }
    return self;
}

@end
