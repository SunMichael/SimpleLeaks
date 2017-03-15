//
//  LeakTableView.h
//  SimpleLeaks
//
//  Created by mac on 2017/3/15.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LeakTableView : UITableView <UITableViewDelegate ,UITableViewDataSource>

@end


@interface BlockModel : NSObject

@property(nonatomic ,copy) dispatch_block_t block;

@end
