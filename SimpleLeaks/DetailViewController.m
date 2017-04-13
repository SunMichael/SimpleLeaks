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
#import "KVOModel.h"

@interface DetailViewController ()
{
    NSTimer *timer;
    
}
@property (nonatomic ,strong) KVOModel *modelKVO;
@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    
    [self leakForTimer];
    
    [self addTableView];
    
    [self leakForKVO];
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
    
    
    //这种  在block 中对self 持有 也不能释放 改成weak可以释放 主要看是否对self一直持有 好像对self的属性持有没问题？
    __block int num = 1;
    __weak DetailViewController *copySelf = self;
    timer = [NSTimer scheduledTimerWithTimeInterval:1.0f repeats:YES block:^(NSTimer * _Nonnull timer) {
        NSLog(@" count %d ",num++);
        [copySelf doSomething];

        _modelKVO.name = @"124";
    }];
    
    
    //这种会导致self不能被释放
//    timer = [NSTimer timerWithTimeInterval:1.f target:self selector:@selector(doSomething) userInfo:nil repeats:YES];
    
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    
    //中间对象  不会泄露
//    [SHTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(doSomething) userInfo:nil repeats:YES];
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
//    __weak DetailViewController *copySelf = self;
//    [[NSNotificationCenter defaultCenter] addObserverForName:@"NotificationName" object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
//        [copySelf doSomething];
//    }];
    
    //这种好像不会泄露？
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(doSomething) name:@"NotificationName" object:nil];
}

- (void)doSomething{
    NSLog(@" received notification ");
}



/**
 KVO造成的泄露 ,好像并不会持有self 需要注意移除observe
 */
- (void)leakForKVO{
    _modelKVO = [[KVOModel alloc] init];
    [_modelKVO addObserver:self forKeyPath:@"value" options:NSKeyValueObservingOptionNew context:nil];
    _modelKVO.value = @"string";
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    NSLog(@" change %@", change);
    self.view.backgroundColor = [UIColor redColor];
    [self doSomething];
    _modelKVO.name = @"123";

}

#pragma subView

- (void)addTableView{
    LeakTableView *table = [[LeakTableView alloc] initWithFrame:CGRectMake(0, 0, 100, 100) style:UITableViewStylePlain];
    [self.view addSubview:table];
}

-(void)dealloc{
    NSLog(@" dealloc ");
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    [_modelKVO removeObserver:self forKeyPath:@"value"];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
