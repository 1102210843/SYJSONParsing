//
//  SYOtherController.m
//  SYTransformModelDemo
//
//  Created by 陈蜜 on 16/5/20.
//  Copyright © 2016年 sunyu. All rights reserved.
//

#import "SYOtherController.h"
#import "SYJSONParsing.h"
#import "SYTestModel.h"

@interface SYOtherController ()

@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation SYOtherController


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    NSString *path = [[NSBundle mainBundle]pathForResource:@"testJson" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    
    //数据转换model
    SYTestModel *model = [[SYTestModel alloc]initModelTransformModelWithData:data];
    
    NSLog(@"%d", model.key1);
    
    NSLog(@"%@", model.key2);
    
    NSLog(@"%@", model.key3);
    
    for (SYKey3Model *key3Model in model.key3) {
        NSLog(@"%@", key3Model.aaa);
    }
    
    NSLog(@"%@", model.key4);
    
    NSLog(@"%@", model.key5);
    
    NSLog(@"%ld", model.key5.eee);
    
    NSLog(@"%@", model.key5.www);
    
    
}



@end
