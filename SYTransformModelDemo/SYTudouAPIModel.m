//
//  SYTudouAPIModel.m
//  SYTransformModelDemo
//
//  Created by 陈蜜 on 16/5/20.
//  Copyright © 2016年 sunyu. All rights reserved.
//

#import "SYTudouAPIModel.h"

@implementation SYTudouAPIModel

- (instancetype)initModelTransformModelWithDict:(NSDictionary *)dict
{
    if (self = [super initModelTransformModelWithDict:dict]) {
        
        //类型转换
        //如果属性设置为 int，NSInteger，CGFloat，BOOL等类型时，需在.m文件中重写初始化方法，对属性进行手动转换
        self.totalTime = [[dict objectForKey:@"totalTime"]integerValue];
        
    }
    return self;
}

@end
