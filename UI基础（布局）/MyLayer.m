//
//  MyLayer.m
//  LayoutDemo
//
//  Created by 郭晓倩 on 2017/5/14.
//  Copyright © 2017年 郭晓倩. All rights reserved.
//

#import "MyLayer.h"

@implementation MyLayer

-(void)setNeedsLayout{
    NSLog(@"%s",__FUNCTION__);
    [super setNeedsLayout];
}

-(void)layoutIfNeeded{
    NSLog(@"%s",__FUNCTION__);
    [super layoutIfNeeded];
}

-(void)layoutSublayers{
    NSLog(@"%s",__FUNCTION__);
    [super layoutSublayers];
}

@end
