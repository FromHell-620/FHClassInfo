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
        _propertys = [self propertyListWithClass:cls];
        _superClassPropertys = [self propertyListWithClass:_superClass];
        _protocols = [self protocolListWithClass:cls];
    }
    return self;
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
    return [[self alloc] initWithClass:cls];
}

+ (instancetype)infoWithClassName:(NSString *)name {
    return [self infoWithClass:NSClassFromString(name)];
}

@end
