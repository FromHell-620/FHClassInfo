//
//  ViewController.m
//  FHClassInfoDemo
//
//  Created by 李浩 on 2017/6/3.
//  Copyright © 2017年 GodL. All rights reserved.
//

#import "ViewController.h"
#import <objc/runtime.h>
#import "Test.h"
#import "FHClassInfo.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    FHClassInfo *info = [FHClassInfo infoWithClass:[Test class]];
    [info.propertysInfo enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, FHPropertyInfo * _Nonnull obj, BOOL * _Nonnull stop) {
        
    }];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
