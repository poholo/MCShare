//
// Created by 赵江明 on 15/11/11.
// Copyright (c) 2015 poholo Inc. All rights reserved.
//

#import "MCDto.h"

@implementation MCDto

+ (__kindof MCDto *)createDtoId {
    MCDto *dto = [self new];
    dto.dtoId = [NSUUID new].UUIDString;
    return dto;
}

+ (instancetype)createDto:(NSDictionary *)dict {
    MCDto *dto = [self new];
    [dto setValuesForKeysWithDictionary:dict];
    return dto;
}

+ (instancetype)createWithDict:(NSDictionary *)dict {
    MCDto *dto = [self new];
    return dto;
}

- (NSString *)entityId {
    return self.dtoId;
}

- (void)changeDto:(NSDictionary *)dict {
    [self setValuesForKeysWithDictionary:dict];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    if ([key isEqualToString:@"id"]) {
        self.dtoId = value;
    }
}

- (id)valueForUndefinedKey:(NSString *)key {
    return nil;
}

- (BOOL)isOriginEqual:(id)other {
    return [super isEqual:other];
}

- (BOOL)isEqual:(id)other {
    if (other == self)
        return YES;
    if (!other || ![[other class] isEqual:[self class]])
        return NO;

    return [self isEqualToDto:other];
}

- (BOOL)isEqualToDto:(MCDto *)dto {
    if (self == dto)
        return YES;
    if (dto == nil)
        return NO;
    return !(self.dtoId != dto.dtoId && ![self.dtoId isEqualToString:dto.dtoId]);
}

- (NSUInteger)hash {
    return [self.dtoId hash];
}

@end
