//
//  SYBaseModel.m
//  SYTransformModelDemo
//
//  Created by 陈蜜 on 16/5/20.
//  Copyright © 2016年 sunyu. All rights reserved.
//

#import "SYBaseModel.h"
#import <objc/runtime.h>
#import "SYModelDescription.h"
#import "SYJSONParsing.h"

static const char *kDescription;
static const char *kIndexPropertyNameKey;

@implementation SYBaseModel

- (instancetype)initModelTransformModelWithDict:(NSDictionary *)dict
{
    if (!dict){
        return nil;
    }
    
    self = [self init];
    
    [self objectWithDict:dict];
    
    return self;
}

- (instancetype)initModelTransformModelWithData:(NSData *)data
{
    if (!data) {
        return nil;
    }
    NSError *error = nil;
    NSDictionary *json = [SYJSONParsing jsonParsingWithData:data error:&error];
    if (error) {
        return nil;
    }
    self = [self initModelTransformModelWithDict:json];
    return self;
}

- (instancetype)init
{
    if (self = [super init]) {
        
        [self __setup];
        
    }
    return self;
}


- (NSArray *)__setup
{
    NSDictionary *dict = objc_getAssociatedObject(self.class, &kDescription);
    if (!dict) {
        [self __checkProperties];
    }else{
        return [dict allValues];
    }
    dict = objc_getAssociatedObject(self.class, &kDescription);
    return [dict allValues];
}

- (void)__checkProperties
{
    NSMutableDictionary *modelDescription = [NSMutableDictionary dictionary];
    
    Class class = [self class];
    
    NSScanner *scanner = nil;
    NSString *propertyType = nil;
    
    while (class != [SYBaseModel class]) {
        
        unsigned int count = 0;
        objc_property_t *properties = class_copyPropertyList(class, &count);
        
        for (int i = 0; i < count; i++) {
            
            SYModelDescription *des = [[SYModelDescription alloc]init];
            
            objc_property_t property = properties[i];
            const char *propertyName = property_getName(property);
            des.name = @(propertyName);
            
            const char *attrs = property_getAttributes(property);
            NSString* propertyAttributes = @(attrs);
            NSArray* attributeItems = [propertyAttributes componentsSeparatedByString:@","];
            
            if ([attributeItems containsObject:@"R"]) {
                continue;
            }
            
            scanner = [NSScanner scannerWithString: propertyAttributes];
            [scanner scanUpToString:@"T" intoString: nil];
            [scanner scanString:@"T" intoString:nil];
            
            if ([scanner scanString:@"@\"" intoString: &propertyType]) {
                
                [scanner scanUpToCharactersFromSet:[NSCharacterSet characterSetWithCharactersInString:@"\"<"]
                                        intoString:&propertyType];
                
                des.type = NSClassFromString(propertyType);
                des.isMutable = ([propertyType rangeOfString:@"Mutable"].location != NSNotFound);
                
                
                while ([scanner scanString:@"<" intoString:NULL]) {
                    
                    NSString* protocolName = nil;
                    
                    [scanner scanUpToString:@">" intoString: &protocolName];
                    
                    if ([protocolName isEqualToString:@"Optional"]) {
                        des.isOptional = YES;
                    } else if([protocolName isEqualToString:@"Index"]) {
                        des.isIndex = YES;
                        objc_setAssociatedObject(
                                                 self.class,
                                                 &kIndexPropertyNameKey,
                                                 des.name,
                                                 OBJC_ASSOCIATION_RETAIN
                                                 );
                    } else if([protocolName isEqualToString:@"Ignore"]) {
                        des = nil;
                    } else {
                        des.genericType = protocolName;
                    }
                    
                    [scanner scanString:@">" intoString:NULL];
                }
            }
            
            NSString *nsPropertyName = @(propertyName);
            if([[self class] propertyIsOptional:nsPropertyName]){
                des.isOptional = YES;
            }
            
            if([[self class] propertyIsIgnored:nsPropertyName]){
               des = nil;
            }
            
            NSString* customProtocol = [[self class]protocolForArrayProperty:nsPropertyName];
            if (customProtocol) {
                des.genericType = customProtocol;
            }
            if ([propertyType isEqualToString:@"Block"]) {
                des = nil;
            }
            if (des && ![modelDescription objectForKey:des.name]) {
                [modelDescription setValue:des forKey:des.name];
            }
        }
        class = [class superclass];
    }
    objc_setAssociatedObject(
                             self.class,
                             &kDescription,
                             [modelDescription copy],
                             OBJC_ASSOCIATION_RETAIN
                             );
    
}

+(BOOL)propertyIsOptional:(NSString*)propertyName
{
    return NO;
}

+(BOOL)propertyIsIgnored:(NSString *)propertyName
{
    return NO;
}

+(NSString*)protocolForArrayProperty:(NSString *)propertyName
{
    return nil;
}


- (void)objectWithDict:(NSDictionary *)dict
{
    for (SYModelDescription *modelDescription in [self __setup]) {
        
        id value = [dict objectForKey:modelDescription.name];
        
        if ([modelDescription.name hasPrefix:@"KW"]) {
            value = [dict objectForKey:[modelDescription.name substringFromIndex:2]];
        }
        
        if (modelDescription.type && (NSNull *)modelDescription.type != [NSNull null]) {
            NSBundle *mainB = [NSBundle bundleForClass:modelDescription.type];
            if (mainB == [NSBundle mainBundle]) {
                value = [[modelDescription.type alloc] initModelTransformModelWithDict:value];
            }
        }
        
        if ([modelDescription.type isSubclassOfClass:[NSArray class]]) {
            
            if (modelDescription.genericType != nil) {
                NSMutableArray *arr = [NSMutableArray array];
                for (NSDictionary *dict in value) {
                    Class attributeClass = NSClassFromString(modelDescription.genericType);
                    id subValue = [[attributeClass alloc]initModelTransformModelWithDict:dict];
                    [arr addObject:subValue];
                }
                value = arr;
            }
        }
        
        if (value && (NSNull *)value != [NSNull null]) {
            
            if ([modelDescription.type isSubclassOfClass:[NSString class]]) {
                [self setValue:[NSString stringWithFormat:@"%@", value] forKey:modelDescription.name];

            }else if ([modelDescription.type isSubclassOfClass:[NSNumber class]] ||
                      !modelDescription.type){
                [self setValue:[NSNumber numberWithInteger:[value integerValue]] forKey:modelDescription.name];
            }else{
                [self setValue:value forKey:modelDescription.name];
            }
            
        }else{
            
        }
    }
}


@end
