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
@property (nonatomic, strong) UIButton *avFormatBtn;
@property (nonatomic, strong) UIButton *avCodec;
@property (nonatomic, strong) UIButton *avFilter;

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
    
    [self.avFormatBtn addTarget:self action:@selector(_avFormatAction) forControlEvents:UIControlEventTouchUpInside];
    
    [self.avCodec addTarget:self action:@selector(_avCodecAction) forControlEvents:UIControlEventTouchUpInside];
    
    [self.avFilter addTarget:self action:@selector(_avFilter) forControlEvents:UIControlEventTouchUpInside];
}

- (void)_avFilter{
    char info[4000000] = { 0 };
    avfilter_register_all();
    AVFilter *f_temp = (AVFilter *)avfilter_next(NULL);
    while (f_temp != NULL){ //????????
        sprintf(info, "%s[%10s]\n", info, f_temp->name);
    }
    //printf("%s", info);
    NSString * info_ns = [NSString stringWithFormat:@"%s", info];
    
    NSLog(@"avFilter: %@",info_ns);
}

- (void)_avCodecAction{
    char info[40000] = { 0 };
    
    av_register_all();
    
    AVCodec *c_temp = av_codec_next(NULL);
    
    while(c_temp!=NULL){
        if (c_temp->decode!=NULL){
            sprintf(info, "%s[Dec]", info);
        }
        else{
            sprintf(info, "%s[Enc]", info);
        }
        switch (c_temp->type){
            case AVMEDIA_TYPE_VIDEO:
                sprintf(info, "%s[Video]", info);
                break;
            case AVMEDIA_TYPE_AUDIO:
                sprintf(info, "%s[Audio]", info);
                break;
            default:
                sprintf(info, "%s[Other]", info);
                break;
        }
        sprintf(info, "%s%10s\n", info, c_temp->name);
        
        
        c_temp=c_temp->next;
    }
    //printf("%s", info);
    NSString * info_ns = [NSString stringWithFormat:@"%s", info];
    NSLog(@"avCodec: %@",info_ns);
}

- (void)_avFormatAction{
    char info[40000] = { 0 };
    
    av_register_all();
    
    AVInputFormat *if_temp = av_iformat_next(NULL);
    AVOutputFormat *of_temp = av_oformat_next(NULL);
    //Input
    while(if_temp!=NULL){
        sprintf(info, "%s[In ]%10s\n", info, if_temp->name);
        if_temp=if_temp->next;
    }
    //Output
    while (of_temp != NULL){
        sprintf(info, "%s[Out]%10s\n", info, of_temp->name);
        of_temp = of_temp->next;
    }
    //printf("%s", info);
    NSString * info_ns = [NSString stringWithFormat:@"%s", info];
    NSLog(@"avFormat: %@",info_ns);
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

    NSLog(@"protocal: %@",info_ns);
}

- (UIButton *)protocalBtn{
    if (_protocalBtn == nil) {
        _protocalBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, 100, 100, 30)];
        [_protocalBtn setTitle:@"Protocal" forState:UIControlStateNormal];
        [_protocalBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_protocalBtn setBackgroundColor:[UIColor grayColor]];
        [self.view addSubview:_protocalBtn];
    }
    return _protocalBtn;
}

- (UIButton *)avFormatBtn{
    if (_avFormatBtn == nil) {
        _avFormatBtn = [[UIButton alloc]initWithFrame:CGRectMake(10 + CGRectGetMaxX(self.protocalBtn.frame), 100, 100, 30)];
        [_avFormatBtn setTitle:@"avFormat" forState:UIControlStateNormal];
        [_avFormatBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_avFormatBtn setBackgroundColor:[UIColor grayColor]];
        [self.view addSubview:_avFormatBtn];
    }
    return _avFormatBtn;
}

- (UIButton *)avCodec{
    if (_avCodec == nil) {
        _avCodec = [[UIButton alloc]initWithFrame:CGRectMake(10 + CGRectGetMaxX(self.avFormatBtn.frame), 100, 100, 30)];
        [_avCodec setTitle:@"avCodec" forState:UIControlStateNormal];
        [_avCodec setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_avCodec setBackgroundColor:[UIColor grayColor]];
        [self.view addSubview:_avCodec];
    }
    return _avCodec;
}

- (UIButton *)avFilter{
    if (_avFilter == nil) {
        _avFilter = [[UIButton alloc]initWithFrame:CGRectMake(10, 10 + CGRectGetMaxY(self.avCodec.frame), 100, 30)];
        [_avFilter setTitle:@"avCodec" forState:UIControlStateNormal];
        [_avFilter setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_avFilter setBackgroundColor:[UIColor grayColor]];
        [self.view addSubview:_avFilter];
    }
    return _avFilter;
}


@end
