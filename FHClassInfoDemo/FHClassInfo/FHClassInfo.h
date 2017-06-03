//
//  FHClassInfo.h
//  FHClassInfoDemo
//
//  Created by 李浩 on 2017/6/3.
//  Copyright © 2017年 GodL. All rights reserved.
//

#import <Foundation/Foundation.h>
@import ObjectiveC.runtime;

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger,FHPropertyEncodingType) {
    FHPropertyEncodingTypeUnknow,
    FHPropertyEncodingTypeBool,
    FHPropertyEncodingTypeInt,
    FHPropertyEncodingTypeLong,
    FHPropertyEncodingTypeFloat,
    FHPropertyEncodingTypeDouble,
    FHPropertyEncodingTypeObject
};

typedef NS_ENUM(NSInteger,FHPropertyObjectEncodingType) {
    FHPropertyObjectEncodingTypeNonsupport = 0xFF,
    FHPropertyObjectEncodingTypeNSString,
    FHPropertyObjectEncodingTypeNSNumber,
    FHPropertyObjectEncodingTypeNSData,
    FHPropertyObjectEncodingTypeNSDate,
    FHPropertyObjectEncodingTypeNSArray,
    FHPropertyObjectEncodingTypeNSDictionary,
    FHPropertyObjectEncodingTypeNSURL,
    FHPropertyObjectEncodingTypeUIImage
};

@interface FHPropertyInfo : NSObject

@property (nonatomic,assign,readonly) objc_property_t objc_property;

@property (nonatomic,copy,readonly) NSString *name;

@property (nonatomic,copy,readonly) NSString *type;

@property (nonatomic,assign,readonly) FHPropertyEncodingType typeEncoding;

@property (nonatomic,assign,readonly) FHPropertyObjectEncodingType objectTypeEncoding;

@property (nonatomic,assign,readonly) SEL getter;

@property (nonatomic,assign,readonly) SEL setter;

- (instancetype)initWithProperty:(objc_property_t)propertyNS_DESIGNATED_INITIALIZER;

@end

@interface FHClassInfo : NSObject

@property (nonatomic,assign,readonly) Class cls;

@property (nonatomic,assign,readonly) Class superClass;

@property (nonatomic,copy,readonly) NSArray<NSString *> *protocols;

- (instancetype)initWithClass:(Class)cls NS_DESIGNATED_INITIALIZER;

+ (instancetype)infoWithClass:(Class)cls;

+ (instancetype)infoWithClassName:(NSString*)name;

@end

NS_ASSUME_NONNULL_END
