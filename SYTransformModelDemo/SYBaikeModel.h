//
//  SYBaikeModel.h
//  SYTransformModelDemo
//
//  Created by 陈蜜 on 16/5/23.
//  Copyright © 2016年 sunyu. All rights reserved.
//

#import "SYBaseModel.h"

@class SYCardModel;

@protocol SYCardModel <NSObject>
@end


@interface SYBaikeModel : SYBaseModel

@property (nonatomic, strong) NSString *abstract;

@property (nonatomic, strong) NSNumber *KWid;

@property (nonatomic, strong) NSArray<SYCardModel>*card;

@property (nonatomic, strong) NSArray *catalog;

@property (nonatomic, strong) NSString *copyrights;


@end

@interface SYCardModel : SYBaseModel

@property (nonatomic, strong) NSString *key;

@property (nonatomic, strong) NSString *name;

@end
