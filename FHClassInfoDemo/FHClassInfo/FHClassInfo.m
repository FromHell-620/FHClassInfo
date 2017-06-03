//
//  FHClassInfo.m
//  FHClassInfoDemo
//
//  Created by 李浩 on 2017/6/3.
//  Copyright © 2017年 GodL. All rights reserved.
//

#import "FHClassInfo.h"
#import <objc/runtime.h>

@implementation FHPropertyInfo

- (instancetype)initWithProperty:(objc_property_t)property {
    if (property == NULL) {
        @throw [NSException exceptionWithName:NSInvalidArgumentException reason:@"this method should receive a property" userInfo:nil];
        return nil;
    }
    self = [super init];
    if (self) {
        _objc_property = property;
        _name = [NSString stringWithUTF8String:property_getName(property)];
    }
    return self;
}

@end

@implementation FHClassInfo

- (instancetype)init {
    @throw [NSException exceptionWithName:NSInvalidArgumentException reason:@"this method should receive a class object" userInfo:nil];
    return [self initWithClass:nil];
}

- (instancetype)initWithClass:(Class)cls {
    if (cls == nil) return nil;
    self = [super init];
    if (self) {
        _cls = cls;
        _superClass = class_getSuperclass(cls);
    }
    return self;
}

+ (instancetype)infoWithClass:(Class)cls {
    return [[self alloc] initWithClass:cls];
}

+ (instancetype)infoWithClassName:(NSString *)name {
    return [self infoWithClass:NSClassFromString(name)];
}

@end
