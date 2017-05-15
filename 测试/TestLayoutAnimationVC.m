//
//  TestLayoutAnimationVC.m
//  LayoutDemo
//
//  Created by 郭晓倩 on 2017/5/15.
//  Copyright © 2017年 郭晓倩. All rights reserved.
//

#import "TestLayoutAnimationVC.h"

@interface TestLayoutAnimationVC ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *viewHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *viewWidthConstraint;
@property (weak, nonatomic) IBOutlet UIView *myView;

@end

@implementation TestLayoutAnimationVC

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.edgesForExtendedLayout = UIRectEdgeNone;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)startAnimation:(id)sender {
    self.viewWidthConstraint.constant = 200;
    [self.view layoutIfNeeded];
    
    self.viewHeightConstraint.constant = 200;
    [UIView animateWithDuration:3 animations:^{
//        [self.myView layoutIfNeeded];
        [self.view layoutIfNeeded];
    }];
}



@end
