//
//  SYTudouPalyerController.m
//  SYTransformModelDemo
//
//  Created by 陈蜜 on 16/5/23.
//  Copyright © 2016年 sunyu. All rights reserved.
//

#import "SYTudouPalyerController.h"

@interface SYTudouPalyerController () <UIWebViewDelegate>

@end

@implementation SYTudouPalyerController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIWebView *webView = [[UIWebView alloc]initWithFrame:self.view.bounds];
    webView.delegate = self;
    [self.view addSubview:webView];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.url]];
    
    [webView loadRequest:request];
    
}


@end
