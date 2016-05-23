//
//  SYAiqiyiModel.h
//  SYTransformModelDemo
//
//  Created by 陈蜜 on 16/5/23.
//  Copyright © 2016年 sunyu. All rights reserved.
//

#import "SYBaseModel.h"


@class SYListModel;
@class SYPlcDown;

@protocol SYListModel <NSObject>

@end


@interface SYAiqiyiModel : SYBaseModel

@property (nonatomic, strong) NSNumber *aid;

@property (nonatomic, strong) NSArray<SYListModel> *vlist;

@end

@interface SYListModel : SYBaseModel

@property (nonatomic, strong) NSNumber *publishTime;

@property (nonatomic, strong) NSString *shortTitle;

@property (nonatomic, strong) NSString *vt;

@property (nonatomic, strong) NSString *vpic;

@property (nonatomic, strong) NSString *vurl;

@property (nonatomic, strong) SYPlcDown *plcdown;

@end

@interface SYPlcDown : SYBaseModel

@end
