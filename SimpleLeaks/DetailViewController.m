//
//  DetailViewController.m
//  SimpleLeaks
//
//  Created by mac on 2017/3/3.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "DetailViewController.h"
#import "SHTimer.h"
#import "LeakTableView.h"

@interface DetailViewController ()
{
    NSTimer *timer;
}
@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    
    [self leakForTimer];
    
    [self addTableView];
}

-(void)viewDidAppear:(BOOL)animated{
    if (_delegate) {
//        [_delegate viewDidShow];
    }
}

#pragma Example One
/**
   常见的timer造成的泄露  timer强引用VC timer同时被runloop持有  在timer invalidate前self不会被释放，虽然没有循环引用  但没有释放的时机
   解决： 在适当时候invalidate timer  或者 使用一个中间对象(SHTimer)
 */
- (void)leakForTimer{
//    __block int num = 1;
//    timer = [NSTimer scheduledTimerWithTimeInterval:1.0f repeats:YES block:^(NSTimer * _Nonnull timer) {
//        NSLog(@" count %d ",num++);
//    }];
    
//    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    
    [SHTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(doSomething) userInfo:nil repeats:YES];
}

- (void)viewDidDisappear:(BOOL)animated{
    [timer invalidate];
    timer = nil;
}



#pragma Example Two

/**
   和timer类似，defaultCenter会对self持有 造成无法释放
   解决：使用weak引用
 */
- (void)leakForNotification{
    __weak DetailViewController *copySelf = self;
    [[NSNotificationCenter defaultCenter] addObserverForName:@"NotificationName" object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
        [copySelf doSomething];
    }];
}

- (void)doSomething{
    NSLog(@" received notification ");
}



#pragma subView

- (void)addTableView{
    LeakTableView *table = [[LeakTableView alloc] initWithFrame:CGRectMake(0, 0, 100, 100) style:UITableViewStylePlain];
    [self.view addSubview:table];
}

-(void)dealloc{
    NSLog(@" dealloc ");
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
