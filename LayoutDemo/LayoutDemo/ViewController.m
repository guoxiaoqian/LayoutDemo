//
//  ViewController.m
//  LayoutDemo
//
//  Created by 郭晓倩 on 2017/5/15.
//  Copyright © 2017年 郭晓倩. All rights reserved.
//

#import "ViewController.h"
#import "TestLayoutOrderVC.h"
#import "TestConstraintConflictVC.h"
#import "TestScrollViewLayoutVC.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)testLayoutOrder:(id)sender{
    [self.navigationController pushViewController:[TestLayoutOrderVC new] animated:YES];
}

-(IBAction)testConstraintConflict:(id)sender{
    [self.navigationController pushViewController:[TestConstraintConflictVC new] animated:YES];
}

-(IBAction)testScrollViewLayout:(id)sender{
    [self.navigationController pushViewController:[TestScrollViewLayoutVC new] animated:YES];
}


@end
