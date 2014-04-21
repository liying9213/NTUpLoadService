//
//  NTHomeViewController.h
//  NTUpLoadService
//
//  Created by liying on 14-4-18.
//  Copyright (c) 2014年 liying. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NTHomeViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableview;
@property (nonatomic, strong) NSMutableArray *resultData;
@property (nonatomic, strong) NSString *path;
@end
