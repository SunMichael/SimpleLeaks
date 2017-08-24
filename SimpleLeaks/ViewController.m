//
//  ViewController.m
//  SimpleLeaks
//
//  Created by mac on 2017/3/3.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "ViewController.h"
#import "DetailViewController.h"

@interface ViewController () <DetailProtocol>

- (IBAction)clickedDetailBtn:(id)sender;

@end

@implementation ViewController

__weak NSString *string ;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    @autoreleasepool {
        NSString *one = [NSString stringWithFormat:@"AA"];
        string = one;
    }
    NSLog(@"string %@",string);
    
    //    UIKit的变量内存远大于NSFoudation变量， 只有字典初始化在内存上有较大区别
    
    for (NSInteger i = 0; i < 10000000; i++) {
        //        NSString *str = [NSString stringWithFormat:@"BB"];
        //        NSLog(@"str = %@",str);
        //        NSMutableArray *ary = [NSMutableArray arrayWithObject:@"a"];
        //        NSMutableArray *ary2 = [[NSMutableArray alloc] initWithObjects:@"a", nil];
        //        NSLog(@" ary = %@",ary2);
        
        //        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@"key",@"value", nil];    //加入了autorelease，不会立即释放 内存增加
        //        NSDictionary *dic = [[NSDictionary alloc] initWithObjectsAndKeys:@"key",@"value", nil];   //用完直接释放，内存不会暴增
        //        UIImageView *iv = [[UIImageView alloc] init];
        //        UILabel *iv2 = [UILabel new];
        @autoreleasepool {
            //            UIImageView *iv = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 1, 1)];
            
            //             NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@"key",@"value", nil];    //加入了autorelease，不会立即释放 内存增加   //加入到autorelease中，将释放提前
            //            NSMutableArray *ary = [NSMutableArray arrayWithObject:@"a"];
            //            NSMutableArray *ary2 = [[NSMutableArray alloc] initWithObjects:@"a", nil];
        }
    }
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSLog(@"string2 %@",string);
}


- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    NSLog(@"string3 %@",string);
    [[NSNotificationCenter defaultCenter] postNotificationName:@"notic" object:nil];
}

- (IBAction)clickedDetailBtn:(id)sender {
    DetailViewController *detailVc = [[DetailViewController alloc] init];
    detailVc.delegate = self;
    [self.navigationController pushViewController:detailVc animated:YES];
}

-(void)viewDidShow{
    NSLog(@" view did show ");
}

NSString *string2 = @"abc";
int number = 1;

- (void)testBlock{
//    __block NSString *string = @"abc";        //没有block修饰的变量  block会在声明的时候捕捉它的值
     int number2 = 10;
    void(^blk)(NSString *) = ^(NSString *str){
//        number = 3;
//        number2 = 20;
        NSLog(@" print %@   number %d",string2,number);
    };
    number2 = 30;
    string2 = @"xyz";
    number = 2;
    blk(string2);
    NSLog(@" %d", number2);
}



@end
