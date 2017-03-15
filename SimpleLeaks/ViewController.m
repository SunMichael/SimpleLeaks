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

@end
