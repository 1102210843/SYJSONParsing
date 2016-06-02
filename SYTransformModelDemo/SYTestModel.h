//
//  SYTestModel.h
//  SYTransformModelDemo
//
//  Created by 陈蜜 on 16/5/23.
//  Copyright © 2016年 sunyu. All rights reserved.
//

#import "SYBaseModel.h"

@class SYKey5Model;
@class SYKey3Model;

@protocol SYKey3Model <NSObject>
@end


@interface SYTestModel : SYBaseModel

@property (nonatomic, assign) BOOL key1;

@property (nonatomic, strong) NSString *key2;

@property (nonatomic, strong) NSArray <SYKey3Model>*key3;

@property (nonatomic, strong) NSArray *key4;

@property (nonatomic, strong) SYKey5Model *key5;

@end


@interface SYKey3Model : SYBaseModel

@property (nonatomic, strong) NSString *aaa;

@property (nonatomic, strong) NSString *sss;

@end



@interface SYKey5Model : SYBaseModel

@property (nonatomic,  assign) NSInteger eee;

@property (nonatomic, strong) NSString *www;

@end