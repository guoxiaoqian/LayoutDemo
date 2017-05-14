//
//  MyView.m
//  LayoutDemo
//
//  Created by 郭晓倩 on 2017/5/14.
//  Copyright © 2017年 郭晓倩. All rights reserved.
//

#import "MyView.h"
#import "MyLayer.h"
#import "Masonry.h"

#define kUseAutoLayout  1

@interface MyView ()

@property (strong,nonatomic) UILabel* myLabel;

@end

@implementation MyView 

+(Class)layerClass{
    return [MyLayer class];
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        self.myLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
        self.myLabel.textAlignment = NSTextAlignmentCenter;
        self.myLabel.text = @"测试";
        [self addSubview:self.myLabel];
        
#if kUseAutoLayout
      [self.myLabel mas_makeConstraints:^(MASConstraintMaker *make) {
          make.center.equalTo(self);
      }];
#else
        self.myLabel.center = CGPointMake(frame.size.width/2, frame.size.height/2);
#endif
        
    }
    return self;
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

#pragma mark - CALayerDelegate

- (void)layoutSublayersOfLayer:(CALayer *)layer{
    NSLog(@"%s",__FUNCTION__);
    [super layoutSublayersOfLayer:layer];
}

@end
