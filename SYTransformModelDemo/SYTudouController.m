//
//  SYTudouController.m
//  SYTransformModelDemo
//
//  Created by 陈蜜 on 16/5/23.
//  Copyright © 2016年 sunyu. All rights reserved.
//

#import "SYTudouController.h"
#import "SYJSONParsing.h"
#import "SYTudouAPIModel.h"
#import "UIImageView+WebCache.h"
#import "SYTudouListCell.h"
#import "SYTudouPalyerController.h"

//土豆APP火影剧集列表
#define tudouURL @"http://www.tudou.com/tvp/getMultiTvcCodeByAreaCode.action?type=3&app=4&codes=Lqfme5hSolM&areaCode=320500&jsoncallback=__TVP_getMultiTvcCodeByAreaCode"

//土豆开放平台API
#define tudouOpenURL @"http://api.tudou.com/v3/gw?method=album.item.get&appKey=myKey&format=json&albumId=Lqfme5hSolM&pageNo=5&pageSize=100"

@interface SYTudouController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray *list;

@end


@implementation SYTudouController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 375, 667) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    
    [tableView registerClass:[SYTudouListCell class] forCellReuseIdentifier:@"UITableViewCell"];
    
    [self.view addSubview:tableView];
    
    _list = [NSMutableArray array];
    
    [self getDataSourceBlock:^(id dataSource) {
        //土豆
        NSDictionary *multiResult = [dataSource objectForKey:@"multiResult"];
        NSArray *array = [multiResult objectForKey:@"results"];
        
        for (NSDictionary *dict in array) {
            
            //数据转换model
            SYTudouAPIModel *model = [[SYTudouAPIModel alloc]initModelTransformModelWithDict:dict];
            
            [_list addObject:model];
            
            NSLog(@"%ld", (long)model.totalTime);
        }
        
        [tableView reloadData];
    }];
}

- (void)getDataSourceBlock:(void(^)(id dataSource))block
{
    
    NSURL *url = [NSURL URLWithString:tudouOpenURL];
    
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            
            NSError *error = nil;
            //JSON解析
            id jsonData = [SYJSONParsing jsonParsingWithData:data error:&error];
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _list.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SYTudouListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
    
    SYTudouAPIModel *model = _list[indexPath.row];
    
    [cell.imageV sd_setImageWithURL:[NSURL URLWithString:model.picUrl]];
    cell.title.text = model.title;
    cell.deatil.text = model.KWdescription;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SYTudouAPIModel *model = _list[indexPath.row];
    SYTudouPalyerController *VC = [[SYTudouPalyerController alloc]init];
    VC.url = model.html5Url;
    [self.navigationController pushViewController:VC animated:YES];
}



@end
