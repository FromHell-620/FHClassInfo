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

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    int count = 0;
    objc_property_t * list = class_copyPropertyList([Test class], &count);
    for (int i=0; i<count; i++) {
        objc_property_t property = list[i];
        int j = 0;
        objc_property_attribute_t *t = property_copyAttributeList(property, &j);
        for (int k =0; k<j; k++) {
            objc_property_attribute_t a = t[k];
            NSLog(@"%s   %s",a.name,a.value);
        }
    }
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
