//
//  ESLiveProductHeadCell.h
//  example
//
//  Created by d2c_cyf on 17/1/4.
//  Copyright © 2017年 d2c_cyf. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ESLiveProductHeadCell : UICollectionViewCell
/**
 获取cell的Size

 @return size
 */
+ (CGSize)getBrandSize;

/**
 设置cell的内容

 @param model 数据
 */
- (void)setLiveProductHeadWithModel:(id)model;
@end


#pragma mark - 领券与活动
//////////  领券与活动  /////////
@interface ESLiveCouponAndCrowdCell : UICollectionViewCell

/**
 设置cell内容

 @param Model 数据
 */
- (void)setCouponAndCrowdWithModel:(id)Model;

/**
 获取cell高度

 @param model 数据
 @return cell高度
 */
+ (CGFloat)getCellHeightWithModel:(id)model;
@end
