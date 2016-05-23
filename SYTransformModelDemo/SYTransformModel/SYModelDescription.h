//
//  SYModelDescription.h
//  SYTransformModelDemo
//
//  Created by 陈蜜 on 16/5/20.
//  Copyright © 2016年 sunyu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SYModelDescription : NSObject

/** 属性名 */
@property (nonatomic, strong) NSString *name;

/** 类型 */
@property (nonatomic, assign) Class type;

/** 如果是数组，则可能有泛类型名 */
@property (nonatomic, strong) NSString *genericType;

@property (assign, nonatomic) BOOL isOptional;

@property (assign, nonatomic) BOOL isIndex;

/** 标记类型是否可变 */
@property (nonatomic, assign) BOOL isMutable;



@end
