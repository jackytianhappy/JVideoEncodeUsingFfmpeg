//
//  ViewController.m
//  FFmpegDemo
//
//  Created by Tian,Nan on 2017/12/26.
//  Copyright © 2017年 Tian,Nan. All rights reserved.
//

#import "ViewController.h"
#include <libavcodec/avcodec.h>
#include <libavformat/avformat.h>
#include <libavfilter/avfilter.h>

#include "BascInfoVC.h"


static NSString *indetifier = @"MyFFmpegDemoCell";

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>{
    NSArray *dataArray;
}

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSLog(@"avcodec的配置: %s",avcodec_configuration());
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self initData];
}

- (void)initData{
    
    dataArray = @[
                  NSStringFromClass([BascInfoVC class])
                  ];
}



#pragma mark - Delegate And DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return dataArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:indetifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indetifier];
    }
    
    cell.textLabel.text = dataArray[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
     UIViewController *vc = [[NSClassFromString(dataArray[indexPath.row]) alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - lazy load
- (UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
        [self.view addSubview:_tableView];
    }
    return _tableView;
}


@end
