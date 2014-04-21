//
//  NTHomeViewController.m
//  NTUpLoadService
//
//  Created by liying on 14-4-18.
//  Copyright (c) 2014年 liying. All rights reserved.
//

#import "NTHomeViewController.h"
#import "NTHttpServiceViewController.h"
#import <MediaPlayer/MediaPlayer.h>

@interface NTHomeViewController ()

@end

@implementation NTHomeViewController

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
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    
    _tableview=[[UITableView alloc] initWithFrame:CGRectMake(0, 20, 320, self.view.frame.size.height-64)style:UITableViewStylePlain];
    _tableview.delegate=self;
    _tableview.dataSource=self;
    _tableview.rowHeight=60;
    [self.view addSubview:_tableview];
    
    
    UIButton* uploadButton = [UIButton buttonWithType:UIButtonTypeCustom];
    uploadButton.backgroundColor=[UIColor lightGrayColor];
    uploadButton.frame=CGRectMake(0,self.view.frame.size.height-44, 320, 44);
    [uploadButton setImage:[UIImage imageNamed:@"upload.png"] forState:UIControlStateNormal];
    [uploadButton addTarget:self action:@selector(startUpload:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:uploadButton];
    
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated
{
    [self getData];
    [_tableview reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
-(void)getData
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    _path=documentsDirectory;
    NSFileManager * fileManager = [NSFileManager defaultManager];
     NSArray  * arr = [fileManager contentsOfDirectoryAtPath:documentsDirectory error:nil];
    _resultData=[[NSMutableArray alloc] initWithArray:arr];
}

#pragma mark - tabelVIewDelegate -
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _resultData.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * _cellIdentify = @"CellIdentify";
    UITableViewCell * _cell = [tableView  dequeueReusableCellWithIdentifier:_cellIdentify];
    if (_cell == nil)
    {
        _cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:_cellIdentify];
    }
    _cell.textLabel.text=[_resultData objectAtIndex:indexPath.row];
    return _cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *filePath=[NSString stringWithFormat:@"%@/%@",_path,[_resultData objectAtIndex:indexPath.row]];
    [self performSelectorOnMainThread:@selector(playMovieAtURL:) withObject:[NSURL fileURLWithPath:filePath] waitUntilDone:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)playMovieAtURL:(NSURL*)theURL
{
    MPMoviePlayerViewController *videoView=[[MPMoviePlayerViewController alloc] initWithContentURL:theURL];
    videoView.moviePlayer.scalingMode=MPMovieScalingModeAspectFill;
    videoView.moviePlayer.movieSourceType=MPMovieSourceTypeFile;
    [self presentMoviePlayerViewControllerAnimated:videoView];
}

- (void) startUpload:(id)sender
{
    NTHttpServiceViewController *view=[[NTHttpServiceViewController alloc] init];
    [self presentViewController:view animated:YES completion:nil];
}

#pragma mark - dealloc -
-(void)dealloc
{
    NSLog(@"===dealloc==%@",self.class);
}

@end
