//
//  SYAiqiyiController.m
//  SYTransformModelDemo
//
//  Created by 陈蜜 on 16/5/23.
//  Copyright © 2016年 sunyu. All rights reserved.
//

#import "SYAiqiyiController.h"
#import "SYAiqiyiModel.h"
#import "SYJSONParsing.h"

//爱奇艺海贼王剧集列表
#define aiqiyiURL @"http://cache.video.iqiyi.com/jp/avlist/202861101/1/?callback=jsonp9"

@implementation SYAiqiyiController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self getDataSourceBlock:^(id dataSource) {
        
        //爱奇艺  数据转换model
        SYAiqiyiModel *model = [[SYAiqiyiModel alloc]initModelTransformModelWithDict:[dataSource objectForKey:@"data"]];

        NSLog(@"%@", model);
        
        NSLog(@"%@", model.vlist);
        
        for (SYListModel *listModel in model.vlist) {
            NSLog(@"%@", listModel.vurl);
        }
    }];
}

- (void)getDataSourceBlock:(void(^)(id dataSource))block
{
    
    NSURL *url = [NSURL URLWithString:aiqiyiURL];
    
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            
            NSError *error = nil;
            
            //爱奇艺
            NSString *str1 = @"try{jsonp9(";
            NSString *str2 = @");}catch(e){};";
            NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
            str = [str stringByReplacingOccurrencesOfString:str1 withString:@""];
            str = [str stringByReplacingOccurrencesOfString:str2 withString:@""];
            NSData *data1 = [str dataUsingEncoding:NSUTF8StringEncoding];
            
            //JSON解析
            id jsonData = [SYJSONParsing jsonParsingWithData:data1 error:&error];
            if (error) {
                NSLog(@"%@", error);
            }else {
                if (block) {
                    block(jsonData);
                }
            }
        });
    }];
    //开始请求
    [task resume];
    
}

@end
