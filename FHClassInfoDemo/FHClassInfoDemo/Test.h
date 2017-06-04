//
//  Test.h
//  FHClassInfoDemo
//
//  Created by 李浩 on 2017/6/3.
//  Copyright © 2017年 GodL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Test : NSObject

@property (nonatomic,assign,readonly) int age;

@property (nonatomic,assign) NSInteger age_integer;

@property (nonatomic,assign) char * c;

@property (nonatomic,assign) float height;

@property (nonatomic,copy) NSString *name;

@property (nonatomic,copy) NSDate *birthDay;

@property (nonatomic,copy) NSArray<NSString *> *borthers;

@end
