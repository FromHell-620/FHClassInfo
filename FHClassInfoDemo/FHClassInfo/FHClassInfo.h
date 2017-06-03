//
//  FHClassInfo.h
//  FHClassInfoDemo
//
//  Created by 李浩 on 2017/6/3.
//  Copyright © 2017年 GodL. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FHClassInfo : NSObject

@property (nonatomic,readonly) Class cls;

- (instancetype)initWithClass:(Class)cls NS_DESIGNATED_INITIALIZER;

+ (instancetype)infoWithClass:(Class)cls;

@end

NS_ASSUME_NONNULL_END
