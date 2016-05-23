//
//  SYBaikeController.m
//  SYTransformModelDemo
//
//  Created by 陈蜜 on 16/5/23.
//  Copyright © 2016年 sunyu. All rights reserved.
//

#import "SYBaikeController.h"
#import "SYBaikeModel.h"

//百度百科
#define BaikeURL @"http://baike.baidu.com/api/openapi/BaikeLemmaCardApi?scope=103&format=json&appid=379020&bk_key=%E9%93%B6%E9%AD%82&bk_length=600"

@implementation SYBaikeController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self getDataSourceBlock:^(id dataSource) {
        
        //百科 数据转换model
        SYBaikeModel *model = [[SYBaikeModel alloc]initModelTransformModelWithData:dataSource];
        
        NSLog(@"%@", model);
        
        NSLog(@"%@", model.KWid);
        
        NSLog(@"%@", model.abstract);
        
        NSLog(@"%@", model.catalog);
        
        NSLog(@"%@", model.card);
        
        for (SYCardModel *cardModel in model.card) {
            NSLog(@"%@", cardModel.name);
        }

    }];
}

- (void)getDataSourceBlock:(void(^)(id dataSource))block
{
    
    NSURL *url = [NSURL URLWithString:BaikeURL];
    
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            
            NSError *error = nil;
            if (error) {
                NSLog(@"%@", error);
            }else {
                if (block) {
                    block(data);
                }
            }
        });
    }];
    //开始请求
    [task resume];
    
}

@end
