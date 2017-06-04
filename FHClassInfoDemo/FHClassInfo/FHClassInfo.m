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

@synthesize propertys = _propertys;
@synthesize superClassPropertys = _superClassPropertys;
@synthesize protocols = _protocols;

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

- (NSArray<NSString *> *)propertys {
    if (!_propertys) {
        _propertys = [self propertyListWithClass:self.cls];
    }
    return _propertys;
}

- (NSArray<NSString *> *)superClassPropertys {
    if (!_superClassPropertys) {
        _superClassPropertys = [self protocolListWithClass:self.superClass];
    }
    return _superClassPropertys;
}

- (NSArray<NSString *> *)protocols {
    if (!_protocols) {
        _protocols = [self protocolListWithClass:self.cls];
    }
    return _protocols;
}

- (NSArray<NSString *> *)propertyListWithClass:(Class)cls {
    uint32_t property_count = 0;
    objc_property_t *propertys = class_copyPropertyList(cls, &property_count);
    NSMutableArray<NSString *> *propertyNames = [NSMutableArray arrayWithCapacity:property_count];
    for (int i=0; i<property_count; i++) {
        objc_property_t property = propertys[i];
        NSString *propertyName = [NSString stringWithUTF8String:property_getName(property)];
        NSParameterAssert(propertyName);
        [propertyNames addObject:propertyName];
    }
    free(propertys);
    return [propertyNames copy];
}

- (NSArray<NSString *> *)protocolListWithClass:(Class)cls {
    uint32_t protocol_count = 0;
    Protocol * __unsafe_unretained *protocols = class_copyProtocolList(cls, &protocol_count);
    NSMutableArray<NSString *> *protocolNames = [NSMutableArray arrayWithCapacity:protocol_count];
    for (int i=0; i<protocol_count; i++) {
        Protocol *protocol = protocols[i];
        NSString *protocolName = [NSString stringWithUTF8String:protocol_getName(protocol)];
        NSParameterAssert(protocolName);
        [protocolNames addObject:protocolName];
    }
    free(protocols);
    return [protocolNames copy];
}

+ (instancetype)infoWithClass:(Class)cls {
    static CFMutableDictionaryRef classInfoCache = nil;
    static dispatch_semaphore_t lock;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        classInfoCache = CFDictionaryCreateMutable(CFAllocatorGetDefault(), 0, &kCFTypeDictionaryKeyCallBacks, &kCFTypeDictionaryValueCallBacks);
        lock = dispatch_semaphore_create(1);
    });
    FHClassInfo *classInfo = CFDictionaryGetValue(classInfoCache, (__bridge const void *)(cls));
    if (classInfoCache == nil) {
        dispatch_semaphore_wait(lock, DISPATCH_TIME_FOREVER);
        classInfo = [[self alloc] initWithClass:cls];
        NSParameterAssert(classInfo);
        CFDictionarySetValue(classInfoCache, (__bridge const void *)(cls), (__bridge const void *)(classInfo));
        dispatch_semaphore_signal(lock);
    }
    return classInfo;
}

+ (instancetype)infoWithClassName:(NSString *)name {
    return [self infoWithClass:NSClassFromString(name)];
}

@end
