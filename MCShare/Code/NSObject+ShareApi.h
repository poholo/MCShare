//
//  NSObject+ShareApi.h
//  Bull
//
//  Created by majiancheng on 2018/7/14.
//  Copyright © 2018年 poholo Inc. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSObject (ShareApi)

- (void)apiGetShareHost:(NSString *)type callBack:(void (^)(BOOL success, NSDictionary *dict))callBack;

@end
