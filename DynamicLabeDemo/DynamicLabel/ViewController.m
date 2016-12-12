//
//  ViewController.m
//  DynamicLabel
//
//  Created by henvy on 12/12/2016.
//  Copyright © 2016 henvy. All rights reserved.
//

#import "ViewController.h"
#import "DynamicLabel.h"

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

    DynamicLabel* tl = [[DynamicLabel alloc] initWithFrame:CGRectMake(100, 300, 200, 21)];
    tl.speed = 0.5;
    tl.text = @"这是一个动态lable测试demo,这是一个动态lable测试demo";
    tl.textColor = [UIColor whiteColor];
    tl.font = [UIFont systemFontOfSize:20];
    tl.backgroundColor = [UIColor darkGrayColor];
    [self.view addSubview:tl];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
