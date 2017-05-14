//
//  AutoLayoutVC.m
//  Demo
//
//  Created by 郭晓倩 on 2017/4/27.
//  Copyright © 2017年 郭晓倩. All rights reserved.
//

#import "TestConstraintConflictVC.h"

@interface TestConstraintConflictVC ()
@property (weak, nonatomic) IBOutlet UIView *outerView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *innerViewHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *outerViewHeightConstraint;


@end

@implementation TestConstraintConflictVC

- (void)viewDidLoad {
    [super viewDidLoad];

    self.edgesForExtendedLayout = UIRectEdgeNone;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
}

- (IBAction)didClickChangeInnerViewHeight:(id)sender {
//    [self.outerView removeConstraint:self.outerViewHeightConstraint];

    if (self.innerViewHeightConstraint.constant == 10) {
        self.innerViewHeightConstraint.constant = 100;
    }else{
        self.innerViewHeightConstraint.constant = 10;
    }
    
    //约束修改时，触发冲突检查，不会进行真正的布局;除了强制布局layoutIfNeeded,其余则Runloop周期末尾布局
    self.outerViewHeightConstraint.constant = self.innerViewHeightConstraint.constant + 2*10;
}

@end
