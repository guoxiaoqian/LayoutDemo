//
//  MyView.m
//  LayoutDemo
//
//  Created by 郭晓倩 on 2017/5/14.
//  Copyright © 2017年 郭晓倩. All rights reserved.
//

#import "MyView.h"
#import "MyLayer.h"

@implementation MyView 

+(Class)layerClass{
    return [MyLayer class];
}

-(void)setNeedsUpdateConstraints{
    NSLog(@"%s",__FUNCTION__);
    [super setNeedsUpdateConstraints];
}

-(void)updateConstraintsIfNeeded{
    NSLog(@"%s",__FUNCTION__);
    [super updateConstraintsIfNeeded];
}

-(void)updateConstraints{
    NSLog(@"%s",__FUNCTION__);
    [super updateConstraints];
}

-(void)setNeedsLayout{
    NSLog(@"%s",__FUNCTION__);
    [super setNeedsLayout];
}

-(void)layoutIfNeeded{
    NSLog(@"%s",__FUNCTION__);
    [super layoutIfNeeded];
}

-(void)layoutSubviews{
    NSLog(@"%s",__FUNCTION__);
    [super layoutSubviews];
}

-(void)setNeedsDisplay{
    NSLog(@"%s",__FUNCTION__);
    [super setNeedsDisplay];
}

#pragma mark - CALayerDelegate

- (void)layoutSublayersOfLayer:(CALayer *)layer{
    NSLog(@"%s",__FUNCTION__);
    [super layoutSublayersOfLayer:layer];
}

-(void)displayLayer:(CALayer *)layer{
    NSLog(@"%s",__FUNCTION__);
    [super displayLayer:layer];
}

-(void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx{
    NSLog(@"%s",__FUNCTION__);
    [super drawLayer:layer inContext:ctx];
}

@end
