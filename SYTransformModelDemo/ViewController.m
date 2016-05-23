//
//  ViewController.m
//  SYTransformModelDemo
//
//  Created by 陈蜜 on 16/5/20.
//  Copyright © 2016年 sunyu. All rights reserved.
//

#import "ViewController.h"
#import "SYOtherController.h"
#import "SYBaikeController.h"
#import "SYAiqiyiController.h"
#import "SYTudouController.h"

#define list @[@"test",@"百科",@"爱奇艺",@"土豆"]

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 375, 667) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    
    [self.view addSubview:tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return list.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
    
    cell.textLabel.text = list[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIViewController *VC = nil;
    
    switch (indexPath.row) {
        case 0:
            VC = [[SYOtherController alloc]init];
            break;
        case 1:
            VC = [[SYBaikeController alloc]init];
            break;
        case 2:
            VC = [[SYAiqiyiController alloc]init];
            break;
        case 3:
            VC = [[SYTudouController alloc]init];
            break;
    }
    [self.navigationController pushViewController:VC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
