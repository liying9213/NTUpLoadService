//
//  NTHttpServiceViewController.h
//  NTUpLoadService
//
//  Created by liying on 14-4-18.
//  Copyright (c) 2014年 liying. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyHTTPConnection.h"
#import "NTGetAddress.h"
#import "DDLog.h"
#import "DDTTYLogger.h"
#import "HTTPServer.h"

@interface NTHttpServiceViewController : UIViewController
@property (nonatomic, retain) HTTPServer *httpServer;
@property (nonatomic, strong) UIButton *wifi;
@property (nonatomic, strong) UILabel *warntext;
@property (nonatomic, strong) UILabel *urltext;
@end
