//
//  DetailViewController.h
//  SimpleLeaks
//
//  Created by mac on 2017/3/3.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DetailProtocol <NSObject>

- (void)viewDidShow;

@end


@interface DetailViewController : UIViewController

@property (nonatomic, strong) id <DetailProtocol> delegate;

@property (nonatomic ,strong) void(^testBlock)(NSInteger index);

@end



/*

 assign其实也可以用来修饰对象。那么我们为什么不用它修饰对象呢？因为被assign修饰的对象（一般编译的时候会产生警告：Assigning retained object to unsafe property; object will be released after assignment）在释放之后，指针的地址还是存在的，也就是说指针并没有被置为nil，造成野指针。对象一般分配在堆上的某块内存，如果在后续的内存分配中，刚好分到了这块地址，程序就会崩溃掉。
 
 那为什么可以用assign修饰基本数据类型？因为基础数据类型一般分配在栈上，栈的内存会由系统自己自动处理，不会造成野指针。
 

*/
