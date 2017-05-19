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

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self testBlock];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated{
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

NSString *string = @"abc";
int number = 1;

- (void)testBlock{
//    __block NSString *string = @"abc";        //没有block修饰的变量  block会在声明的时候捕捉它的值
     int number2 = 10;
    void(^blk)(NSString *) = ^(NSString *str){
//        number = 3;
//        number2 = 20;
        NSLog(@" print %@   number %d",string,number);
    };
    number2 = 30;
    string = @"xyz";
    number = 2;
    blk(string);
    NSLog(@" %d", number2);
}



@end
