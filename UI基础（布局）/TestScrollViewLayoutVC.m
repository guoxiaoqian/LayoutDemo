//
//  AutoLayoutVC.m
//  Demo
//
//  Created by 郭晓倩 on 2017/4/27.
//  Copyright © 2017年 郭晓倩. All rights reserved.
//

#import "TestScrollViewLayoutVC.h"

@interface TestScrollViewLayoutVC ()

@property (weak, nonatomic) IBOutlet UIView *scrollContentView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *scrollContentViewHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *scrollContentInnerViewHeightConstraint;

@end

@implementation TestScrollViewLayoutVC

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


- (IBAction)didClickChangeScrollContentInnerViewHeight:(id)sender {
    [self.scrollContentView removeConstraint:self.scrollContentViewHeightConstraint];
    
    if([self.scrollContentView hasAmbiguousLayout]){
        //少约束才会
        NSLog(@"scrollContentView hasAmbiguousLayout");
    }
    
    if (self.scrollContentInnerViewHeightConstraint.constant == 10) {
        self.scrollContentInnerViewHeightConstraint.constant = 600;
    }else{
        self.scrollContentInnerViewHeightConstraint.constant = 10;
    }
}

@end
