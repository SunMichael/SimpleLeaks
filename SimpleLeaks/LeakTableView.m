//
//  LeakTableView.m
//  SimpleLeaks
//
//  Created by mac on 2017/3/15.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "LeakTableView.h"

@interface LeakTableView ()

@property (nonatomic, copy) dispatch_block_t block;

@property (nonatomic ,strong) BlockModel *model;
@end

@implementation LeakTableView
{
    NSString *status;
}

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self = [super initWithFrame:frame style:style];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(received:) name:@"notic" object:nil];
        
        status = @"world";
        __weak LeakTableView *copySelf = self;
        //对于self持有的Block  不能引用全局变量 ，如果只是block里面引用全局变量  self不持有则没问题
        
        //1     //能dealloc
        void(^blockName)() = ^() {
            [self loadSomething:status];
        };
        
        //2     //不能dealloc
        self.block = ^(){
            [copySelf loadSomething:status];
        };
        
        //3     //不能dealloc
        BlockModel *ablock = [[BlockModel alloc] init];
        ablock.block = ^(){
            [copySelf loadSomething:status];
        };
        self.model = ablock;
        

        blockName();
        self.delegate = self;
        self.dataSource = self;
    }
    return self;
}
- (void)loadSomething:(NSString *)string{
    NSLog(@" print %@ ",string);
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *string = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:string];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:string];
    }
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 12;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
- (void)received:(NSNotification *)notic{
    NSLog(@" table received");
}

-(void)dealloc{
    NSLog(@" table dealloc ...");
}

@end




@implementation BlockModel



@end

