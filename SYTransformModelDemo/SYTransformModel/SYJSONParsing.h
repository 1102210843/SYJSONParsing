//
//  SYJSONParsing.h
//  SYTransformModelDemo
//
//  Created by 陈蜜 on 16/5/20.
//  Copyright © 2016年 sunyu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SYJSONParsing : NSObject

+ (id)jsonParsingWithData:(NSData *)data error:(NSError **)error;

+ (id)jsonParsingWithString:(NSString *)string error:(NSError **)error;

@end
