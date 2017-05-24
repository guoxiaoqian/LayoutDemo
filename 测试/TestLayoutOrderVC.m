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

#define kUseAutoLayout  1

@interface TestLayoutOrderVC ()

@property (strong,nonatomic) MyView* myView;
@property CFRunLoopObserverRef observerForMainRunloop;

@end

@implementation TestLayoutOrderVC

- (void)viewDidLoad {
    NSLog(@"%s",__FUNCTION__);
    
    self.observerForMainRunloop = [self addObserver:[NSRunLoop mainRunLoop]];

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

-(void)dealloc{
    [self removeObserver:[NSRunLoop mainRunLoop] observer:self.observerForMainRunloop];
}

-(IBAction)changeHeight:(id)sender{
//#if kUseAutoLayout
//    [self.myView mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.height.mas_equalTo(self.myView.frame.size.height > 100 ? 100:200);
//    }];
//#else
    self.myView.frame = CGRectMake(0, 0, 100, self.myView.frame.size.height > 100 ? 100:200);
    [self.view setNeedsLayout];
//#endif
}

-(CFRunLoopObserverRef)addObserver:(NSRunLoop*)runloop{
    //1.创建监听者
    /*
     第一个参数:怎么分配存储空间
     第二个参数:要监听的状态 kCFRunLoopAllActivities 所有的状态
     第三个参数:时候持续监听
     第四个参数:优先级 总是传0
     第五个参数:当状态改变时候的回调
     */
    CFRunLoopObserverRef observer = CFRunLoopObserverCreateWithHandler(CFAllocatorGetDefault(), kCFRunLoopAllActivities, YES, 0, ^(CFRunLoopObserverRef observer, CFRunLoopActivity activity) {
        
        NSString* statusStr = nil;
        switch (activity) {
            case kCFRunLoopEntry:
                statusStr = @"即将进入runloop";
                break;
            case kCFRunLoopBeforeTimers:
                statusStr = @"即将处理timer事件";
                break;
            case kCFRunLoopBeforeSources:
                statusStr = @"即将处理source事件";
                break;
            case kCFRunLoopBeforeWaiting:
                statusStr = @"即将进入睡眠";
                break;
            case kCFRunLoopAfterWaiting:
                statusStr = @"被唤醒";
                break;
            case kCFRunLoopExit:
                statusStr = @"runloop退出";
                break;
                
            default:
                break;
        }
        
        NSLog(@"%@%@",[NSThread currentThread].name,statusStr);
    });
    
    /*
     第一个参数:要监听哪个runloop
     第二个参数:观察者
     第三个参数:运行模式
     */
    CFRunLoopAddObserver([runloop getCFRunLoop],observer, kCFRunLoopDefaultMode);
    return observer;
}

-(void)removeObserver:(NSRunLoop*)runloop observer:(CFRunLoopObserverRef)observer{
    CFRunLoopRemoveObserver([runloop getCFRunLoop], observer, kCFRunLoopDefaultMode);
    CFRelease(observer);
}


@end
