//
//  ViewController.m
//  XABlurEffectDemo
//
//  Created by 叶晓倩 on 2017/9/3.
//  Copyright © 2017年 xa. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIImage *image = [UIImage imageNamed:@"timg.jpg"];
    UIImageView *iv = [[UIImageView alloc] initWithImage:image];
    iv.frame = [UIScreen mainScreen].bounds;
    [self.view addSubview:iv];
    UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight];
    UIVisualEffectView *view = [[UIVisualEffectView alloc] initWithEffect:effect];
    view.frame = iv.frame;
    [self.view addSubview:view];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
