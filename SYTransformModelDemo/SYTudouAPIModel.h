//
//  SYTudouAPIModel.h
//  SYTransformModelDemo
//
//  Created by 陈蜜 on 16/5/20.
//  Copyright © 2016年 sunyu. All rights reserved.
//

#import "SYBaseModel.h"

@interface SYTudouAPIModel : SYBaseModel

@property (nonatomic, strong) NSString *picUrl;

@property (nonatomic, strong) NSString *KWdescription;

@property (nonatomic, strong) NSString *html5Url;

@property (nonatomic, strong) NSString *title;

@property (nonatomic, assign) NSInteger totalTime;

@property (nonatomic, strong) NSArray * picChoiceUrl;

@property (nonatomic, strong) NSString *addPlaylistTime;

@property (nonatomic, strong) NSString *alias;

@property (nonatomic, strong) NSString *bigPicUrl;

@property (nonatomic, strong) NSString *outerPlayerUrl;

@property (nonatomic, strong) NSString *picUrl_16_9;

@end





