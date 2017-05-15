//
//  TestLayoutOrderVC.m
//  LayoutDemo
//
//  Created by 郭晓倩 on 2017/5/14.
//  Copyright © 2017年 郭晓倩. All rights reserved.
//

#import "TestLayoutOrderVC.h"
#import "MyView.h"
#import "Masonry.h"
#import <objc/runtime.h>

#define kUseAutoLayout  0

@interface TestLayoutOrderVC ()

@property (strong,nonatomic) MyView* myView;

@end

@implementation TestLayoutOrderVC

- (void)viewDidLoad {
    NSLog(@"%s",__FUNCTION__);

    [super viewDidLoad];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.myView = [[MyView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    self.myView.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.myView];
    
    //约束布局
#if kUseAutoLayout
    [self.myView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.top.equalTo(self.view);
        make.width.height.mas_equalTo(100);
    }];
#endif
}

-(void)viewWillAppear:(BOOL)animated{
    NSLog(@"%s",__FUNCTION__);
    [super viewWillAppear:animated];
}

-(void)viewDidAppear:(BOOL)animated{
    NSLog(@"%s",__FUNCTION__);
    [super viewDidAppear:animated];
}

-(void)viewWillLayoutSubviews{
    NSLog(@"%s",__FUNCTION__);
    [super viewWillLayoutSubviews];
}

-(void)viewDidLayoutSubviews{
    NSLog(@"%s",__FUNCTION__);
    [super viewDidLayoutSubviews];
}

-(void)updateViewConstraints{
    NSLog(@"%s",__FUNCTION__);
    [super updateViewConstraints];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)changeHeight:(id)sender{
#if kUseAutoLayout
    [self.myView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(self.myView.frame.size.height > 100 ? 100:200);
    }];
#else
    self.myView.frame = CGRectMake(0, 0, 100, self.myView.frame.size.height > 100 ? 100:200);
#endif
}


@end
