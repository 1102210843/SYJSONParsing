//
//  SYTudouListCell.m
//  SYTransformModelDemo
//
//  Created by 陈蜜 on 16/5/23.
//  Copyright © 2016年 sunyu. All rights reserved.
//

#import "SYTudouListCell.h"

@implementation SYTudouListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        //128*72
        _imageV = [[UIImageView alloc]initWithFrame:CGRectMake(10, 5, 90, 90)];
        
        [self.contentView addSubview:_imageV];
        
        _title = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_imageV.frame)+5, 5, 250, 20)];
        
        [self.contentView addSubview:_title];
        
        _deatil = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_imageV.frame)+5, CGRectGetMaxY(_title.frame)+5, 250, 70)];
        _deatil.numberOfLines = 0;
        [self.contentView addSubview:_deatil];
        
        
    }
    return self;
}

@end
