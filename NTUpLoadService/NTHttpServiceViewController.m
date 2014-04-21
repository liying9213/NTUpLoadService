//
//  NTHttpServiceViewController.m
//  NTUpLoadService
//
//  Created by liying on 14-4-18.
//  Copyright (c) 2014年 liying. All rights reserved.
//
#define PORT 9527
#import "NTHttpServiceViewController.h"

@interface NTHttpServiceViewController ()

@end

@implementation NTHttpServiceViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    self.view.backgroundColor=[UIColor whiteColor];
    [super viewDidLoad];
    [self resectView];
    [self startServer];
    // Do any additional setup after loading the view.
}
-(void)resectView
{
    UIButton *stop =[UIButton buttonWithType:UIButtonTypeCustom];
    stop.frame=CGRectMake(120, self.view.bounds.size.height/2+140, 80, 80);
    [stop setImage:[UIImage imageNamed:@"close_wifi.png"] forState:UIControlStateNormal];
    [stop addTarget:self action:@selector(stopServer) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:stop];
    
    _wifi =[UIButton buttonWithType:UIButtonTypeCustom];
    _wifi.frame=CGRectMake(80, self.view.bounds.size.height/2-160, 160, 160);
    [_wifi setImage:[UIImage imageNamed:@"wifi_close.png"] forState:UIControlStateNormal];
    [_wifi setImage:[UIImage imageNamed:@"wifi.png"] forState:UIControlStateHighlighted];
    [_wifi setUserInteractionEnabled:NO];

    _warntext = [[UILabel alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height/2+30, self.view.frame.size.width, 20)];
    [_warntext setTextAlignment:NSTextAlignmentCenter];
    [_warntext setTextColor:[UIColor colorWithRed:102/255.f green:102/255.f blue:102/255.f alpha:1]];
    
    _urltext = [[UILabel alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height/2+60, self.view.frame.size.width, 20)];
    [_urltext setTextAlignment:NSTextAlignmentCenter];
    
    [self.view addSubview:_wifi];
    [self.view addSubview:_warntext];
    [self.view addSubview:_urltext];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - ServiceAction -

-(void) startServer
{
    [_wifi setHighlighted:YES];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    NSString *ip = [NTGetAddress localWiFiIPAddress];
    
    if(ip == NULL){
        _warntext.text =@"请将手机连接到WIFI网络!";
        _urltext.text = @"";
        [_wifi setHighlighted:NO];
        return;
    }
    
    [DDLog addLogger:[DDTTYLogger sharedInstance]];
	
    _httpServer = [[HTTPServer alloc] init];
    
	[_httpServer setType:@"_http._tcp."];
	[_httpServer setPort:PORT];
    
	[_httpServer setDocumentRoot:documentsDirectory];
    [_httpServer setConnectionClass:[MyHTTPConnection class]];
	
	NSError *error = nil;
	if(![_httpServer start:&error])
	{
        _warntext.text =@"文件服务器启动失败!";
        [_wifi setHighlighted:NO];
	}else{
        _warntext.text =@"通过电脑浏览器访问以下地址上传文件";
        _urltext.text = [NSString stringWithFormat:@"http://%@:%d",ip,PORT];
    }
}

-(void)stopServer
{
    [_httpServer stop:NO];
    [_wifi setHighlighted:NO];
    [self dismissViewControllerAnimated:YES completion:nil];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
