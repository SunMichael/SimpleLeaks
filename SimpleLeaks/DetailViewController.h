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

@end
