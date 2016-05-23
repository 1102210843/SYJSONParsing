//
//  SYJSONParsing.m
//  SYTransformModelDemo
//
//  Created by 陈蜜 on 16/5/20.
//  Copyright © 2016年 sunyu. All rights reserved.
//

#import "SYJSONParsing.h"

@implementation SYJSONParsing

+ (id)jsonParsingWithData:(NSData *)data error:(NSError **)error
{
    id dataSource = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:error];
    return dataSource;
}

+ (id)jsonParsingWithString:(NSString *)string error:(NSError **)error
{
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    id dataSource = [self jsonParsingWithData:data error:error];
    return dataSource;
}


@end
