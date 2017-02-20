//
//  FAShoppingMinHeaderView.m
//  FarmAndAnimal
//
//  Created by 李保东 on 17/1/16.
//  Copyright © 2017年 DaviD. All rights reserved.
//

#import "FAShoppingMinHeaderView.h"

#import "FALRButton.h"


@interface FAShoppingMinHeaderView ()


@property(nonatomic,strong)UIButton *selectedBtn;

@property(nonatomic,strong)FALRButton *titleBtn;


@end

@implementation FAShoppingMinHeaderView
+(instancetype)updateWithHeaderTableView:(UITableView *)tableView {
    static NSString *ID = @"FAShoppingMinHeaderViewId";
    FAShoppingMinHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:ID];
    if (!headerView) {
        headerView = [[FAShoppingMinHeaderView alloc] initWithReuseIdentifier:ID];
    }
    return headerView;
}
-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    if (self =[super initWithReuseIdentifier:reuseIdentifier]) {
        self.placeView =[FAShoppingPlaceView PlaceView];
        self.titleBtn =[FALRButton leftRightButton];
        
        CGFloat selfH =kShoppingMinHeaderViewHeight;
//        CGFloat cellItemSpacing =5 *kAppScale;

        self.placeView.frame =CGRectMake(0, 0, SCREEN_WIDTH, kShoppingPlaceViewHeight);
        self.titleBtn.frame =CGRectMake(0, CGRectGetMaxY(self.placeView.frame), 180 , selfH -100 *kAppScale);
        
        self.placeView.backgroundColor =[UIColor yellowColor];
        self.titleBtn.backgroundColor =[UIColor blueColor];
        
        [self.contentView addSubview:self.placeView];
        [self.contentView addSubview:self.titleBtn];
        
        // 添加手势
        UITapGestureRecognizer *tapGesture =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(comeInPlaceVC:)];
        [self.placeView addGestureRecognizer:tapGesture];
        
    }
    return self;
}
-(void)comeInPlaceVC:(UITapGestureRecognizer *)gesture {
    if (self.clickPlaceBlock) {
        self.clickPlaceBlock(0);
    }
}

-(void)setSectionModel:(FAShoppingSectionModel *)sectionModel {
    _sectionModel =sectionModel;

    
    [self.titleBtn setTitle:sectionModel.seller forState:UIControlStateNormal];
}

-(void)setAddressModel:(FAAddressModel *)addressModel {
    
    _addressModel =addressModel;
}


@end
