//
//  BascInfoVC.m
//  FFmpegDemo
//
//  Created by Tian,Nan on 2017/12/26.
//  Copyright © 2017年 Tian,Nan. All rights reserved.
//

#import "BascInfoVC.h"
#include <libavcodec/avcodec.h>
#include <libavformat/avformat.h>
#include <libavfilter/avfilter.h>

#include <stdio.h>

@interface BascInfoVC ()

@property (nonatomic, strong) UIButton *protocalBtn;

@end

@implementation BascInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self _initUI];
    
    av_register_all();
    char info[10000] = { 0 };
    printf("%s\n", avcodec_configuration());
    sprintf(info, "%s\n", avcodec_configuration());
    NSString * info_ns = [NSString stringWithFormat:@"%s", info];
    NSLog(@"------:%@",info_ns);
}

- (void)_initUI{
    [self.protocalBtn addTarget:self action:@selector(_protocalAction) forControlEvents:UIControlEventTouchUpInside];
}

- (void)_protocalAction{
    NSLog(@"输出现在的protocal基本信息");
    
    char info[40000]={0};
    av_register_all();
    
    struct URLProtocol *pup = NULL;
    //Input
    struct URLProtocol **p_temp = &pup;
    avio_enum_protocols((void **)p_temp, 0);
    while ((*p_temp) != NULL){
        sprintf(info, "%s[In ][%10s]\n", info, avio_enum_protocols((void **)p_temp, 0));
    }
    pup = NULL;
    //Output
    avio_enum_protocols((void **)p_temp, 1);
    while ((*p_temp) != NULL){
        sprintf(info, "%s[Out][%10s]\n", info, avio_enum_protocols((void **)p_temp, 1));
    }
    //printf("%s", info);
    NSString * info_ns = [NSString stringWithFormat:@"%s", info];

    NSLog(@"protocal----:%@",info_ns);
}

- (UIButton *)protocalBtn{
    if (_protocalBtn == nil) {
        _protocalBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, 100, 100, 30)];
        [_protocalBtn setTitle:@"Protocal" forState:UIControlStateNormal];
        [_protocalBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.view addSubview:_protocalBtn];
    }
    return _protocalBtn;
}

@end
