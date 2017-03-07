//
//  AccountCreator.m
//  iosGuide
//
//  Created by Elijah Cobb on 2/18/17.
//  Copyright © 2017 Apollo Technology. All rights reserved.
//

#import "AccountCreator.h"

@implementation AccountCreator

+(instancetype)user{
    static AccountCreator *sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[[self class] alloc] init];
    });
    return sharedManager;
}

@end
