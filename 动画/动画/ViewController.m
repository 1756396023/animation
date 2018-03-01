//
//  ViewController.m
//  动画
//
//  Created by 牛辉 on 2017/9/20.
//  Copyright © 2017年 牛辉. All rights reserved.
//

#import "ViewController.h"
#import "ZHVideoMakerMusicIndicatorView.h"
#import <Masonry.h>
@interface ViewController ()

@property (nonatomic ,weak) ZHVideoMakerMusicIndicatorView *musicView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    ZHVideoMakerMusicIndicatorView *view = [[ZHVideoMakerMusicIndicatorView alloc] init];
    view.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).mas_offset(100);
        make.left.mas_equalTo(self.view).mas_offset(100);
        make.height.mas_equalTo(50);
        make.width.mas_equalTo(50);
    }];
    self.musicView = view;
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.musicView.state = ZHVideoMakerMusicIndicatorViewStatePlaying;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
